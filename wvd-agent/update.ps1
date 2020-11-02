if (-not (Get-Module -Name au)) {
    import-module au
}
$progressPreference = 'silentlyContinue' 

$download_url = 'https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RWrmXv'

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
    $content = $response.Headers["Content-Disposition"] -split ";" | ForEach-Object { $_.Trim() } | Select-Object -Last 1

    $url64   = $content -split "=" | Select-Object -Last 1
    $filename = $url64 -split "-" | Select-Object -Last 1 | Split-Path -Leaf
    $version = [System.IO.Path]::GetFileNameWithoutExtension($filename)

    @{
        URL64   = $download_url
        Version = "$version"
    }
}

Update -ChecksumFor 64
