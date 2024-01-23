# https://learn.microsoft.com/en-us/training/modules/configure-azure-resources-tools/5-simulation-powershell
# Objectives
#     Task 1: Start a PowerShell session in the Azure Cloud Shell
#     Task 2: Create a resource group and managed disk by using PowerShell.
#         Create a resource group.
#         Create a managed disk in the resource group.
#     Task 3: Configure the managed disk by using Azure PowerShell.
#         Increase the size of the managed disk.
#         Change the disk performance SKU.

$location = (Get-AzResourceGroup -Name az104-03b-rg1-681427).location
$rgName = 'az104-03c-rg1-681427'
New-AzResourceGroup -Name $rgName -Location $location

$diskConfig = New-AzDiskConfig `
    -Location $location `
    -CreateOption Empty `
    -DiskSize 32 `
    -Sku Standar_LRS
$diskName = 'az104-03c-disk1'
New-AzDisk -ResourceGroupName $rgName -DiskName $diskName - Disk $diskConfig
Get-AzDisk -ResourceGroupName $rgName -Name $diskName

New-AzDiskUpdateConfig -DiskSize 64 | Update-AzDisk -ResourceGroupName $rgName -DiskName $diskName
Get-AzDisk -ResourceGroupName $rgName -Name $diskName
(Get-AzDisk -ResourceGroupName $rgName -Name $diskName.Sku)
New-AzDiskUpdateConfig -Sku Premium_LRS | Update-AzDisk -ResourceGroupName $rgName -DiskName $diskName
(Get-AzDisk -ResourceGroupName $rgName -Name $diskName.Sku)