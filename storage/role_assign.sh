RESOURCE_GROUP="rg-delearningaisa"
LOCATION="eastus"
STORAGE_ACCOUNT="delearningaisa1"
CONTAINER_NAME="my-test-container"
FOLDER_NAME="my-folder"
LOCAL_FILE="test.csv"

SUBSCRIPTION_ID=$(az account show --query id -o tsv)
USER_EMAIL=$(az account show --query user.name -o tsv)
USER_OBJECT_ID=$(az ad signed-in-user show --query id -o tsv)
echo "User Object ID: $USER_OBJECT_ID"

az role assignment create \
    --role "Contributor" \
    --assignee "<your-email-or-object-id>" \
    --scope "/subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.Storage/storageAccounts/$STORAGE_ACCOUNT"
