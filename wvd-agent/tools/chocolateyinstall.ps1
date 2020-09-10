
$ErrorActionPreference = 'Stop';

$pp = Get-PackageParameters

if (!$pp['REGISTRATIONTOKEN']) { 
  $pp['REGISTRATIONTOKEN'] = "!INVALID KEY"
  Write-Warning "Package needs parameter 'REGISTRATIONTOKEN' to install, that must be provided in params or in prompt."
}

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url      = 'https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RWrmXv'
$url64      = 'https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RWrmXv'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'MSI'
  url           = $url
  url64bit      = $url64

  softwareName  = 'wvd-agent*'

  checksum64    = '8ea6a987a82213a5c466db858d00fddce023080448c3133526e7f2164378bd6f'
  checksumType64= 'sha256'

  silentArgs    = "/quiet /qn /norestart /passive REGISTRATIONTOKEN=$($pp['REGISTRATIONTOKEN']) /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs










    








