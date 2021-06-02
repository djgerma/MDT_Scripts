$RegistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OOBE"
$Dword32 = "DisablePrivacyExperience"
$Value = "1"

If (!(Test-Path $RegistryPath))
{
 New-Item -Path $RegistryPath -Force | Out-Null
 New-ItemProperty -Path $RegistryPath -Name $Dword32 -Value $Value -PropertyType DWORD -Force | Out-Null
}
ELSE {
New-ItemProperty -Path $RegistryPath -Name $Dword32 -Value $Value -PropertyType DWORD -Force | Out-Null
}
