#!/bin/bash
# hostname

##################################################################################################
Sealsoader # PATH !!!!
usage() {
echo ' 
Written by Uri Neri and Benjamin Lee.
Last modified 13.06.2021
Contact: Uri.Neri@gmail.com
Description:  One script to cluster them all.
Input is all.fasta from ViroidDB, output folder the output of easy-linclust at <-d> ID% and <c> Cov%. 
In the output dir, the clusters are rotated and aligned per each cluster representative (longest member), then aligned and overlayed with predicted secondary structures.
*.env file specifics the given argument. 
Usage example: bash Clustem.sh -t 11 -M 4800 -o /output/ -i /input.faa -s "Watermark" -d 0.99 -c 0.999 -N 2 -m True -P "cls_"  -a True -r False -R True -H True 

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
-P	Output clusters prefix 
-m	Align rotated clusters? [(True)]
-a	Add consenus to MSAs? [(True)]
-r	Remove tmps? ([False])
-H	Add secondary structures? (via R DECHIPER package) [(True)]

Dependencies:
CSA, gnu parallel, Seals-2, MMseqs2, mafft, awk, NCBI-BLAST, seqkit, DECHIPER, cd-hit

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
Memory=2000 #M
output_dir=$(pwd) #o
input_fasta='All.fasta' #i
Water_Mark=$(date) #s
min_prec_id=0.90  #d
min_prec_cov=0.75 #c
Attempt_Rotation=True #R
Align_Rotated=True #m
Cls_Prefix=Cls.ID"$min_prec_id".Cov"$min_prec_cov". #P
AddCons=True #a
rm_tmp="False" #r
AddSs=True #H
AddHMMs=True # TBD
##### Parse args: #####
while getopts t:o:s:i:M:d:c:P:m:a:r:S:H:v:R: flag
do
case "${flag}" in
t) THREADS=${OPTARG};;
o) output_dir=${OPTARG};;
s) Water_Mark=${OPTARG};;
i) input_fasta=${OPTARG};;
M) Memory=${OPTARG};;
d) min_prec_id=${OPTARG};;
c) min_prec_cov=${OPTARG};;
P) Cls_Prefix=${OPTARG};;
m) Align_Rotated=${OPTARG};;
a) AddCons=${OPTARG};;
r) rm_tmp=${OPTARG};;
S) Use_Mafft=${OPTARG};;
H) AddSs=${OPTARG};;
v) Use_CDHIT=${OPTARG};;
R) Attempt_Rotation=${OPTARG};;
 # *) print "Parsed ${flag}"
 *) usage
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
Dependency_List=(awk fa2sr sr_filter mmseqs seqkit cd-hit mafft)
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
##### Create output/work dirs and make a copy of the input #####
ulimit -Sv $((Memory * 1000)) # Mb to Kb
ulimit -Sm $((Memory * 1000)) # Mb to Kb

input_fasta=$(echo $(readlink -f $input_fasta)  ) # Get abs path.
mkdir "$output_dir"
cd "$output_dir"
mkdir msaFiles Clusteringfiles 
ini_name=$(basename "$input_fasta" ".fasta")
cp "$input_fasta" ./"$ini_name".fasta
input_fasta="$output_dir"/"$ini_name".fasta


##### Cluster using mmseqs linclust #####
cd Clusteringfiles
mmseqs easy-linclust "$input_fasta" "$ini_name".clu tmp --min-seq-id "$min_prec_id"  -c "$min_prec_cov" --seq-id-mode 1 --cov-mode 0 --kmer-per-seq-scale 0.3  --threads "$THREADS"   --split-memory-limit "$Memory"M 

# alias Rsplt='Rscript /media/HDD1/uri/RNA_Vir_MTs/viroiddb/viroiddb/Neri/Clustem_rsp.r' # PATH !!!!

cd "$output_dir"
Rscript /media/HDD1/uri/RNA_Vir_MTs/viroiddb/viroiddb/Neri_misc/Clustem_rsp.r $input_fasta "$output_dir"/Clusteringfiles/"$ini_name".clu_cluster.tsv $Cls_Prefix
mv "$output_dir"/Clusteringfiles/cluster_membership/ "$output_dir"/cluster_membership/
mv "$output_dir"/cluster_membership/Cluster_membership.tsv "$output_dir"/Cluster_membership.tsv
cd "$output_dir"

##### Rotate #####
if [ "$Attempt_Rotation" == "True" ]; 
then
mkdir Rotated
mkdir Rotated/CSA_csv Rotated/CSA_aligned Rotated/CSA_rotated Rotated/CSA_Misc
for i in "$output_dir"/cluster_membership/*.fasta
do
file_with_suffix=$(basename "$i") 
file_name=$(basename "$file_with_suffix" ".fasta")
timeout 13 CSA  $i
done 
mv "$output_dir"/cluster_membership/*.csv Rotated/CSA_csv/
mv "$output_dir"/cluster_membership/*.txt Rotated/CSA_Misc/
mv "$output_dir"/cluster_membership/*.bmp Rotated/CSA_Misc/
mv "$output_dir"/cluster_membership/*-Rotated.fasta Rotated/CSA_rotated/
mv "$output_dir"/cluster_membership/*-Aligned.fasta Rotated/CSA_aligned/
fi
cd "$output_dir"


### Rotate attempt 2# - using cyclope for clusters CSA couldn't ###
for i in "$output_dir"/cluster_membership/*.fasta
do
file_with_suffix=$(basename "$i") 
file_name=$(basename "$file_with_suffix" ".fasta")
FILE="$output_dir"/Rotated/CSA_aligned/"$file_name"-Aligned.fasta

if [ -f "$FILE" ]; then
    echo "CSA Rotated output found  - $FILE"
    cp $FILE "$output_dir"/msaFiles/"$file_name"_msa.fasta
else 
    echo "CSA Rotated output NOT found  - $FILE"
    timeout 11 cyclope -C -a -v -o -s -O "$output_dir"/msaFiles/"$file_name"_msa.fasta $i 
fi
done 
find "$output_dir"/msaFiles/ -size  0 -print -delete
cd "$output_dir"



### re-Align each cluster using mafft ###
for i in "$output_dir"/cluster_membership/*.fasta
do
file_with_suffix=$(basename "$i") 
file_name=$(basename "$file_with_suffix" ".fasta")

FILE="$output_dir"/msaFiles/"$file_name"_msa.fasta
if [ -f "$FILE" ]; then
    echo "CSA/cyclope Rotated output found"
    mafft --thread "$THREADS" --auto "$FILE"   >  "$output_dir"/msaFiles/"$file_name"_mafft_msa.fasta
else
    echo "CSA/cyclope Rotated output NOT found"
    mafft --thread "$THREADS" --auto $i   > "$output_dir"/msaFiles/"$file_name"_mafft_msa.fasta
fi
done 
find "$output_dir"/msaFiles/*_mafft_msa.fasta -size  0 -print -delete
cd "$output_dir"

##### Add consenus and secondary structure #####
if [ "$AddCons" == "True" ]; 
then
for i in "$output_dir"/msaFiles/*_mafft_msa.fasta
do
file_with_suffix=$(basename "$i") 
file_name=$(basename "$file_with_suffix" "_mafft_msa.fasta")
cat $i | fa2sr -w=0 |sr_filter -conplus -hcon=0 -ncon="$file_name"_con | sr2fa >  "$output_dir"/msaFiles/tmp
mv "$output_dir"/msaFiles/tmp "$output_dir"/msaFiles/"$file_name"_conp_mafft_msa.fasta
done 
mkdir "$output_dir"/FinalCluster_MSAs
mv "$output_dir"/msaFiles/*_conp_mafft_msa.fasta "$output_dir"/FinalCluster_MSAs/
fi


##### Build nhmm profeils (HMMER v3.3) #####
# if [ "$AddHMMs" == "True" ];
# then
mkdir "$output_dir"/HMMfiles
for i in "$output_dir"/FinalCluster_MSAs/*.fasta
do
file_with_suffix=$(basename "$i") 
file_name=$(basename "$file_with_suffix" "_conp_mafft_msa.fasta")
hmmbuild -n $file_name ./HMMfiles/"$file_name".nhmmer $i
done 
cd "$output_dir"/HMMfiles
cat ./*.nhmmer > ../AllHMMs.hmm
cd "$output_dir"
hmmstat ./AllHMMs.hmm > "$Cls_Prefix"HMMstat.tsv
# fi


#TBD!
# if [ "$AddSs" == "True" ]; 
# then
# for i in "$output_dir"/msaFiles/*.msa.fasta
# do
# file_with_suffix=$(basename "$i") 
# file_name=$(basename "$file_with_suffix" ".msa.fasta")
# # cat $i | fa2sr -w=0 |sr_filter -conplus -hcon=0 -ncon="$file_name"_con | sr2fa > ./msaFiles/"$file_name".Cons.msa.fasta
# done 
# fi

# ##### Lineraize the MSAs as per our conventions. #####
# cd msaFiles
# for i in ./*.faa 
# do
# awk 'BEGIN{RS=">";FS="\n"}NR>1{seq="";for (i=2;i<=NF;i++) seq=seq""$i; print ">"$1"\n"seq}' "$i" > temp.faa
# cat temp.faa > "$i"
# done
# rm temp.faa 
# cd ../
# ##### Based on arg -r, remove intermediate files/dirs. #####
# if [ "$rm_tmp" != "False" ]; 
# then
# rm tmpmsa -r
# fi


##### Create a summary file for the script call. #####
echo "Printing Water_Mark to $(pwd)/Water_Mark.txt"
echo "Clustem.sh called on $(date) by: " >  "$Cls_Prefix"Clustem.env
echo "$@" >> "$Cls_Prefix"Clustem.env

echo "Enviroment/Flags called:
THREADS = $THREADS
output_dir = $output_dir
Water_mark = $(echo ${Water_Mark[*]}) [<E-value,score1,min_alignment_coverage,qlen>] 
input = $input_fasta
rmemove tmps = $rm_tmp
Memory = $Memory
Clustering ID >= $min_prec_id 
Clustering coverage >= $min_prec_cov 
Output_clusters_prefix = $Cls_Prefix
Add consenus = $AddCons 
" >> "$Cls_Prefix"Clustem.env

echo "Done: $Cls_Prefix"
echo "Note! the resulting profiles may not be ideal for all use cases."
