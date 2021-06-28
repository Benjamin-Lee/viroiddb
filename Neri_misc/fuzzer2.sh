





for i in ./*".svg"; do
	ini_name=$(basename $i ".svg")
	rsvg-convert -f pdf -o ../test2/t.pdf $i --no-keep-image-data
	pdf-crop-margins -v -s -u ../test2/t.pdf  -o ../test3/"$ini_name".pdf

done
for i in ./*".svg"; do
ini_name=$(basename $i ".svg")

FILE=../test3/"$ini_name".pdf
if [ -f "$FILE" ]; then
else 
rsvg-convert -f pdf -o ../test2/t.pdf $i --no-keep-image-data
pdf-crop-margins -v -s -u ../test2/t.pdf  -o ../test3/"$ini_name".pdf
fi
done



seqit seq db/2021-06-06/*.fasta -n | awk '{print $1}' > temp.txt

for i in ./*".svg"; do
ini_name=$(basename $i ".svg")

FILE=../test3/"$ini_name".pdf
if [ -f "$FILE" ]; then
else 
rsvg-convert -f pdf -o ../test2/t.pdf $i --no-keep-image-data
pdf-crop-margins -v -s -u ../test2/t.pdf  -o ../test3/"$ini_name".pdf
fi
done


while IFS="" read -r p || [ -n "$p" ]
do
FILE=../test3/"$ini_name".pdf
if [ -f "$FILE" ]; then
else 

sed  's/ /''\n>''/g' <<< $(echo $cls_mems) >cls_mems1
awk 'BEGIN{RS=">";FS="\n"}NR==FNR{a[$1]++}NR>FNR{if ($1 in a && $0!="") printf ">%s",$0}' cls_mems1 "$input_fasta" > "$Cls_Prefix"."$i".faa
done < temp.txt