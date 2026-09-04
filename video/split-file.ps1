<#
PowerShell script to split a large binary file into fixed-size chunks.
Usage:
  .\split-file.ps1 -InputFile 'C:\path\to\large.file' -ChunkSizeMB 100 -OutputDir 'C:\path\to\chunks'
#>
param(
    [Parameter(Mandatory=$true)] [string]$InputFile,
    [int]$ChunkSizeMB = 50,
    [string]$OutputDir = (Split-Path -Parent $InputFile)
)

if (-not (Test-Path $InputFile)) { throw "Input file not found: $InputFile" }
if (-not (Test-Path $OutputDir)) { New-Item -ItemType Directory -Path $OutputDir | Out-Null }

$chunkSize = $ChunkSizeMB * 1MB
$baseName = (Split-Path -Leaf $InputFile)
$index = 0

$fs = [System.IO.File]::OpenRead($InputFile)
try {
    $buffer = New-Object byte[] $chunkSize
    while ($true) {
        $read = $fs.Read($buffer, 0, $buffer.Length)
        if ($read -le 0) { break }
        $index++
        $outName = "{0}.part{1:D4}" -f $baseName, $index
        $outPath = Join-Path $OutputDir $outName
        $outFs = [System.IO.File]::Open($outPath, [System.IO.FileMode]::Create)
        try { $outFs.Write($buffer, 0, $read) } finally { $outFs.Close() }
        Write-Host "Wrote $outPath ($read bytes)"
    }
} finally { $fs.Close() }

Write-Host "Completed: $index parts created in $OutputDir"
Write-Host "Tip: verify with Get-FileHash -Algorithm SHA256 before/after joining to ensure integrity."