﻿
$ErrorActionPreference = 'Stop';

$os = (Get-ComputerInfo).OsProductType
if($os -ne "WorkStation")
{
  if(Get-WindowsFeature -Name "RDS-RD-Server" | Where-Object {$_.InstallState -ne "Installed"})
  {
    Write-Warning "Package requires 'Remote Desktop Session Host' Windows Feature is enabled. Install with 'Add-WindowsFeature RDS-RD-Server'."
  }
}

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64      = 'https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RWrxrH'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'MSI'  
  url64bit      = $url64

  softwareName  = 'wvd-boot-loader*'

  checksum64    = '742239192dcfc6398ba33f2a6781319b49efc861843337ebbc28fd73555ff114'
  checksumType64= 'sha256'

  silentArgs    = "/quiet /qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs










    








