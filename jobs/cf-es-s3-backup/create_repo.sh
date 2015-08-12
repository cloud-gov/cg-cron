# Create a snapshot repo.
curl -s -XPUT "${5}_snapshot/s3_backup" -d '{
    "type":"s3",
    "settings": {
	"access_key":"'"$1"'",
	"secret_key":"'"$2"'",
        "bucket":"'"$3"'",
	"base_path":"'"$4"'",
        "region": "us-east"
    }
}'
