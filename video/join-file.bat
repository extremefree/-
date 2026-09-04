@echo off
REM join-file.bat - wrapper that calls join-file.ps1 in the same folder
REM Usage: join-file.bat "C:\path\to\parts" "C:\path\to\output.file" [PartPattern]

if "%~1"=="" goto usage
set "PartsDir=%~1"
set "OutputFile=%~2"
set "PartPattern=%~3"
if "%OutputFile%"=="" echo Missing OutputFile & goto usage
if "%PartPattern%"=="" set "PartPattern=*.part*"

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0join-file.ps1" -PartsDir "%PartsDir%" -OutputFile "%OutputFile%" -PartPattern "%PartPattern%"
exit /b %ERRORLEVEL%

:usage
echo Usage: %~nx0 "C:\path\to\parts" "C:\path\to\output.file" [PartPattern]
exit /b 1
