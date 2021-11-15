# Setup WinRM
iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1'))

# Get params
param($username = $(Read-Host "Input username"), $pass = $(Read-Host "Input password"))

# Import Issuing Certificate

$cert = New-Object -TypeName System.Security.Cryptography.X509Certificates.X509Certificate2
$cert.Import("$HOME\Downloads\winrm.pem")

$store_name = [System.Security.Cryptography.X509Certificates.StoreName]::Root
$store_location = [System.Security.Cryptography.X509Certificates.StoreLocation]::LocalMachine
$store = New-Object -TypeName System.Security.Cryptography.X509Certificates.X509Store -ArgumentList $store_name, $store_location
$store.Open("MaxAllowed")
$store.Add($cert)
$store.Close()

# Import Client Certificate Public Key

$cert = New-Object -TypeName System.Security.Cryptography.X509Certificates.X509Certificate2
$cert.Import("$HOME\Downloads\winrm.pem")

$store_name = [System.Security.Cryptography.X509Certificates.StoreName]::TrustedPeople
$store_location = [System.Security.Cryptography.X509Certificates.StoreLocation]::LocalMachine
$store = New-Object -TypeName System.Security.Cryptography.X509Certificates.X509Store -ArgumentList $store_name, $store_location
$store.Open("MaxAllowed")
$store.Add($cert)
$store.Close()

# Map the certificate to the account

$password = ConvertTo-SecureString -String $pass -AsPlainText -Force
$credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $username, $password
$thumbprint = (Get-ChildItem -Path cert:\LocalMachine\root | Where-Object { $_.Subject -eq "CN=$username" }).Thumbprint

New-Item -Path WSMan:\localhost\ClientCertificate `
    -Subject "$username@localhost" `
    -URI * `
    -Issuer $thumbprint `
    -Credential $credential `
    -Force

cmd /c "winrm set winrm/config/service/Auth @{Certificate=`"true`"}"
