@echo off
echo Building Redis Server for Windows...

REM Check if g++ is available
where g++ >nul 2>nul
if %errorlevel% neq 0 (
    echo Error: g++ compiler not found!
    echo Please install MinGW-w64 or use Visual Studio with MSVC compiler.
    echo For MinGW-w64: https://www.mingw-w64.org/downloads/
    pause
    exit /b 1
)

REM Build the project
make clean
make all

if %errorlevel% equ 0 (
    echo.
    echo Build successful! Running Redis Server...
    echo Press Ctrl+C to stop the server
    echo.
    my_redis_server.exe
) else (
    echo.
    echo Build failed! Please check the error messages above.
    pause
) 