# https://learn.microsoft.com/en-us/training/modules/automate-azure-tasks-with-powershell/5-create-resource-interactively?pivots=windows

Install-Module -AllowClobber -Name Az -Scope CurrentUser -Repository PSGallery

Update-Module -Name Az

Connect-AzAccount

Get-AzContext

Set-AzContext -Subscription '00000000-0000-0000-0000-000000000000'

Get-AzResourceGroup

Get-AzResourceGroup | Format-Table

New-AzResourceGroup -Name <name> -Location <location>

New-AzVm
    -ResourceGroupName <resource group name>
    -Name <machine name>
    -Credential <credentials object>
    -Location <location>
    -Image <image name>


New-AzVM -Name MyVm -ResourceGroupName ExerciseResources -Credential (Get-Credential) ...

$ResourceGroupName = "ExerciseResources"
$vm = Get-AzVM  -Name MyVM -ResourceGroupName $ResourceGroupName
$vm.HardwareProfile.vmSize = "Standard_DS3_v2"

Update-AzVM -ResourceGroupName $ResourceGroupName  -VM $vm