$LocalIPAddress = (Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias Ethernet).IPAddress
$LocalSubnet = ($LocalIPAddress -split "\.")[0..2] -join "."
Write-Host $LocalSubnet


$Location1 = "OU=LOC1,DC=domain,DC=local"
$Location2 = "OU=LOC2,DC=domain,DC=local"
$Location3 = "OU=LOC3,DC=domain,DC=local"
$Location4 = "OU=LOC4,DC=domain,DC=local"

If ($LocalSubnet -eq "192.168.0" -or $LocalSubnet -eq "192.168.1"){

$Today = Get-Date
$ComputerName = Get-ADComputer -SearchBase $LOC1 -Filter * -Properties whenCreated | Where-Object {$_.WhenCreated -ge $Today.AddMinutes(-10)} | foreach {$_.Name}
}

If ($LocalSubnet -eq "192.168.2"){

$Today = Get-Date
$ComputerName = Get-ADComputer -SearchBase $LOC2 -Filter * -Properties whenCreated | Where-Object {$_.WhenCreated -ge $Today.AddMinutes(-10)} | foreach {$_.Name}
}

If ($LocalSubnet -eq "192.168.3"){

$Today = Get-Date
$ComputerName = Get-ADComputer -SearchBase $LOC3 -Filter * -Properties whenCreated | Where-Object {$_.WhenCreated -ge $Today.AddMinutes(-10)} | foreach {$_.Name}
}

If ($LocalSubnet -eq "192.168.4"){

$Today = Get-Date
$ComputerName = Get-ADComputer -SearchBase $LOC4 -Filter * -Properties whenCreated | Where-Object {$_.WhenCreated -ge $Today.AddMinutes(-10)} | foreach {$_.Name}
}

