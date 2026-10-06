@echo off
where python >nul 2>nul
if errorlevel 1 (
    echo.
    echo %ESC%[37;41m ERROR: Python is not installed or not added to PATH! %RESET%
    echo.
    pause
    exit
)
@mode 57, 17
@title Hax MultiTool v3 ^/^/^/ YT_DLP
setlocal EnableExtensions EnableDelayedExpansion
for /F %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"
set "WOR=%ESC%[37;41m"
set "RESET=%ESC%[0m"
set "selected=1"
set "maxoptions=3"
echo updating...
pip install --pre -U "yt-dlp[default,deno]" > nul
:start
cls
echo.
echo %ESC%[31m ===%ESC%[37m=====%RESET%
echo %ESC%[31m  YT%ESC%[37m-DLP%ESC%[0m
echo %ESC%[31m ===%ESC%[37m=====%RESET%
echo  Cmd Interface by Chroma
echo.
set /p "link=%ESC%[31m Link please:%ESC%[0m"
echo "%link%" | findstr /I /R "youtube\.com youtu\.be" >nul
if errorlevel 1 (
    echo.
    echo %ESC%[37;41m ERROR: Invalid Link! Please enter a valid YouTube URL. %RESET%
    echo.
    timeout /t 3 >nul
    goto start
)
cls
:menu
cls
echo.
echo %ESC%[31m ===%ESC%[37m=====%RESET%
echo %ESC%[31m  YT%ESC%[37m-DLP%ESC%[0m
echo %ESC%[31m ===%ESC%[37m=====%RESET%
echo  Cmd Interface by Chroma
echo.
echo %ESC%[31m===================================%RESET%
echo.

if %selected%==1 (echo   %WOR% [1] Best Audio   %RESET%) else (echo       [1] Best Audio)
if %selected%==2 (echo   %WOR% [2] Best Video   %RESET%) else (echo       [2] Best Video)
if %selected%==3 (echo   %WOR% [3] Both  %RESET%) else (echo       [3] Both)

echo.
echo %ESC%[31m===================================%RESET%

:: 4. Use PowerShell to intercept a single keypress (UpArrow, DownArrow, or Enter)
for /f "delims=" %%k in ('powershell -Command "[Console]::ReadKey($true).Key"') do set "key=%%k"

:: 5. Handle navigation logic
if "%key%"=="UpArrow" (
    set /a selected-=1
    if !selected! lss 1 set "selected=%maxoptions%"
    goto menu
)
if "%key%"=="DownArrow" (
    set /a selected+=1
    if !selected! gtr %maxoptions% set "selected=1"
    goto menu
)
if "%key%"=="Enter" (
    goto action
)

goto menu

:action
cls
if %selected%==1 (
    echo.
    echo Downloading with Best audio...
    echo.
    yt-dlp -f bestaudio -x --audio-format mp3 "%link%"
    pause
    goto start
)
if %selected%==2 (
    echo.
    echo Downloading with Best video...
    echo.
    yt-dlp -f bestvideo --merge-output-format mp4 "%link%"
    pause
    goto start
)
if %selected%==3 (
    echo.
    echo Getting the best of the best...
    echo.
    yt-dlp -f bestvideo+bestaudio --merge-output-format mp4 "%link%"
    pause
    goto start
)
echo there was an error.
timeout /t 3 >nul
goto start