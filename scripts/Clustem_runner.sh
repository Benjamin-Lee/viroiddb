Sealsoader
alias Clustem.sh='bash /media/HDD1/uri/RNA_Vir_MTs/viroiddb/viroiddb/Neri/Clustem.sh'
 
THREADS=10 #t
Memory=5000 #M
output_dir=/media/HDD1/uri/RNA_Vir_MTs/viroiddb/viroiddb/Neri/clusterin/ #o
input_fasta='/media/HDD1/uri/RNA_Vir_MTs/viroiddb/viroiddb/db/all.fasta' #i
Water_Mark="Test1" #s
min_prec_id=0.90  #d
min_prec_cov=0.75 #c
Align_Rotated=True #m
Cls_Prefix=Cls.ID"$min_prec_id".Cov"$min_prec_cov". #P
AddCons=True #a
rm_tmp="False" #r
AddSs=True #H
Attempt_Rotation=True
# Clustem.sh -t $THREADS -M $Memory -o $output_dir -i $input_fasta -s $Water_Mark -d $min_prec_id -c $min_prec_cov -N 2 -m $Align_Rotated -P $Cls_Prefix  -a $AddCons -r $rm_tmp  -H $AddSs -v $Use_CDHIT -S $Use_Mafft -R $Attempt_Rotation


ID_List=(0.9 0.85 0.8 0.75 )# 0.7
for idd in $ID_List[*]; do
  output_dir=/media/HDD1/uri/RNA_Vir_MTs/viroiddb/viroiddb/Neri/clusterin/Cls.ID"$idd".Cov"$min_prec_cov"
  Clustem.sh -t $THREADS -M $Memory -o $output_dir -i $input_fasta -s $Water_Mark -d $idd -c $min_prec_cov  -m $Align_Rotated -P $Cls_Prefix  -a $AddCons -r $rm_tmp  -H $AddSs -v $Use_CDHIT -S $Use_Mafft -R $Attempt_Rotation
done
