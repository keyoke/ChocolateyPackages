
$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = ''
$url64      = 'https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RWrxrH'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'MSI'
  url           = $url
  url64bit      = $url64

  softwareName  = 'wvd-boot-loader*'

  checksum      = ''
  checksumType  = 'sha256'
  checksum64    = '8121C4808E07057FFE81C7C241FBA286F99C02AB5B47103F263BE40EEAA54C56'
  checksumType64= 'sha256'

  silentArgs    = "/quiet /qn /norestart /passive /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs










    








