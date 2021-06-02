$Password = ConvertTo-SecureString "PasswordHere" -AsPlainText -Force
$UserAccount = Get-LocalUser -Name "Administrator"
$UserAccount | Enable-LocalUser
$UserAccount | Set-LocalUser -Password $Password
