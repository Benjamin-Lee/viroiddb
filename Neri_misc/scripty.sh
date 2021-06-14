#!/bin/bash
#hostname
#circRNA

# All_MTs_path="/scratch200/urineri/V2/MTs/"
# All_MTs_path="/media/Gophna_3/Neri/RNA_Vir_MTs/MTs/"
All_MTs_path="/media/Cereberu/tarballs/"
New_Loc="/media/Cereberu/RNA_VIR"
THREADS=4
mem=10000
max_len=3000
min_len=1

cd $All_MTs_path || exit
for i in ./*.tar
do
study_name=$(basename "$i" .tar)
echo "Started $study_name"
mkdir "$New_Loc"/"$study_name"
tar -xvf "$All_MTs_path"/"$i"  -C "$New_Loc"/"$study_name"
cd "$New_Loc"/"$study_name"
for MT in ./*.tar.gz
do
MT_name=$(basename "$MT" .tar.gz)
tar -zxvf "$MT" "$MT_name"/"$MT_name".a.fna
echo "Done $MT_name"
done
rm ./*.tar.gz
Rscript /media/Gophna_3/Neri/RNA_Vir_MTs/MTs/format_new_MTs.r "$New_Loc"/"$study_name" $min_len $max_len $THREADS
rm ./*/*a.fna

#cat ./*/*.a.fna | LenFilter -l $max_len -m max > ./cated_"$study_name"_MXL3k.fasta # Need to compile Lrust on Venpc

# cat ./*/*.a.fna | filterbymaxlength.pl $max_len > ./cated_"$study_name"_MXL3k.fasta
#mmseqs easy-linclust ./cated_"$study_name"_MXL3k.fasta ./cated_"$study_name"_MXL3k.clu tmp --min-seq-id 0.95 -c 0.95 --cov-mode 1 --kmer-per-seq-scale 0.4 ->
#rm tmp -r
# rm ./3*/ -r
cd $All_MTs_path
echo "Done $study_name"
done >> $All_MTs_path/"log.11042021.txt"

# cd $All_MTs_path
# for i in ./*.tar
# do
# study_name=$(basename $i .tar)
# echo "Started $study_name"
# cd "$New_Loc"/"$study_name"
# Rscript "$All_MTs_path"/format_new_MTs.r "$New_Loc"/"$study_name" 200 3000 THREADS
# rm ./*/*a.fna
# cd $All_MTs_path
# echo "Done $study_name"
# done


cd $New_Loc
for i in ./Currn_rem_non_missing_*/
do
study_name=$(basename "$i" -s )
echo "Started $study_name"
cd "$study_name"
cat ./*/*.fasta > ./cated_"$study_name"_MXL3k.fasta
pbzip2 -m"$mem" -p"$THREADS" -v -z -c < "cated_"$study_name"_MXL3k.fasta" >"cated_"$study_name"_MXL3k.fasta.bz2"
cd "$New_Loc"
done
