# build.ps1 — generates all std/src/*.simf source files then bundles them
#             into a single mcpp-compatible dist/std.simf.
# Requires: Docker (does NOT require GHC installed locally)
# Usage: ./build.ps1

$ErrorActionPreference = "Stop"

$repoRoot = $PSScriptRoot
if (-not $repoRoot) { $repoRoot = (Get-Location).Path }

function Run-Haskell {
    param([string]$Script)
    docker run --rm `
      -v "${repoRoot}:/workspace" `
      -w /workspace `
      haskell:9.6 `
      runghc $Script
    if ($LASTEXITCODE -ne 0) {
        Write-Error "$Script failed with exit code $LASTEXITCODE"
        exit $LASTEXITCODE
    }
}

Write-Host "Step 1: generating source files..."
Run-Haskell "codegen/Main.hs"

Write-Host "Step 2: bundling dist/mcpp/std.simf and dist/lib/std.simf..."
Run-Haskell "codegen/Bundle.hs"

Write-Host "Done."
