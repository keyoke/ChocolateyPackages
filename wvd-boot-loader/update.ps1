import-module au

$download_url = 'https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RWrxrH'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            '(?i)(^\s*\$url64\s*=\s*)(''.*'')'   = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $response = Invoke-WebRequest -Method HEAD -UseBasicParsing -Uri $download_url  | Select-Object headers
    $modified = [DateTime] $response.Headers["Last-Modified"]
    $modifiedUTC = $modified.ToUniversalTime()

    $version =  $modifiedUTC.ToString("yyyy.MM.dd")

    @{
        URL64   = $download_url
        Version = "$version-beta"
    }
}

Update -ChecksumFor 64
