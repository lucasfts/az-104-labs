# https://learn.microsoft.com/en-us/training/modules/configure-azure-resources-tools/7-simulation-command-line
# Objectives
# Task 1: Start a Bash session in the Azure Cloud Shell.
# Task 2: Create a resource group and a managed disk by using the Azure CLI.
#     Create a resource group.
#     Create a managed disk in the resource group.
# Task 3: Configure the managed disk by using the Azure CLI.
#     Increase the size of the managed disk.
#     Change the disk performance SKU.

LOCATION=$(az group show --name 'az104-03b-rg1-681427' --query location --out tsv)
RGNAME = 'az104-03c-rg1-681427'
az group create --name $RGNAME --location $LOCATION
az group show --name $RGNAME

DISKNAME = 'az104-03c-disk1'
az disk create \
    --resource-group $RGNAME \
    --name $DISKNAME \
    --sku 'Standard_LRS' \
    --size-gb 32
az disk show --resource-group $RGNAME --name $DISKNAME

az disk update --resource-group $RGNAME --name $DISKNAME --size-gb 64
az disk show --resource-group $RGNAME --name $DISKNAME --query diskSizeGb
az disk update --resource-group $RGNAME --name $DISKNAME --sku 'Premium_LRS'
az disk show --resource-group $RGNAME --name $DISKNAME --query diskSizeGb

