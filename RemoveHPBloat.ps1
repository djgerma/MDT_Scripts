#Get-AppxPackage -AllUsers

#SYNTAX TO REMOVE AN APP
#Get-AppxPackage SampleAppName | Remove-AppxPackage

$ErrorActionPreference = "SilentlyContinue"

#START

Get-AppxPackage -AllUsers Microsoft.windowscommunicationsapps | Remove-AppxPackage
Get-AppxPackage -AllUsers king.com.CandyCrushSaga | Remove-AppxPackage
Get-AppxPackage -AllUsers king.com.CandyCrushFriends | Remove-AppxPackage
Get-AppxPackage -AllUsers Microsoft.Office.OneNote | Remove-AppxPackage
Get-AppxPackage -AllUsers Microsoft.MicrosoftOfficeHub | Remove-AppxPackage
Get-AppxPackage -AllUsers Microsoft.OneConnect | Remove-AppxPackage
Get-AppxPackage -AllUsers Microsoft.SkypeApp | Remove-AppxPackage
Get-AppxPackage -AllUsers Microsoft.Office.Desktop | Remove-AppxPackage
Get-AppxPackage -AllUsers AD2F1837.HPJumpstart | Remove-AppxPackage


Get-AppxPackage -AllUsers *HP* | Remove-AppxPackage
Get-AppxPackage -AllUsers *Bing* | Remove-AppxPackage
Get-AppxPackage -AllUsers *Wallet* | Remove-AppxPackage
Get-AppxPackage -AllUsers *Zune* | Remove-AppxPackage
Get-AppxPackage -AllUsers *MixedReality* | Remove-AppxPackage
Get-AppxPackage -AllUsers *Maps* | Remove-AppxPackage
Get-AppxPackage -AllUsers *Xbox* | Remove-AppxPackage
Get-AppxPackage -AllUsers *YourPhone* | Remove-AppxPackage

Get-AppXProvisionedPackage -online | Remove-AppxProvisionedPackage –online
 
Start-Sleep -s 15

#Uninstall HP Sure Recover
$HPSureRecover = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -match "HP Sure Recover" }
$HPSureRecoverID = $HPSureRecover.properties["IdentifyingNumber"].value.toString()
MsiExec.exe /norestart /q/x $HPSureRecoverID REMOVE=ALL
Start-Sleep -s 15


#Uninstall HP Sure Run
$HPSureRun = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -match "HP Sure Run" }
$HPSureRunID = $HPSureRun.properties["IdentifyingNumber"].value.toString()
MsiExec.exe /norestart /q/x $HPSureRunID REMOVE=ALL
Start-Sleep -s 15

$HPSureClick = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -match "HP Sure Click" }
$HPSureClickID = $HPSureClick.properties["IdentifyingNumber"].value.toString()
MsiExec.exe /norestart /q/x $HPSureClickID REMOVE=ALL
Start-Sleep -s 15

#Uninstall Device Manager First
$HPDeviceManager = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -match "HP Device Access Manager" }
$HPDeviceManagerID = $HPDeviceManager.properties["IdentifyingNumber"].value.toString()
MsiExec.exe /norestart /q/x $HPDeviceManagerID REMOVE=ALL
Start-Sleep -s 15


#Uninstall HP Client Security Manager
$HPClientSecurityManager = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -match "HP Client Security Manager" }
$HPClientSecurityManagerID = $HPClientSecurityManager.properties["IdentifyingNumber"].value.toString()
MsiExec.exe /norestart /q/x $HPClientSecurityManagerID REMOVE=ALL
Start-Sleep -s 15

#Uninstall HP Client Support Assistant
$HPSupportAssistant = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -match "HP Support Assistant" }
$HPSupportAssistantID = $HPSupportAssistant.properties["IdentifyingNumber"].value.toString()
MsiExec.exe /norestart /q/x $HPSupportAssistantID REMOVE=ALL
Start-Sleep -s 15

#Uninstall HP Notifications
$HPNotifications = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -match "HP Notifications" }
$HPNotificationsID = $HPNotifications.properties["IdentifyingNumber"].value.toString()
MsiExec.exe /norestart /q/x $HPNotificationsID REMOVE=ALL
Start-Sleep -s 15

#Uninstall HP JumpStart Bridge
$HPJumpStartBridge = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -match "HP JumpStart Bridge" }
$HPJumpStartBridgeID = $HPJumpStartBridge.properties["IdentifyingNumber"].value.toString()
MsiExec.exe /norestart /q/x $HPJumpStartBridgeID REMOVE=ALL
Start-Sleep -s 15

#Uninstall HP JumpStart Launch
$HPJumpStartLaunch = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -match "HP JumpStart Launch" }
$HPJumpStartLaunchID = $HPJumpStartLaunch.properties["IdentifyingNumber"].value.toString()
MsiExec.exe /norestart /q/x $HPJumpStartLaunchID REMOVE=ALL
Start-Sleep -s 15

#uninstall HP Collaboration Keyboard
$HPCollabKeyboard = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -like "HP Collab" }
$HPCollabKeyboardID = $HPCollabKeyboard.properties["IdentifyingNumber"].value.toString()
MsiExec.exe /norestart /q/x $HPCollabKeyboard REMOVE=ALL
Start-Sleep -s 15

#Uninstall HP Security Update Service
$HPSecUpd = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -like "HP Security Update Service" }
$HPSecUpd = $HPSecUpd.properties["IdentifyingNumber"].value.toString()
MsiExec.exe /norestart /q/x $HPSecUpd REMOVE=ALL
Start-Sleep -s 15

#Uninstall HP Wolf Security
MsiExec.exe /norestart /q/x '{2F0D4FB0-ADA6-11EB-8ED8-3863BB3CB5AC}' REMOVE=ALL
Start-Sleep -s 15
MsiExec.exe /norestart /q /I '{EF61C4DE-F64F-409E-BBC4-1F8CCDFE63CA}' REMOVE=ALL
Start-Sleep -s 15

#Remove HP Documentation
Start-Process -FilePath "C:\Program Files\HP\Documentation\Doc_uninstall.cmd" 
Start-Sleep -s 15

#Remove leftover HP Software except for HotKey Support
$hpguids = get-wmiobject -class win32_product | Where-Object {$_.Name -like "HP *"} | Where-Object {$_.Name -notmatch "HP Hotkey Support"}
#Write-Output $hpguids

foreach($guid in $hpguids){
$id = $guid.IdentifyingNumber
write-host ""$guid.Name" is being removed."
&cmd /c "msiexec /uninstall $($id) /qn /norestart"
}
Start-Sleep -s 15


#Remove Skype
$skypeguid = get-wmiobject -class win32_product | Where-Object {$_.Name -like "*Skype*"}
foreach($guid in $skypeguid){
    $id = $guid.IdentifyingNumber
     write-host ""$guid.Name" is being removed."
     &cmd /c "msiexec /uninstall $($id) /qn /norestart"
    } 
Start-Sleep -s 15


#Remove Pre-Installed Office Apps
Write-Host "Removing Apps..." -ForegroundColor Green
    Write-Host ""
    
    # Create array to hold list of apps to remove
    $appname = @(
        
 "*Microsoft.Desktop.Access*"
 "*Microsoft.Desktop.Excel*"
 "*Microsoft.Desktop.Outlook*"
 "*Microsoft.Desktop.Word*"
 "*Microsoft.Desktop.PowerPoint*"
 "*Microsoft.Desktop.Publisher*"
 "*Microsoft.MicrosoftOfficeHub*"
 "*Microsoft.Office.OneNote*"
 "*Microsoft.Office.Sway*"
 "*Office.Desktop*"
    )
    # Remove apps from current user
    ForEach($app in $appname){
    Get-AppxPackage -Name $app | Remove-AppxPackage -ErrorAction SilentlyContinue
    }
    # Remove apps from all users - may need to reboot after running above and run this again
    ForEach($app in $appname){
    Get-AppxPackage -Allusers -Name $app | Remove-AppxPackage -Allusers -ErrorAction SilentlyContinue
    }
    # Remove apps from provisioned apps list so they don't reinstall on new users
    ForEach($app in $appname){
    Get-AppxProvisionedPackage -Online | where {$_.PackageName -like $app} | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue
    }

    Remove-Item 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\HP' -Recurse
    Remove-Item 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Free Trials.lnk'

    Start-Process explorer.exe
