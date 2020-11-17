
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

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  softwareName  = 'wvd-agent*'
  fileType       = 'MSI'
  file64         = Get-Item $toolsDir\*x64.msi
  silentArgs     = "/quiet /qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`" REGISTRATIONTOKEN=`"$($pp['REGISTRATIONTOKEN'])`""
  validExitCodes= @(0, 3010, 1641)
}
Install-ChocolateyInstallPackage @packageArgs










    








