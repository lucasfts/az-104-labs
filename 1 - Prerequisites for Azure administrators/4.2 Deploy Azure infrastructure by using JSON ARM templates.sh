# https://learn.microsoft.com/en-us/training/modules/create-azure-resource-manager-template-vs-code/3-exercise-create-and-deploy-template?pivots=cli

az login

az account set --subscription "Concierge Subscription"

az account list --refresh --query "[?contains(name, 'Concierge Subscription')].id" --output table

az account set --subscription {your subscription ID}

az configure --defaults group=[sandbox resource group name]

templateFile="azuredeploy.json"
today=$(date +"%d-%b-%Y")

DeploymentName="blanktemplate-"$today
az deployment group create --name $DeploymentName --template-file $templateFile

DeploymentName="addstorage-"$today
az deployment group create --name $DeploymentName --template-file $templateFile

# https://learn.microsoft.com/en-us/training/modules/create-azure-resource-manager-template-vs-code/5-exercise-parameters-output?pivots=cli
DeploymentName="addSkuParameter-"$today
az deployment group create \
  --name $DeploymentName \
  --template-file $templateFile \
  --parameters storageSKU=Standard_GRS storageName={your-unique-name}

DeploymentName="addSkuParameter-"$today
az deployment group create \
  --name $DeploymentName \
  --template-file $templateFile \
  --parameters storageSKU=Basic storageName={your-unique-name}


DeploymentName="addoutputs-"$today
az deployment group create \
  --name $DeploymentName \
  --template-file $templateFile \
  --parameters storageSKU=Standard_LRS storageName={your-unique-name}