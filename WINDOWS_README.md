# Redis Server for Windows

This is a Windows-compatible version of the Redis server implementation.

## Prerequisites

You need one of the following C++ compilers installed:

### Option 1: MinGW-w64 (Recommended)
1. Download and install MinGW-w64 from: https://www.mingw-w64.org/downloads/
2. Add MinGW-w64 to your PATH environment variable
3. Verify installation by running: `g++ --version`

### Option 2: Visual Studio
1. Install Visual Studio Community (free) from: https://visualstudio.microsoft.com/
2. During installation, make sure to include "Desktop development with C++"
3. Use the provided CMakeLists.txt file

## Building the Project

### Method 1: Using Make (MinGW-w64)
```cmd
# Open Command Prompt or PowerShell in the project directory
make clean
make all
```

### Method 2: Using the provided batch file
```cmd
build.bat
```

### Method 3: Using CMake (Visual Studio or MinGW)
```cmd
mkdir build
cd build
cmake ..
cmake --build .
```

## Running the Server

After successful build, run the server:
```cmd
my_redis_server.exe
```

The server will start listening on port 6379 by default. You can specify a different port:
```cmd
my_redis_server.exe 6380
```

## Testing the Server

You can test the server using any Redis client or telnet:

### Using telnet:
```cmd
telnet localhost 6379
```

Then send Redis commands like:
```
PING
SET mykey myvalue
GET mykey
```

### Using redis-cli (if you have Redis installed):
```cmd
redis-cli -h localhost -p 6379
```

## Stopping the Server

Press `Ctrl+C` to gracefully stop the server. The database will be automatically saved to `dump.my_rdb`.

## Troubleshooting

### "g++ not found" error
- Make sure MinGW-w64 is installed and added to your PATH
- Restart your command prompt after installing

### "Permission denied" error
- Run Command Prompt as Administrator
- Make sure no other application is using port 6379

### "WSAStartup failed" error
- This is a Windows socket initialization error
- Try running as Administrator
- Check if Windows Firewall is blocking the application

### Build errors with Visual Studio
- Make sure you have the "Desktop development with C++" workload installed
- Use the CMakeLists.txt file instead of the Makefile

## Features

This Redis server implementation supports:
- Basic key-value operations (SET, GET, DEL)
- List operations (LPUSH, RPUSH, LPOP, RPOP, etc.)
- Hash operations (HSET, HGET, HDEL, etc.)
- Key expiration (EXPIRE)
- Database persistence (automatic saving)
- Multi-threaded client handling

## File Structure

- `src/` - Source code files
- `include/` - Header files
- `Makefile` - Build configuration for MinGW
- `CMakeLists.txt` - Build configuration for CMake
- `build.bat` - Windows batch file for easy building
- `my_redis_server.exe` - Compiled executable (after building) 