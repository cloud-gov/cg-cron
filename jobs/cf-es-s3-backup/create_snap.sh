# Create a new snapshot.
curl -s -XPUT "${5}_snapshot/s3_backup/$(date +%s)?wait_for_completion=false"
