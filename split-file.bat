@echo off
REM split-file.bat - wrapper that calls split-file.ps1 in the same folder
REM Usage: split-file.bat "C:\path\big.mp4" [ChunkSizeMB] [OutputDir]

if "%~1"=="" goto usage
set "InputFile=%~1"
set "ChunkSizeMB=%~2"
set "OutputDir=%~3"
if "%ChunkSizeMB%"=="" set "ChunkSizeMB=50"
if "%OutputDir%"=="" set "OutputDir=%~dp1"

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0split-file.ps1" -InputFile "%InputFile%" -ChunkSizeMB %ChunkSizeMB% -OutputDir "%OutputDir%"
exit /b %ERRORLEVEL%

:usage
echo Usage: %~nx0 "C:\path\file" [ChunkSizeMB] [OutputDir]
exit /b 1
