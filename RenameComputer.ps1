Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName PresentationCore,PresentationFramework

$LocalAdmin = "localhost\Administrator"
$Password = ConvertTo-SecureString "PasswordHere" -AsPlainText -Force

$form = New-Object System.Windows.Forms.Form
$form.Text = 'Enter Name Of Computer'
$form.Size = New-Object System.Drawing.Size(300,200)
$form.StartPosition = 'CenterScreen'

$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(75,120)
$okButton.Size = New-Object System.Drawing.Size(75,23)
$okButton.Text = 'OK'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(150,120)
$cancelButton.Size = New-Object System.Drawing.Size(75,23)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Please enter Hostname of the PC:'
$form.Controls.Add($label)

$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(10,40)
$textBox.Size = New-Object System.Drawing.Size(260,20)
$form.Controls.Add($textBox)

$form.Topmost = $true

$form.Add_Shown({$textBox.Select()})
$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::Cancel) 
{
    New-Item -Path "HKLM:\SOFTWARE" -Name MDT
    New-ItemProperty -Path "HKLM:\SOFTWARE\MDT" -Name "MDT" -Value "NoRename" -PropertyType "String"
	Exit
}
elseif ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $x = $textBox.Text.ToUpper().Trim()
    
    if ((gwmi win32_computersystem).partofdomain -eq $true) {
    [System.Windows.MessageBox]::Show("This Computer is joined to Domain! You will have to enter domain admin username and password to change the computer name! Username must be in this format 'Domain\username'")
    Rename-Computer -NewName $x -DomainCredential YourDomain\$env:USERNAME -Force
    } else {
    (Get-WmiObject win32_computersystem).Rename( $x,$Password,$LocalAdmin)
    }
 
}
