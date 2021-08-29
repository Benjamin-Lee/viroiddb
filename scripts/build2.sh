INITIAL_WORKING_DIRECTORY=$(pwd)

# make all paths relative to the scripts/ path
cd "$(dirname "$0")"

# create the output folder (failing if it exists)
output=../db/$(date +%F)
mkdir $output

# perform circular deduplication/grouping and remove ambiguous sequences
for d in ../db/raw/*.fasta; do
    filename="$(basename $d)"
    filename="${filename%.*}"
    sed "s/|//" $d | node circuniq.js -g $output/$filename.groups.json - > $output/$filename.fasta
done

for d in $output/*.fasta; do
    filename="$(basename $d)"
    filename="${filename%.*}"
    RNAfold --jobs=0 --circ --temp=25 --noPS $d > $output/$filename.dbn
    cmscan --cpu 4 ../db/raw/ribozymes.cm $d > $output/$filename.cmscan
    seqkit seq -rp $d | RNAfold --jobs=0 --circ --temp=25 --noPS > $output/$filename.rc.dbn
done

cat $output/*.fasta > $output/all.fasta
cat $output/*.dbn > $output/all.dbn
cat $output/*.rc.dbn > $output/all.rc.dbn
cat $output/*.cmscan > $output/all.cmscan

# Group all of the viroid data together
cat $output/avsunviroidae.fasta $output/pospiviroidae.fasta  $output/unclassified.fasta > $output/viroids.fasta
cat $output/avsunviroidae.dbn $output/pospiviroidae.dbn  $output/unclassified.dbn > $output/viroids.dbn
cat $output/avsunviroidae.rc.dbn $output/pospiviroidae.rc.dbn  $output/unclassified.rc.dbn > $output/viroids.rc.dbn
cat $output/avsunviroidae.cmscan $output/pospiviroidae.cmscan  $output/unclassified.cmscan > $output/viroids.cmscan

cd $INITIAL_WORKING_DIRECTORY