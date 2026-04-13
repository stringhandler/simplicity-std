# run-examples.ps1 — builds and runs all examples inside Docker
# Does NOT require the devcontainer to be running.
# Requires: Docker

$ErrorActionPreference = "Stop"

$repoRoot = $PSScriptRoot
if (-not $repoRoot) { $repoRoot = (Get-Location).Path }

$image = "simp-std-dev"

Write-Host "Building dev image..."
docker build -t $image "$repoRoot/.devcontainer"
if ($LASTEXITCODE -ne 0) {
    Write-Error "docker build failed"
    exit $LASTEXITCODE
}

Write-Host "Generating and bundling std..."
& "$repoRoot/build.ps1"
if ($LASTEXITCODE -ne 0) {
    Write-Error "build.ps1 failed"
    exit $LASTEXITCODE
}

Write-Host "Running examples..."
docker run --rm `
  -v "${repoRoot}:/workspace" `
  -w /workspace `
  $image `
  bash examples/build_examples.sh

if ($LASTEXITCODE -ne 0) {
    Write-Error "Examples failed"
    exit $LASTEXITCODE
}
