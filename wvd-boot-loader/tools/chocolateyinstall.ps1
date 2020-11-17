
$ErrorActionPreference = 'Stop';

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  softwareName  = 'wvd-boot-loader*'
  fileType       = 'msi'
  file64         = Get-Item $toolsDir\*x64.msi
  silentArgs    = "/quiet /qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)
}
Install-ChocolateyInstallPackage @packageArgs










    








