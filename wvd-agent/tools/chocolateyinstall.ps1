
$ErrorActionPreference = 'Stop';

$pp = Get-PackageParameters

if (!$pp['REGISTRATIONTOKEN']) { 
  throw "Package needs parameter 'REGISTRATIONTOKEN' to install, that must be provided in params or in prompt."
}

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = ''
$url64      = 'https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RWrmXv'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'MSI'
  url           = $url
  url64bit      = $url64

  softwareName  = 'wvd-agent*'

  checksum      = ''
  checksumType  = 'sha256'
  checksum64    = '8EA6A987A82213A5C466DB858D00FDDCE023080448C3133526E7F2164378BD6F'
  checksumType64= 'sha256'

  silentArgs    = "/quiet /qn /norestart /passive REGISTRATIONTOKEN=$($pp['REGISTRATIONTOKEN']) /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs










    








