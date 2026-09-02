# ==========================================
# Azure Storage CLI Practice Commands
# ==========================================

# 1. List Subscription and Email ID
az account show --query "{SubscriptionId:id, Email:user.name}" -o table

# 2. Create Resource Group
az group create --name rg-ajayprojects --location eastus

# 3. List Resource Groups
az group list --output table

# 4. Create Storage Account
az storage account create --name ajayprojects --resource-group rg-ajayprojects --location eastus --sku Standard_LRS --kind StorageV2

# 5. List Storage Accounts Under the Subscription
az storage account list --output table

# 6. Create Container
az storage container create --name filescnt --account-name ajayprojects --auth-mode login

# 7. List Containers
az storage container list --account-name ajayprojects --auth-mode login --output table

# 8. Create Folder and Upload test.csv
echo "id,name,value" > test.csv && echo "1,sample,100" >> test.csv
az storage blob upload --account-name ajayprojects --container-name filescnt --name "myfolder/test.csv" --file test.csv --auth-mode login

# 9. List Files in a Storage Account Container
az storage blob list --account-name ajayprojects --container-name filescnt --output table

# 10. Delete Files in a Storage Account
az storage blob delete --account-name ajayprojects --container-name filescnt --name "myfolder/test.csv" --auth-mode login

if unable to upload file to storage account use either SAS key or connection string:
using sas key :

az storage blob upload --account-name delearningaisa --container-name datacnt --name "test.csv" --file test.csv --sas-token "sv=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

using connection-string:
az storage blob upload --connection-string "BlobEndpoint=httpsxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" --container-name datacnt --name "test1.csv" --file test1.csv

