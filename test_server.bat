@echo off
echo Testing Redis Server...
echo.

REM Check if server executable exists
if not exist my_redis_server.exe (
    echo Error: my_redis_server.exe not found!
    echo Please build the project first using: make all
    pause
    exit /b 1
)

echo Starting Redis Server in background...
start /B my_redis_server.exe

REM Wait a moment for server to start
timeout /t 2 /nobreak >nul

echo.
echo Testing basic Redis commands...
echo.

REM Test PING command
echo Testing PING...
echo PING | telnet localhost 6379 2>nul | findstr PONG
if %errorlevel% equ 0 (
    echo ✓ PING test passed
) else (
    echo ✗ PING test failed
)

echo.
echo Server is running on localhost:6379
echo You can test it manually using:
echo   telnet localhost 6379
echo.
echo Or use any Redis client with:
echo   Host: localhost
echo   Port: 6379
echo.
echo Press any key to stop the server...
pause >nul

REM Stop the server
taskkill /f /im my_redis_server.exe >nul 2>&1
echo Server stopped. 