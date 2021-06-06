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
    seqkit seq -rp $d | RNAfold --jobs=0 --circ --temp=25 --noPS > $output/$filename.rc.dbn
done

cd $INITIAL_WORKING_DIRECTORY