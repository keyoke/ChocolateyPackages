if (-not (Get-Module -Name AU)) {
    Import-Module -Name AU
}
$progressPreference = 'silentlyContinue' 

$download_url = 'https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RWrxrH'

function global:au_SearchReplace {
   @{ }
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
        FileType = "msi"
    }
}

function global:au_BeforeUpdate() {
    Get-RemoteFiles -Purge -FileNameBase "Microsoft.RDInfra.RDAgentBootLoader.Installer"
}

Update -ChecksumFor none
