@echo off
setlocal enabledelayedexpansion

set "SCRIPTNAME=%~nx0"
set "FOLDER=%~dp0"

:MainMenu
cls
echo ============================================================
echo   SHA256 AND MD5 HASH COLLECTION SCRIPT
echo   https://ravenastar.com/cmd/cHashes
echo ============================================================
echo.
echo   This script will generate SHA256 and MD5 hashes for all
echo   files in the current folder and its subfolders.
echo.
echo   [ 1 ] Start collection
echo   [ 2 ] Exit
echo.
echo ============================================================
choice /c 12 /n /m "Option: "
if errorlevel 2 goto ExitScript
if errorlevel 1 goto CollectAll
goto MainMenu

:CollectAll
cls
echo ============================================================
echo   COLLECTING HASHES FOR ALL FILES
echo   https://ravenastar.com/cmd/cHashes
echo ============================================================
echo.
echo Folder analyzed: %FOLDER%
echo.
echo This may take a few minutes...
echo.
echo Press ENTER to start or CTRL+C to cancel.
set /p dummy=

call :StartCollection

echo.
echo ============================================================
echo   COLLECTION COMPLETED SUCCESSFULLY!
echo ============================================================
echo.
echo Statistics:
echo    Total files processed: !COUNT!
echo    SHA256 hashes generated successfully: !SUCCESS_COUNT_SHA!
echo    MD5 hashes generated successfully: !SUCCESS_COUNT_MD5!
echo    Errors: !ERROR_COUNT!
echo.
echo Report generated: %OUTFILE%
echo.
echo Press ENTER to return to the main menu...
pause >nul
goto MainMenu

:StartCollection
for /f "tokens=2 delims==" %%a in ('wmic os get localdatetime /value') do set "DATETIME=%%a"
set "TIMESTAMP=%DATETIME:~0,4%%DATETIME:~4,2%%DATETIME:~6,2%%DATETIME:~8,2%%DATETIME:~10,2%%DATETIME:~12,2%"

set "OUTFILE=%FOLDER%%TIMESTAMP%.txt"
set "OUTNAME=%TIMESTAMP%.txt"

set "COUNT=0"
set "ERROR_COUNT=0"
set "SUCCESS_COUNT_SHA=0"
set "SUCCESS_COUNT_MD5=0"

if exist "%OUTFILE%" del "%OUTFILE%" 2>nul

(
echo ============================================================
echo   HASH COLLECTION - SHA256 AND MD5
echo ============================================================
echo.
echo Tool used: ravenastar.com/cmd/cHashes
echo.
echo Execution date/time : %date% %time%
echo.
echo ----------------------------------------------------------
) > "%OUTFILE%"

echo.
echo Processing files...
echo.
echo Output file: %OUTNAME%
echo.

for /r "%FOLDER%" %%F in (*) do call :ProcessFile "%%F"

goto :eof

:ProcessFile
set "FILEPATH=%~1"
set "FILENAME=%~nx1"
set "SKIP=0"

if /i "!FILENAME!"=="%SCRIPTNAME%" set "SKIP=1"
if /i "!FILENAME!"=="%OUTNAME%" set "SKIP=1"

if "!SKIP!"=="1" goto :eof

set /a COUNT+=1
set "FSIZE=%~z1"
set "FDATE=%~t1"
set "RELATIVEPATH=!FILEPATH:%FOLDER%=!"

set "HASH_SHA="
for /f "skip=1 delims=" %%H in ('certutil -hashfile "!FILEPATH!" SHA256 2^>nul') do (
    if "!HASH_SHA!"=="" set "HASH_SHA=%%H"
)
set "HASH_SHA=!HASH_SHA: =!"

set "HASH_MD5="
for /f "skip=1 delims=" %%H in ('certutil -hashfile "!FILEPATH!" MD5 2^>nul') do (
    if "!HASH_MD5!"=="" set "HASH_MD5=%%H"
)
set "HASH_MD5=!HASH_MD5: =!"

if "!FSIZE!"=="0" (
    set "HASH_SHA=e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
    set "HASH_MD5=d41d8cd98f00b204e9800998ecf8427e"
)

if "!HASH_SHA!"=="" (
    set "HASH_SHA=ERROR - SHA256 hash not generated"
    set /a ERROR_COUNT+=1
) else (
    set /a SUCCESS_COUNT_SHA+=1
)

if "!HASH_MD5!"=="" (
    set "HASH_MD5=ERROR - MD5 hash not generated"
    set /a ERROR_COUNT+=1
) else (
    set /a SUCCESS_COUNT_MD5+=1
)

call :WriteReport
echo [!COUNT!] Processed: !RELATIVEPATH!
goto :eof

:WriteReport
(
echo File                 : !RELATIVEPATH!
echo Size                 : !FSIZE! bytes
echo Last modified        : !FDATE!
echo SHA256               : !HASH_SHA!
echo MD5                  : !HASH_MD5!
echo ----------------------------------------------------------
) >> "%OUTFILE%"
goto :eof

:ExitScript
cls
echo ============================================================
echo   SCRIPT ENDED
echo ============================================================
echo.
pause >nul
exit /b
