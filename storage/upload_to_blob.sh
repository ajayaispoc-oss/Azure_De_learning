#!/bin/bash
# usage
$ sh upload_to_blob.sh filename_to_upload.csv blob_name
#sh upload_to_blob.sh T20-GL-gainers-NIFTY-31-Aug-2026.csv T20_top_gainers
# sh upload_to_blob.sh T20-GL-gainers-NIFTY-31-Aug-2026.csv stocks/T20_top_gainers
# Configuration Variables
STORAGE_ACCOUNT="delearningaisa"
CONTAINER_NAME="datacnt"
LOCAL_FILE=$1
BLOB_NAME=$2
SAS_TOKEN="sv=2026-02-06&ss=b&srt=sco&sp=rwdlaciytfx&se=2026-09-03T01:05:06Z&st=2026-09-02T16:50:06Z&spr=https&sig=2EyM7tDLwI05NKAVasuXOfEaHNfo9flbSUxTRC22Jvs%3D"

# 1. Create a sample local test.csv if it doesn't exist
if [ ! -f "$LOCAL_FILE" ]; then
    echo "id,name,value" > "$LOCAL_FILE"
    echo "1,sample_data,100" >> "$LOCAL_FILE"
    echo "Created sample local file: $LOCAL_FILE"
fi

# 2. Check if the container exists using az storage container exists
echo "Checking if container '$CONTAINER_NAME' exists..."
EXISTS=$(az storage container exists \
    --account-name "$STORAGE_ACCOUNT" \
    --name "$CONTAINER_NAME" \
    --sas-token "$SAS_TOKEN" \
    --query "exists" -o tsv)

# 3. Create container if it does not exist
if [ "$EXISTS" = "true" ]; then
    echo "Container '$CONTAINER_NAME' already exists."
else
    echo "Container '$CONTAINER_NAME' does not exist. Creating container..."
    az storage container create \
        --account-name "$STORAGE_ACCOUNT" \
        --name "$CONTAINER_NAME" \
        --sas-token "$SAS_TOKEN"
    echo "Container created successfully."
fi

# 4. Upload the file
echo "Uploading '$LOCAL_FILE' to container '$CONTAINER_NAME'..."
az storage blob upload \
    --account-name "$STORAGE_ACCOUNT" \
    --container-name "$CONTAINER_NAME" \
    --name "$BLOB_NAME" \
    --file "$LOCAL_FILE" \
    --sas-token "$SAS_TOKEN" \
    --overwrite
if [ $? -eq 0 ]; then
    echo "$LOCAL_FILE uploaded in $STORAGE_ACCOUNT success"
else
    echo "Error: File upload failed."
fi
