param (
    [Parameter(Mandatory=$true)]
    [string]$TenantId,

    [Parameter(Mandatory=$true)]
    [string]$ClientId,

    [Parameter(Mandatory=$true)]
    [string]$ClientSecret,

    [string]$ResourceGroupName = "rg-rekrutacja-c3",
    [string]$Location = "westeurope",
    [string]$StorageAccountName = "stsharpai25" 
)

Write-Host "Login Started"

$secureSecret = ConvertTo-SecureString -String $ClientSecret -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($ClientId, $secureSecret)

Connect-AzAccount -ServicePrincipal -Credential $credential -Tenant $TenantId


Write-Host "Login Successfull"

New-AzStorageAccount -ResourceGroupName $ResourceGroupName `
                     -Name $StorageAccountName `
                     -Location $Location `
                     -SkuName "Standard_LRS" `
                     -Kind "StorageV2"

Write-Host "Storage Account has been created"