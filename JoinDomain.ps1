if ((gwmi win32_computersystem).partofdomain -eq $true) {
    $Object = new-object -comobject wscript.shell
    $Message = $Object.popup("This computer is already part of the Domain. Domain Join step will be skipped. ",5," Domain Join Step Warning ",1)
    New-Item -Path "HKLM:\SOFTWARE" -Name NOJOIN
    New-ItemProperty -Path "HKLM:\SOFTWARE\NOJOIN" -Name "NOJOIN" -Value "NOJOIN" -PropertyType "String"
    Exit
} Else {
$domain = "domain name here"
$password = Get-Content C:\FolderPath\JoinDomain.txt | ConvertTo-SecureString -Key (Get-Content 'C:\FolderPath\JoinDomain.key')
$username = "$domain\UserNameHere" 
$credential = New-Object System.Management.Automation.PSCredential($username,$password)
Add-Computer -DomainName $domain -Credential $credential

Start-Sleep -s 5
Get-ChildItem -Path 'C:\FolderPath' JoinDomain.* | foreach { Remove-Item -Path $_.FullName }
}
