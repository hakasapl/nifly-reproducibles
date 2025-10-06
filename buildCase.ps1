# Enable strict mode for safer scripting
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# Get the current script directory
$scriptDir = $PSScriptRoot
if (-not $scriptDir) {
    $scriptDir = (Get-Location).Path
}

# Setup folders with absolute paths
$buildDir = Join-Path -Path $scriptDir -ChildPath "build"
if (-not (Test-Path -Path $buildDir -PathType Container)) {
    New-Item -Path $buildDir -ItemType Directory -Force | Out-Null
}

# Configure
cmake -B $buildDir -S . -G Ninja `
    -DCMAKE_BUILD_TYPE=Debug

# Build and install
cmake --build $buildDir