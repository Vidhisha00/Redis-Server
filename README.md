# Redis

Redis is an open‑source, in‑memory database that supports a variety of data structures such as strings, hashes, lists, sets, and sorted sets. It’s highly performant, making it ideal for caching, real‑time analytics, messaging, and managing application state.

## Features

This Redis server implementation supports:
- Basic key-value operations (SET, GET, DEL)
- List operations (LPUSH, RPUSH, LPOP, RPOP, etc.)
- Hash operations (HSET, HGET, HDEL, etc.)
- Key expiration (EXPIRE)
- Database persistence (automatic saving)
- Multi-threaded client handling

## Building the Project

### Using CMake
```cmd
mkdir build
cd build
cmake ..
cmake --build .
```

## Running the Server

After a successful build, run the server:
```cmd
my_redis_server.exe
```

The server will start listening on port 6379 by default. 
```cmd
my_redis_server.exe 6379
```

## Testing the Server

Testing the server using the Redis client. Note: You need to install Redis on your system.

```cmd
redis-cli -h localhost -p 6379
```

## Stopping the Server

Press `Ctrl+C` to stop the server. The database will be automatically saved to `dump.my_rdb`.

