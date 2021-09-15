cd "$(dirname "$0")"
gsutil -m -o "GSUtil:parallel_process_count=1" cp ../db/$1/*  gs://viroiddb.appspot.com/$1/
for threshold in 70 75 80 85 90 95; do
    echo "Uploading storage with threshold $threshold"
    gsutil -m -o "GSUtil:parallel_process_count=1" cp ../db/$1/Cls_ID$threshold/FinalCluster_MSAs/*  gs://viroiddb.appspot.com/$1/msa/ID$threshold/
    gsutil -m -o "GSUtil:parallel_process_count=1" cp ../db/$1/Cls_ID$threshold/Rotated/CSA_Misc/*.bmp  gs://viroiddb.appspot.com/$1/bmp/ID$threshold/
done