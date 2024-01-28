# https://learn.microsoft.com/en-us/training/modules/create-azure-resource-manager-template-vs-code/3-exercise-create-and-deploy-template?pivots=powershell

Connect-AzAccount

Get-AzSubscription
$subscription = (Get-AzSubscription -SubscriptionName "Concierge Subscription").Id
$context = Get-AzSubscription -SubscriptionId $subscription

Set-AzDefault -ResourceGroupName learn-2549b9fb-3ee4-4442-b732-b5655fe50b4c

$templateFile="azuredeploy.json"
$today=Get-Date -Format "MM-dd-yyyy"

$deploymentName="blanktemplate-"+"$today"
New-AzResourceGroupDeployment -Name $deploymentName -TemplateFile $templateFile

$deploymentName="addstorage-"+"$today"
New-AzResourceGroupDeployment -Name $deploymentName -TemplateFile $templateFile

# https://learn.microsoft.com/en-us/training/modules/create-azure-resource-manager-template-vs-code/5-exercise-parameters-output?pivots=powershell
$deploymentName="addnameparameter-"+"$today"
New-AzResourceGroupDeployment -Name $deploymentName -TemplateFile $templateFile -storageName lfsstorageexample321

$deploymentName="addSkuParameter-"+"$today"
New-AzResourceGroupDeployment -Name $deploymentName -TemplateFile $templateFile -storageName lfsstorageexample456 -storageSKU Standard_GRS

$deploymentName="addOutputs-"+"$today"
New-AzResourceGroupDeployment -Name $deploymentName -TemplateFile $templateFile -storageName lfsstorageexample789 -storageSKU Standard_LRS
