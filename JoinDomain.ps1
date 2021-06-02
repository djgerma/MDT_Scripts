$domain = "domain name here"
$password = Get-Content C:\FolderPath\JoinDomain.txt | ConvertTo-SecureString -Key (Get-Content 'C:\FolderPath\JoinDomain.key')
$username = "$domain\UserNameHere" 
$credential = New-Object System.Management.Automation.PSCredential($username,$password)
Add-Computer -DomainName $domain -Credential $credential

Start-Sleep -s 5
Get-ChildItem -Path 'C:\FolderPath\Temp' JoinDomain.* | foreach { Remove-Item -Path $_.FullName }
