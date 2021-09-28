$RegPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
$DefaultUsername = "Administrator"
$DefaultPassword = ""
$DefaultDomainName = ""
Set-ItemProperty $RegPath "AutoAdminLogon" -Value "0" -type String
Set-ItemProperty $RegPath "DefaultDomainName" -Value $DefaultDomainName -type String 
Set-ItemProperty $RegPath "DefaultUsername" -Value "$DefaultUsername" -type String 
Set-ItemProperty $RegPath "DefaultPassword" -Value "$DefaultPassword" -type String
