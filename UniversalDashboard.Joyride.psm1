$IndexJs = Get-ChildItem "$PSScriptRoot\index.*.bundle.js"
$AssetId = [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($IndexJs.FullName)

$File = Get-ChildItem "$PSScriptRoot\index.*.bundle.map"
[UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($File.FullName) | Out-Null

function New-UDJoyride {
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),
        [Parameter(Mandatory)]
        [Hashtable[]]$Step,
        [Parameter()]
        [Switch]$Run
    )

    End {
        @{
            assetId  = $AssetId 
            isPlugin = $true 
            type     = "ud-joyride"
            id       = $Id
            steps    = $Step
            run      = $Run.IsPresent
        }
    }
}

function New-UDJoyrideStep {
    param(
        [Parameter(Mandatory)]
        [string]$Target,

        [Parameter(Mandatory, ParameterSetName = 'Text')]
        [string]$Text,
        
        [Parameter(Mandatory, ParameterSetName = 'Content')]
        [scriptblock]$Content
    )

    @{
        target  = $Target
        content = if ($Content) { & $Content } else { $Text }
    }
}