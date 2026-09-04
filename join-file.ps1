<#
PowerShell script to join chunk files (created by split-file.ps1) into the original file.
Usage:
  .\join-file.ps1 -PartsDir 'C:\path\to\chunks' -OutputFile 'C:\path\to\reconstructed.file' -PartPattern 'bigfile.mp4.part*'
If PartPattern is omitted, it uses '*.part*' and sorts by Name.
#>
param(
    [Parameter(Mandatory=$true)] [string]$PartsDir,
    [Parameter(Mandatory=$true)] [string]$OutputFile,
    [string]$PartPattern = "*.part*"
)

if (-not (Test-Path $PartsDir)) { throw "Parts directory not found: $PartsDir" }

$parts = Get-ChildItem -Path $PartsDir -Filter $PartPattern | Sort-Object Name
if ($parts.Count -eq 0) { throw "No parts found matching pattern '$PartPattern' in $PartsDir" }

$outFs = [System.IO.File]::Open($OutputFile, [System.IO.FileMode]::Create)
try {
    foreach ($p in $parts) {
        Write-Host "Appending $($p.Name)"
        $inFs = [System.IO.File]::OpenRead($p.FullName)
        try {
            $buffer = New-Object byte[] (4MB)
            while (($read = $inFs.Read($buffer, 0, $buffer.Length)) -gt 0) {
                $outFs.Write($buffer, 0, $read)
            }
        } finally { $inFs.Close() }
    }
} finally { $outFs.Close() }

Write-Host "Completed: created $OutputFile"
Write-Host "Tip: run Get-FileHash -Algorithm SHA256 on the reconstructed file and original to verify."