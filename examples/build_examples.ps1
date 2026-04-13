# build_examples.ps1 — preprocesses and compiles all *.simf examples
# Run from the examples/ directory or the repo root.
# Requires: mcpp, simc (both on PATH)

$ErrorActionPreference = "Stop"

$examplesDir = $PSScriptRoot
if (-not $examplesDir) { $examplesDir = (Get-Location).Path }

$examples = Get-ChildItem -Path $examplesDir -Filter "*.simf"
$failed = 0

foreach ($file in $examples) {
    $name = $file.BaseName
    $src  = $file.FullName
    $tmp  = Join-Path $examplesDir "$name.simf.tmp"

    Write-Host "Building $($file.Name)..."

    try {
        mcpp $src $tmp
        if ($LASTEXITCODE -ne 0) { throw "mcpp failed" }

        simc $tmp
        if ($LASTEXITCODE -ne 0) { throw "simc failed" }

        Write-Host "  OK"
    } catch {
        Write-Host "  FAILED: $_"
        $failed++
    } finally {
        if (Test-Path $tmp) { Remove-Item $tmp }
    }
}

if ($failed -gt 0) {
    Write-Error "$failed example(s) failed to build."
    exit 1
}

Write-Host "All examples built successfully."
