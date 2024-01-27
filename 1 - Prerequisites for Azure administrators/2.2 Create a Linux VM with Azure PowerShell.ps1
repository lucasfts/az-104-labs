# https://learn.microsoft.com/en-us/training/modules/automate-azure-tasks-with-powershell/6-exercise-create-resource-interactively

New-AzVm `
    -ResourceGroupName learn-2bd69f16-6e9a-45c5-b561-9e7b40fe006e `
    -Name "testvm-eus-01" -Credential (Get-Credential) `
    -Location "eastus" `
    -Image Canonical:0001-com-ubuntu-server-focal:20_04-lts:latest `
    -OpenPorts 22 `
    -PublicIpAddressName "testvm-eus-01"

$vm = (Get-AzVM -Name "testvm-eus-01" -ResourceGroupName learn-2bd69f16-6e9a-45c5-b561-9e7b40fe006e)

$vm
$vm.HardwareProfile
$vm.StorageProfile.OsDisk
$vm | Get-AzVMSize

Get-AzPublicIpAddress -ResourceGroupName learn-2bd69f16-6e9a-45c5-b561-9e7b40fe006e -Name "testvm-eus-01"
$ip = (Get-AzPublicIpAddress -ResourceGroupName learn-2bd69f16-6e9a-45c5-b561-9e7b40fe006e -Name testvm-eus-01).IpAddress
$username = 'lucasfts'
ssh $username@$ip


# Delete a VM
Stop-AzVM -Name $vm.Name -ResourceGroupName $vm.ResourceGroupName
Remove-AzVM -Name $vm.Name -ResourceGroupName $vm.ResourceGroupName

# The Remove-AzVM command just deletes the VM. It doesn't clean up any of the other resources.
Get-AzResource -ResourceGroupName $vm.ResourceGroupName | Format-Table

# Delete the network interface:
$vm | Remove-AzNetworkInterface -Force
# Delete the managed OS disks:
Get-AzDisk -ResourceGroupName $vm.ResourceGroupName -DiskName $vm.StorageProfile.OSDisk.Name | Remove-AzDisk -Force
# Delete the virtual network:
Get-AzVirtualNetwork -ResourceGroupName $vm.ResourceGroupName | Remove-AzVirtualNetwork -Force
# Delete the network security group:
Get-AzNetworkSecurityGroup -ResourceGroupName $vm.ResourceGroupName | Remove-AzNetworkSecurityGroup -Force
# Finally, delete the public IP address:
Get-AzPublicIpAddress -ResourceGroupName $vm.ResourceGroupName | Remove-AzPublicIpAddress -Force
