for d in $1*.fasta; do
    cp $d{,.bak}
    sed -i '' "s/|//" $d.bak
    seqkit rmdup -s $d.bak -w0 > $d.nodup
    mv $d.nodup $d
    rm $d.bak
done

seqkit seq $1/avsunviroidae.fasta $1/pospiviroidae.fasta $1/unclassified.fasta | seqkit rmdup -s -w0 > $1/viroids.fasta
seqkit seq $1/*.fasta | seqkit rmdup -s -w0 > $1/all.fasta
seqkit stat $1/*.fasta -b