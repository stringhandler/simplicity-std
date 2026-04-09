# generate.ps1 — regenerates all auto-generated .simf files via the Haskell codegen
# Requires: Docker (does NOT require GHC installed locally)
# Usage: ./generate.ps1

$ErrorActionPreference = "Stop"

$repoRoot = $PSScriptRoot
if (-not $repoRoot) { $repoRoot = (Get-Location).Path }

Write-Host "Running code generator..."

docker run --rm `
  -v "${repoRoot}:/workspace" `
  -w /workspace `
  haskell:9.6 `
  runghc codegen/Main.hs

if ($LASTEXITCODE -ne 0) {
    Write-Error "Generator failed with exit code $LASTEXITCODE"
    exit $LASTEXITCODE
}

Write-Host "Done."
