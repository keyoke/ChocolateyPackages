
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
  checksum64    = '7A5C46DC754A183A7CA05E57FA8461493A4FA47E1535A80DE9DC893DF9374178'
  checksumType64= 'sha256'

  silentArgs    = "/quiet /qn /norestart /passive REGISTRATIONTOKEN=$($pp['REGISTRATIONTOKEN'])) /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs










    








