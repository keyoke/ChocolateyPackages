
$ErrorActionPreference = 'Stop';

$os = (Get-ComputerInfo).OsProductType
if($os -ne "WorkStation")
{
  if(Get-WindowsFeature -Name "RDS-RD-Server" | Where-Object {$_.InstallState -ne "Installed"})
  {
    Write-Warning "Package requires 'Remote Desktop Session Host' Windows Feature is enabled. Install with 'Add-WindowsFeature RDS-RD-Server'."
  }
}

$pp = Get-PackageParameters

if (!$pp['REGISTRATIONTOKEN']) { 
  $pp['REGISTRATIONTOKEN'] = "!INVALID KEY"
  Write-Warning "Package needs parameter 'REGISTRATIONTOKEN' to install, that must be provided in params or in prompt."
}

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64      = 'https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RWrmXv'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'MSI'
  url64bit      = $url64

  softwareName  = 'wvd-agent*'

  checksum64    = '99dfbb1b3d4fe810a05062b1d5cd537e83637aadeaa1073c87eca0f4dbb7ab9a'
  checksumType64= 'sha256'

  silentArgs    = "/quiet /qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`" REGISTRATIONTOKEN=`"$($pp['REGISTRATIONTOKEN'])`""
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs










    








