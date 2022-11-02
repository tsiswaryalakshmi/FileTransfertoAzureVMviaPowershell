#credential Delegation in Current machine(github runner) to reach azure VM/Remote Machine

Enable-WSManCredSSP -Role client -DelegateComputer powershell1.eastus.cloudapp.azure.com -Force

$allowed = @('WSMAN/powershell1.eastus.cloudapp.azure.com')

$key = 'hklm:\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation'
if (!(Test-Path $key)) {
    md $key
}
New-ItemProperty -Path $key -Name AllowFreshCredentialsWhenNTLMOnly -Value 1 -PropertyType Dword -Force            

$key = Join-Path $key 'AllowFreshCredentialsWhenNTLMOnly'
if (!(Test-Path $key)) {
    md $key
}
$i = 1
$allowed |% {
    # Script does not take into account existing entries in this key
    New-ItemProperty -Path $key -Name $i -Value $_ -PropertyType String -Force
    $i++
}
#$password = ConvertTo-SecureString "Welcome.1234" -AsPlainText -Force 
#$Cred = New-Object System.Management.Automation.PSCredential ("powershell", $password)
#$s =  New-PSSession -ComputerName "powershell1.eastus.cloudapp.azure.com" -Credential $cred -Authentication CredSSP
#Enable-WSManCredSSP -Role client -DelegateComputer powershell1.eastus.cloudapp.azure.com -Force
#Copy-Item "np++.ps1" C:\Users\powershell\Desktop #-ToSession $s
#Expand-Archive -Path C:\Users\powershell\Desktop\temp.zip -DestinationPath C:\Users\powershell\Desktop\
