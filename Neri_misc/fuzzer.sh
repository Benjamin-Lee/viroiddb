#!/usr/bin/env bash
cd /media/HDD1/uri/RNA_Vir_MTs/viroiddb/viroiddb/Neri/

for i in ./*.1.1.png; do
	ininame=$(basename $i "png")
convert $i -trim  -fuzz 20%% -transparent White ../Fuzzed/"$ininame".png
done	

for i in ./*.2.1.png; do
	ininame=$(basename $i ".png")
convert $i -trim  -fuzz 20%% -transparent White ../Fuzzed/"$ininame".png
done	

for i in ./*..png; do
	ininame=$(basename $i "..png")
mv $i $ininame".png"
done	