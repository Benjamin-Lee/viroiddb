#!/bin/bash
#hostname

Sealsoader
cd /media/HDD1/uri/RNA_Vir_MTs/viroiddb/viroiddb/Neri/

THREADS=10
MCL_inflation=1.6

awk '{ if ($3 < 0.00000000000000000000000000000001) { print } }'  CviroidDB.tsv|   uniq > Culled.tsv ### Instead, used R to filter based on several conditions.
mcxload -abc Culled.tsv  --stream-mirror --stream-neg-log10 -stream-tf "ceil(200)" -o VDB_allByAll_blastp.mci -write-tab VDB_allByAll_blastp.tab

mcl VDB_allByAll_blastp.mci -use-tab VDB_allByAll_blastp.tab -I "$MCL_inflation" -o VDB_allByAll_blast_Infl_"$MCL_inflation".mcl -t "$THREADS" 


#!/bin/bash
# hostname

##################################################################################################
usage() {
echo ' 
Written by Uri Neri and Benjamin Lee.
Last modified 13.06.2021
Contact: Uri.Neri@gmail.com
Description:  One script to cluster them all.
Input is all.fasta from ViroidDB, output is 5 folders, 3 directories of easy-linclust at 95,85,75 ID%, and 2 folders for MCL clustering based on all vs all.
(single fasta file or directory of MSAs) with amino acid sequences, the seqs perclsutered (CD-HIT) --> "ALL vs ALL" (DIAMOND BLASTp) --> clustered (MCL) --> aligned (MUSCLE) --> Formatted as DBs.
Output directory should contain HMMdb (HMMER), HHMs (hh-suite) and MMseqs profile db.
*.env file specifics the given argument. See https://github.com/UriNeri/Fasta2ProfileDBs for more information.
Usage example: bash Profiler.sh -t 11 -M 4800 -o /output/ -i /input.faa -s " 0.0000001, 40, 0.82, 0 " -d 0.99 -c 0.999 -f 1.4 -N 2 -p True -L True -P Vfin.mot.1 -k False -a True -r False

Arguments: (Not all will be used, this is just my template)
#	Desc (suggestion) [default]
-t	Threads (all) [2]
-M	Memory in Mb (more) [2000]  
-o	output directory (...) [pwd]
-i	Input fasta file ([all.fasta])  
-s	Watermark to be printed to .env file on completeion.
-d	Minimal id for clustering sequence collapsing [(0.9)]
-c	Minimal coverage for clustering [(0.75)] 
-R	(try to) Rotate output via CSA? [(True)]
-f	MCL inflation [(3.6)] See MCL manuaul for more info; tl;dtr # -I Sets the main inflation value to <num>. This value is the main handle for affecting cluster granularity. It is usually chosen somewhere in the range [1.2-5.0]. -I 5.0 will tend to result in fine-grained clusterings, and -I 1.2 will tend to result in very coarse grained clusterings. Your mileage will vary depending on the characteristics of your data. That is why it is a good idea to test the quality and coherency of your clusterings using clm dist and clm info. This will most likely reveal that certain values of -I are simply not right for your data. The clm dist section contains a discussion of how to use the cluster validation tools shipped with mcl (see the SEE ALSO section). With low values for -I, like -I 1.2, you should be prepared to use more resources in order to maintain quality of clusterings.
-P Output clusters prefix (Iter_ID / set_ID)
-m Align rotated clusters? [(True)]
-a Add consenus to MSAs? [(True)]
-k Skip clustering and alignment and treat -i as the input dir with existing MSAs? [(False)]
-r Remove tmps? ([False])
-S Use Mafft? ([False])
-H add secondary structures? (need a useable addss.pl, for hhm profiles only)

Dependencies:
CSA, MUSCLE, MCL, gnu parallel, Seals-2, MMseqs2, mafft, awk, NCBI-BLAST, seqkit 

'
exit 
}

if [[ $# -eq 0 ]] ; then
usage
exit
fi


##################################################################################################

##### Set defaults: #####
THREADS=2 #t
output_dir=$(pwd) #o
params='(0.0000000001 70 0.5 300)  [<E-value,score1/score/bits,min_alignment_coverage,qlen>]' #s
input_fasta='input.faa' #i
rm_tmp="False" #r
Memory=2000 #M
min_prec_id=0.90  #d
min_prec_cov=0.75 #c
MCL_inflation=3.6 #f
min_nseq=2 #N
Precluster=True #p
Max_sensitivity=True #x
Cls_Prefix=set_ID #P
Use_singlt=True #L
SkipCA=False #k
AddCons=True #a
Use_Mafft=False
AddSs=True

##### Parse args: #####
while getopts t:k:N:i:r:M:d:c:f:N:p:x:P:L:k:a:s:o:S:H: flag
do
case "${flag}" in
t) THREADS=${OPTARG};;
o) output_dir=${OPTARG};;
s) params=${OPTARG};;
i) input_fasta=${OPTARG};;
M) Memory=${OPTARG};;
d) min_prec_id=${OPTARG};;
c) min_prec_cov=${OPTARG};;
f) MCL_inflation=${OPTARG};;
N) min_nseq=${OPTARG};;
P) Cls_Prefix=${OPTARG};;
p) Precluster=${OPTARG};;
L) Use_singlt=${OPTARG};;
k) SkipCA=${OPTARG};;
a) AddCons=${OPTARG};;
r) rm_tmp=${OPTARG};;
S) Use_Mafft=${OPTARG};;
H) AddSs=${OPTARG};;
 *) print "Parsed ${flag}"
#  *) usage
esac
done

Mandatory arguments
# if [ ! "$input_fasta" ] || [ ! "$VM" ]; then
if [ ! "$input_fasta" ] ; then
echo "arguments -i must be provided"
usage
fi

##################################################################################################

##### Dependency cheakcer (Seals2, HHsuite and openMPI...): #####
Dependency_List=(awk cd-hit hhmake fa2sr sr_filter sr2fa hmmbuild mmseqs ffindex_build ffindex_order mcxload parallel)
i=0
for dpnc in ${Dependency_List[*]}
do
$dpnc -V &>/dev/null # ← put the command whos exit code you want to check here &>/dev/null
if [ $? -eq 127 ]; then
echo "$dpnc Not Found! exiting"
break
exit  
else
echo "$dpnc  Found! "
i=$((i+1))
fi
if (( $i == ${#Dependency_List[@]} )) ;
then
break
fi
done


##### Main #####
input_fasta=$(echo $(readlink -f $input_fasta)  ) # Get abs path.
mkdir "$output_dir"
cd "$output_dir"
mkdir msaFiles singletons fastaFiles HHMfiles logs HMMfiles MMseqs2_profiles Clusteringfiles tmpmsa

##### In case arg -k==False, not skipping preclustering, clustering, and alignment #####
if [ "$SkipCA" == "False" ]; 
then
##### Create output/work dirs and make a copy of the input #####
ini_name=$(basename "$input_fasta" ".faa")
cd "$output_dir"
cp "$input_fasta" ./"$ini_name".faa
input_fasta="$output_dir"/"$ini_name".faa
mkdir msaFiles singletons fastaFiles HHMfiles logs HMMfiles MMseqs2_profiles Clusteringfiles 

##### Precluster using CD-HIT #####
if [ "$Precluster" == "True" ]; 
then
mkdir preclusters
cd-hit -n 3 -M "$Memory" -T "$THREADS"  -i "$input_fasta" -o preclusters/"$ini_name"_c"$min_prec_id" -aS "$min_prec_cov" -c "$min_prec_id" 
input_fasta="$output_dir"/preclusters/"$ini_name"_c"$min_prec_id" 
fi

##### Preform an "all vs all" search of all the input protein seqs using DIAMOND BLASTp#####
cd Clusteringfiles
if [ "$Max_sensitivity" == "True" ]; 
then
diamond blastp -q "$input_fasta" -o "$ini_name"_allByAll_blastp.br --db "$input_fasta" --outfmt 6  --more-sensitive  --threads "$THREADS" 
fi
if [ "$Max_sensitivity" == "False" ]; # Keep different IFs, (might change to NCBI BLASTp option later).
then
diamond blastp -q "$input_fasta" -o "$ini_name"_allByAll_blastp.br --db "$input_fasta" --outfmt 6   --threads "$THREADS" 
fi
##### Transfrom BLASTp outfmt 6 into abc format (query_seqid subject_seqid E_value) #####
awk '{print $1,$2,$11}' "$ini_name"_allByAll_blastp.br  >  "$ini_name"_allByAll_blastp.abc
##### Compute cluster using the Markov Cluster Algorithm (MCL)  #####
mcxload -abc "$ini_name"_allByAll_blastp.abc --stream-mirror --stream-neg-log10 -stream-tf "ceil(200)" -o "$ini_name"_allByAll_blastp.mci -write-tab "$ini_name"_allByAll_blastp.tab
mcl "$ini_name"_allByAll_blastp.mci -use-tab "$ini_name"_allByAll_blastp.tab -I "$MCL_inflation" -o "$ini_name"_allByAll_blastp.mcl -t "$THREADS" 

##### Split the input fasta with all protein seqs into subsets based on the MCL clusters members #####
if [ $(which seqkit 2>/dev/null) ];
then
i=0
echo "seqkit found, using that"
while IFS="" read -r p || [ -n "$p" ]
do
i=$((i+1))
cls_mems=$(printf '%s'"$p")
cls_mems1=$(sed  's/ /'',''/g' <<< $(echo $cls_mems))
seqkit grep "$input_fasta" -p "$cls_mems1" -w 0  -j "$THREADS" > "$Cls_Prefix"."$i".faa
done < "$ini_name"_allByAll_blastp.mcl
else 
i=0
# Possible redundancy/bug in the next loop (output still useable).
echo "seqkit not found, using awk"
while IFS="" read -r p || [ -n "$p" ]
do
i=$((i+1))
cls_mems=$(printf '%s' "$p")
sed  's/ /''\n>''/g' <<< $(echo $cls_mems) >cls_mems1
awk 'BEGIN{RS=">";FS="\n"}NR==FNR{a[$1]++}NR>FNR{if ($1 in a && $0!="") printf ">%s",$0}' cls_mems1 "$input_fasta" > "$Cls_Prefix"."$i".faa
done < "$ini_name"_allByAll_blastp.mcl
rm cls_mems1
fi

##### Identify clusters with only 1 member ("singletons"), and based on the arg -L, exclude/keep the singletons from the profile building #####
singlist=$(grep ">" -F ./*.faa -c | grep ":1$"  |  sed  's/':1'/ /g' | sed  's|/\n||g')
if [ "$Use_singlt" == "True" ]; 
then
cp $singlist ../singletons/
min_nseq=2
else
mv $singlist ../singletons/
fi
cat ../singletons/* > ../singletons.faa

### Filter faa's based on the arg -N, so that Nseq < min_nseq ###
if (( $min_nseq > 2)); # 
then
mkdir ../NotEnoughSeqs
grep ">" -F ./*.faa -c |  sed  's/':'/\t/g' > nseqtbl
echo "$(echo $(awk  -FS=\t -v nseq=$min_nseq '$2 < nseq || NR==1' nseqtbl ))"  | sed  's/ .[0-9]* / /g' > Nseqtbl
mv $(cat Nseqtbl) ../NotEnoughSeqs/
rm nseqtbl
fi

### Align each cluster using MUSCLE ###
if [ "$Use_Mafft" != "True" ]; 
then
parallel -j"$THREADS" muscle -in {} -out {.}.msa.faa -log {.}.faa.log -quiet -maxmb "$Memory" ::: ./*.faa
fi

if [ "$Use_Mafft" == "True" ]; 
then
for i in ./*.faa
do
file_with_suffix=$(basename "$i") 
file_name=$(basename "$file_with_suffix" ".faa")
mafft --thread "$THREADS" --auto $i   >  ../msaFiles/"$file_name".msa.faa 
done 
fi

mv ./*.log ../logs
mv ./*.msa.faa ../msaFiles/ 

cd ../

fi #SkipCA=="False"

##### In case arg -k==True, skip preclustering, clustering, and alignment, and use input -i as a directory with existing clusters already aligned #####
if [ "$SkipCA" == "True" ]; #Need to test - so far used "Profiler_motifs_from_MSAs.sh"
then
cp "$input_fasta"/* ./msaFiles/
fi

##### Begin creating the profiles. #####
for i in ./msaFiles/*.faa
do
file_with_suffix=$(basename "$i") 
file_name=$(basename "$file_with_suffix" ".msa.faa")
##### Based on the arg -a, add a consenus sequence on top of each alignment (if -N==1, will also add "useless" consenues on top of degenerate, single sequence clusters). #####
if [ "$AddCons" == "True" ]; 
then
cat $i | fa2sr -w=0 |sr_filter -conplus -hcon=0 -ncon="$file_name"_con | sr2fa > ./msaFiles/"$file_name".Cons.msa.faa
fi
if [ "$AddCons" == "False" ]; 
then
cat $i | fa2sr -w=0  | sr2fa > ./msaFiles/"$file_name".Cons.msa.faa # Keeping the name suffix for now, this line is not needed. TODO: modify next lines to accpet both .Cons. and regular intelligently. 
fi

##### Create HHM/HMM profiles using HH-suite and HMMER. #####
hmmbuild --informat afa -n "$file_name" -o logs/"$file_name".hmm.log HMMfiles/"$file_name".hmm  ./msaFiles/"$file_name".Cons.msa.faa

if [[ "$AddSs" == "False"  ]]; then
  hhmake -v 2 -name "$file_name" -i ./msaFiles/"$file_name".Cons.msa.faa -o ./HHMfiles/"$file_name".hhm -v 0  -id 100 -diff inf -M first
fi
if [[ "$AddSs" == "True"  ]]; then
  addss.pl ./msaFiles/"$file_name".Cons.msa.faa  ./msaFiles/"$file_name".Cons.msa.a3m -fas
    hhmake -v 2 -name "$file_name" -i ./msaFiles/"$file_name".Cons.msa.a3m -o ./HHMfiles/"$file_name".hhm   -id 100 -diff inf -M 
fi
done 

##### Index, and format what's needed to use the HHM (HH-suite) profile as a single DB. #####
ffindex_build "$Cls_Prefix"_p.hhm "$Cls_Prefix"_p.hhm.index ./HHMfiles/*.hhm

##### Create "hhinfo.tsv" tab seprated table with the name of each cluster/profile, the number of sequences it was made from, and its effective number (Neff). #####
grep -a -F "NEFF  " "$Cls_Prefix"_p.hhm | nl |awk -F'\tNEFF' '{print $1 $2}' > neffs.txt
grep -a -F "NAME  " "$Cls_Prefix"_p.hhm | nl |awk -F'\tNAME' '{print $1 $2}' > names.txt
grep -a "FILT  [0-9]" "$Cls_Prefix"_p.hhm |nl |awk -F'\tFILT' '{print $1 $2}' | awk -F' ' '{print $1 "\t" $2}' > nseq.txt
echo -e 'cls\tneff\tnseq' > hhinfo.tsv
join -1 1 -2 1 names.txt neffs.txt | join -1 1 -2 1 - nseq.txt | awk  '{print $2 "\t" $3 "\t" $4}' >> hhinfo.tsv
rm neffs.txt names.txt nseq.txt

##### Create mmseqs DB using the hhmDB from above. #####
mmseqs convertprofiledb "$Cls_Prefix"_p.hhm ./MMseqs2_profiles/"$Cls_Prefix"_MM

##### Concatenate the HMM (HMMER) profiles into a single hmmDB. #####
cat ./HMMfiles/*.hmm > "$Cls_Prefix"_p.hmm

##### Print the hmmDB profile statics. #####
hmmstat "$Cls_Prefix"_p.hmm > "$Cls_Prefix"_p_hmmstat.tsv
mv ./*.log ./logs/

##### Continue processing the data for the hhdb. #####
mkdir tmpmsa hhdb
if [[ "$AddSs" == "False"  ]]; then
  cp ./msaFiles/*Cons* ./tmpmsa/
  cd ./tmpmsa/
  for i in ./*faa
  do
    mv "$i" $(basename "$i" .faa).fas
    reformat.pl $(basename "$i" .faa).fas $(basename "$i" .faa).a3m
  done
  rm ./*fas
fi

if [[ "$AddSs" == "True"  ]]; then
  cp ./msaFiles/*Cons*.a3m ./tmpmsa/
  cd ./tmpmsa/
fi

ffindex_build -s ../hhdb/db_msa.ff{data,index} .

cd ../hhdb/
mpirun -np 1 ffindex_apply db_msa.ff{data,index} \
-i db_hhm.ffindex -d db_hhm.ffdata -- hhmake -i stdin -o stdout -v 0

mpirun -np 1 cstranslate -x 0.3 -c 4 -I a3m -i db_msa -o db_cs219 -f

sort -k3 -n -r db_cs219.ffindex | cut -f1 > sorting.dat
ffindex_order sorting.dat db_hhm.ff{data,index} db_hhm_ordered.ff{data,index}
mv db_hhm_ordered.ffindex db_hhm.ffindex
mv db_hhm_ordered.ffdata db_hhm.ffdata

ffindex_order sorting.dat db_msa.ff{data,index} db_a3m_ordered.ff{data,index}
mv db_a3m_ordered.ffindex db_a3m.ffindex
mv db_a3m_ordered.ffdata db_a3m.ffdata

cd ../

##### Lineraize the MSAs as per our conventions. #####
cd msaFiles
for i in ./*.faa 
do
awk 'BEGIN{RS=">";FS="\n"}NR>1{seq="";for (i=2;i<=NF;i++) seq=seq""$i; print ">"$1"\n"seq}' "$i" > temp.faa
cat temp.faa > "$i"
done
rm temp.faa 
cd ../
##### Based on arg -r, remove intermediate files/dirs. #####
if [ "$rm_tmp" != "False" ]; 
then
rm tmpmsa -r
fi


##### Create a summary file for the script call. #####
echo "Printing params to $(pwd)/params.txt"
echo "Profiler_motifs.sh called on $(date) by: " >  "$Cls_Prefix"_profiler.env
echo "$@" >> "$Cls_Prefix"_profiler.env

Nsingletons=$(grep ">" singletons.faa -c)
Nprofiles=$(grep "NAME" "$Cls_Prefix"_p.hmm -c)
echo "Enviroment/Flags called:
THREADS = $THREADS
output_dir = $output_dir
Water_mark = $(echo ${params[*]}) [<E-value,score1,min_alignment_coverage,qlen>] 
input = $input_fasta
rmemove tmps = $rm_tmp
Memory = $Memory
Preclustering id >= $min_prec_id 
Preclustering coverage >= $min_prec_cov 
MCL inflation = $MCL_inflation 
Minimum seqs per cluster = $min_nseq
Precluster = $Precluster 
Diamond_Max_sensitivity = $Max_sensitivity 
Output_clusters_prefix = $Cls_Prefix
Use singletons = $Use_singlt 
Skip clustering and alignments  = $SkipCA
Add consenus = $AddCons 
Nprofiles = $Nprofiles 
Nsingletons = $Nsingletons 
" >> "$Cls_Prefix"_profiler.env

echo "Done: $Cls_Prefix"
echo "Note! the resulting profiles may not be ideal for all use cases."
