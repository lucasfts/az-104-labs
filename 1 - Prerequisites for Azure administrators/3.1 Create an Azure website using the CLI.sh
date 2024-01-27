# https://learn.microsoft.com/en-us/training/modules/control-azure-services-with-cli/5-exercise-create-website-using-the-cli

export RESOURCE_GROUP=learn-1d73b660-04bb-4aee-9138-ef551b540f2e
export AZURE_REGION=eastus
export AZURE_APP_PLAN=popupappplan-$RANDOM
export AZURE_WEB_APP=popupwebapp-$RANDOM

az group list --output table
az group list --query "[?name == '$RESOURCE_GROUP']"

az appservice plan create --name $AZURE_APP_PLAN --resource-group $RESOURCE_GROUP --location $AZURE_REGION --sku FREE
az appservice plan list --output table

az webapp create --name $AZURE_WEB_APP --resource-group $RESOURCE_GROUP --plan $AZURE_APP_PLAN
az webapp list --output table

site="http://$AZURE_WEB_APP.azurewebsites.net"
echo $site
curl $site

az webapp deployment source config \
    --name $AZURE_WEB_APP \
    --resource-group $RESOURCE_GROUP \
    --repo-url "https://github.com/Azure-Samples/php-docs-hello-world" \
    --branch master \
    --manual-integration

curl $site