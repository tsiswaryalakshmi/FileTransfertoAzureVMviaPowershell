#connecting to AzureVM/Remote Machine from github runner
$password = ConvertTo-SecureString "Welcome.1234" -AsPlainText -Force 
$Cred = New-Object System.Management.Automation.PSCredential ("powershell", $password)
$s =  New-PSSession -ComputerName "powershell1.eastus.cloudapp.azure.com" -Credential $cred -Authentication CredSSP
Enable-WSManCredSSP -Role client -DelegateComputer powershell1.eastus.cloudapp.azure.com -Force
Copy-Item "NotepadSoftware\*" C:\Users\powershell\Desktop -ToSession $s
#Copy-Item "npp.8.4.2.Installer.x64.zip" C:\Users\powershell\Desktop -ToSession $s #copy single file to remote machine/azure vm
#Expand-Archive -Path C:\Users\powershell\Desktop\sampleRepo-main.zip -DestinationPath C:\Users\powershell\Desktop\
