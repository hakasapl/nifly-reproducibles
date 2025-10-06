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

# Get 1st CLI argument as the cmake variable CASE_NAME
if ($args.Count -ge 1) {
    $caseName = $args[0]
}
else {
    Write-Error "Please provide a case name as the first argument."
    exit 1
}

# Configure
cmake -B $buildDir -S $scriptDir -G Ninja `
    -DCASE_NAME="$caseName" `
    -DCMAKE_BUILD_TYPE=Debug

# Build
cmake --build $buildDir
