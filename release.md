# Release Checklist

1. Download sequences
2. Rename to `group.fasta` and `group.csv` and move in to `/db/raw`
3. Run pipeline
4. Update counts on homepage
5. Update counts on data page
6. Update counts on sequences page
7. Delete `sequences` collection
8. Split `all.json` into `all.1.json` and `all.2.json`.
9. Upload each file individually
10. Delete `clusters` collection and upload
11. Upload files to bucket with `upload-storage.sh`
12. Update redirects
