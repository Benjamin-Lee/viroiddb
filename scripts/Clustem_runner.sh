Sealsoader
alias Clustem.sh='bash /media/HDD1/uri/RNA_Vir_MTs/viroiddb/viroiddb/Neri_misc/Clustem.sh'
 
THREADS=10 #t
Memory=5000 #M
output_dir=/media/HDD1/uri/RNA_Vir_MTs/viroiddb/viroiddb/Neri/clusterin3/ #o
input_fasta='/media/HDD1/uri/RNA_Vir_MTs/viroiddb/viroiddb/Neri/clusterin3/all.fasta' #i
Water_Mark="Test1" #s
min_prec_cov=0.75 #c
Align_Rotated=True #m
Cls_Prefix=Cls_ID"$min_prec_id_nodot"_ #.Cov"$min_prec_cov". #P
AddCons=True #a
rm_tmp="False" #r
AddSs=True #H
Attempt_Rotation=True


ID_List=(a 95 90 85 80 75 70 65 60 55 50 a)# 
for idd in $ID_List[#]; do
  Cls_Prefix=$(date --iso-8601)_Cls_ID"$idd"_ #.Cov"$min_prec_cov". #P
  echo $Cls_Prefix
  output_dir=/media/HDD1/uri/RNA_Vir_MTs/viroiddb/viroiddb/Neri/clusterin3/Cls_ID"$idd" #.Cov"$min_prec_cov"
  Clustem.sh -t $THREADS -M $Memory -o $output_dir -i $input_fasta -s $Water_Mark -d 0.$idd -c $min_prec_cov  -m $Align_Rotated -P $Cls_Prefix  -a $AddCons -r $rm_tmp  -H $AddSs -v $Use_CDHIT -S $Use_Mafft -R $Attempt_Rotation
done
