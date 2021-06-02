####Check if it ran for this user####

$ErrorActionPreference = "SilentlyContinue"

$UName = Select-String -Path "C:\FolderPath\RunOnce.log" -Pattern $env:Username | ForEach-Object {$_.Line}

if ($Uname -eq $env:Username)
{
exit
}

Add-Content -Path "C:\FolderPath\RunOnce.log" -Value $env:Username | Out-Null


$RegistryPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced"  | Out-Null
$RegistryPath2 = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search"  | Out-Null
$ShowTaskViewButton = "AllowWindowsInkWorkspace"  | Out-Null
$ShowCortanaButton = "ShowCortanaButton" | Out-Null
$SearchBox = "SearchboxTaskbar" | Out-Null
$Value = "0" | Out-Null

If (Test-Path $RegistryPath)
{
Set-ItemProperty -Path $RegistryPath -Name $ShowCortanaButton -Value $Value | Out-Null
New-ItemProperty -Path $RegistryPath -Name $ShowTaskViewButton -Value $Value -PropertyType DWORD -Force | Out-Null
New-ItemProperty -Path $RegistryPath2 -Name $SearchBox -Value $Value -PropertyType DWORD -Force | Out-Null
}

# Disable Action Center
 If (!(Test-Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer")) {
   New-Item -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" | Out-Null
 }
 Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Name "DisableNotificationCenter" -Type DWord -Value 1 | Out-Null
 Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications" -Name "ToastEnabled" -Type DWord -Value 0 | Out-Null

#Hide Search Box
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Type DWord -Value 0 | Out-Null

# Hide Task View button
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Type DWord -Value 0 | Out-Null

Start-Sleep -s 3
Stop-Process -Name explorer -ErrorAction SilentlyContinue | Out-Null
Start-Sleep -s 3

If (!(Test-Path "HKCR:")) {
    New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
}
Remove-Item -Path "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Recurse -ErrorAction SilentlyContinue  | Out-Null
Remove-Item -Path "HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Recurse -ErrorAction SilentlyContinue  | Out-Null
