$LoadedModules = Get-Module | Select Name
if (!$LoadedModules -like "*$ModuleName*") {
    import-module au
}
$progressPreference = 'silentlyContinue' 

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
    $response = Invoke-WebRequest -Method GET -UseBasicParsing -Uri $download_url -OutFile "$($PWD)\Microsoft.RDInfra.RDAgentBootLoader.Installer-x64.msi"

    $process = Start-Process "MSIEXEC" -ArgumentList "/a Microsoft.RDInfra.RDAgentBootLoader.Installer-x64.msi /qn TARGETDIR=$($PWD)\Microsoft.RDInfra.RDAgentBootLoader.Installer-x64\" -Wait -NoNewWindow
    
    if(!(Test-Path "$($PWD)\Microsoft.RDInfra.RDAgentBootLoader.Installer-x64\Microsoft RDInfra\RDAgentBootLoader\RDAgentBootLoader.exe" -PathType Leaf))
    {
        throw "'$($PWD)\Microsoft.RDInfra.RDAgentBootLoader.Installer-x64\Microsoft RDInfra\RDAgentBootLoader\RDAgentBootLoader.exe' does not exist!"
    }

    $version = [System.Diagnostics.FileVersionInfo]::GetVersionInfo("$($PWD)\Microsoft.RDInfra.RDAgentBootLoader.Installer-x64\Microsoft RDInfra\RDAgentBootLoader\RDAgentBootLoader.exe").FileVersion #.ProductVersion

    @{
        URL64   = $download_url
        Version = "$version"
    }
}

Update -ChecksumFor 64
