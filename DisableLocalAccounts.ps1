#Get all local computer accounts except for Administrator and disable them
$users = Get-CimInstance Win32_useraccount -Filter "LocalAccount=True AND Name != 'Administrator'" | Select-Object -ExpandProperty Name

foreach ($user in $Users){
Disable-LocalUser -Name $User
Write-Output $User
}
