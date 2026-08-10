$ErrorActionPreference = "Stop"

$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
$ThreeRoot = Join-Path $Root "vendor\three"
$Controls = Join-Path $ThreeRoot "addons\controls"

New-Item -ItemType Directory -Force -Path $ThreeRoot | Out-Null
New-Item -ItemType Directory -Force -Path $Controls | Out-Null

$Files = @(
    @{ Url = "https://cdn.jsdelivr.net/npm/three@0.180.0/build/three.core.js"; Out = (Join-Path $ThreeRoot "three.core.js") },
    @{ Url = "https://cdn.jsdelivr.net/npm/three@0.180.0/build/three.module.js"; Out = (Join-Path $ThreeRoot "three.module.js") },
    @{ Url = "https://cdn.jsdelivr.net/npm/three@0.180.0/examples/jsm/controls/OrbitControls.js"; Out = (Join-Path $Controls "OrbitControls.js") },
    @{ Url = "https://cdn.jsdelivr.net/npm/three@0.180.0/examples/jsm/controls/TransformControls.js"; Out = (Join-Path $Controls "TransformControls.js") }
)

Write-Host ""
Write-Host "Magnetic CAD Playground - offline preparation"
Write-Host "Vendoring pinned Three.js 0.180.0..."
Write-Host ""

foreach ($File in $Files) {
    $Name = Split-Path -Leaf $File.Out
    Write-Host "  $Name"
    Invoke-WebRequest -UseBasicParsing -Uri $File.Url -OutFile $File.Out
}

Invoke-WebRequest -UseBasicParsing -Uri "https://cdn.jsdelivr.net/npm/three@0.180.0/LICENSE" -OutFile (Join-Path $ThreeRoot "LICENSE")

$Required = @(
    (Join-Path $ThreeRoot "three.core.js"),
    (Join-Path $ThreeRoot "three.module.js"),
    (Join-Path $Controls "OrbitControls.js"),
    (Join-Path $Controls "TransformControls.js"),
    (Join-Path $ThreeRoot "LICENSE")
)

foreach ($Path in $Required) {
    if (!(Test-Path $Path) -or ((Get-Item $Path).Length -lt 100)) {
        throw "Offline dependency preparation failed: $Path"
    }
}

Write-Host ""
Write-Host "Done."
Write-Host "All runtime dependencies are now local."
Write-Host "Disconnect from the internet and launch Open_MagneticCAD.bat."
Write-Host ""
Write-Host "Commit the vendor/ folder to GitHub so fresh clones are offline-ready too."
Write-Host ""
