$RegistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace"
$Dword32 = "AllowWindowsInkWorkspace"
$Value = "0"

If (!(Test-Path $RegistryPath))
{
 New-Item -Path $RegistryPath -Force #| Out-Null
 New-ItemProperty -Path $RegistryPath -Name $Dword32 -Value $Value -PropertyType DWORD -Force #| Out-Null
}
ELSE {
New-ItemProperty -Path $RegistryPath -Name $Dword32 -Value $Value -PropertyType DWORD -Force #| Out-Null
}
