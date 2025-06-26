# PowerShell script to help install a C++ compiler on Windows
Write-Host "Redis Server - C++ Compiler Installation Helper" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Green
Write-Host ""

# Check if g++ is already available
try {
    $gppVersion = g++ --version 2>$null
    if ($gppVersion) {
        Write-Host "✓ g++ compiler found!" -ForegroundColor Green
        Write-Host $gppVersion[0] -ForegroundColor Yellow
        Write-Host ""
        Write-Host "You can now build the project using:" -ForegroundColor Cyan
        Write-Host "  make clean" -ForegroundColor White
        Write-Host "  make all" -ForegroundColor White
        Write-Host "  .\my_redis_server.exe" -ForegroundColor White
        exit 0
    }
} catch {
    # g++ not found, continue with installation options
}

# Check if cl.exe is available (Visual Studio)
try {
    $clVersion = cl 2>$null
    if ($clVersion) {
        Write-Host "✓ Visual Studio compiler (cl.exe) found!" -ForegroundColor Green
        Write-Host ""
        Write-Host "You can build using Visual Studio or modify the Makefile for MSVC." -ForegroundColor Cyan
        exit 0
    }
} catch {
    # cl.exe not found, continue with installation options
}

Write-Host "No C++ compiler found. Please choose an installation option:" -ForegroundColor Yellow
Write-Host ""

Write-Host "Option 1: Install MinGW-w64 (Recommended for beginners)" -ForegroundColor Cyan
Write-Host "  - Download from: https://www.mingw-w64.org/downloads/" -ForegroundColor White
Write-Host "  - Or use winget: winget install MSYS2.MSYS2" -ForegroundColor White
Write-Host ""

Write-Host "Option 2: Install Visual Studio Community (Free)" -ForegroundColor Cyan
Write-Host "  - Download from: https://visualstudio.microsoft.com/" -ForegroundColor White
Write-Host "  - Make sure to include 'Desktop development with C++'" -ForegroundColor White
Write-Host ""

Write-Host "Option 3: Use Chocolatey (if installed)" -ForegroundColor Cyan
Write-Host "  - Run: choco install mingw" -ForegroundColor White
Write-Host ""

Write-Host "After installation, restart this script to verify the compiler." -ForegroundColor Yellow
Write-Host ""

# Try to open the download pages
$choice = Read-Host "Would you like to open the MinGW-w64 download page? (y/n)"
if ($choice -eq 'y' -or $choice -eq 'Y') {
    Start-Process "https://www.mingw-w64.org/downloads/"
}

Write-Host ""
Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") 