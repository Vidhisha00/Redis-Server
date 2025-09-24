# Redis

Redis is an open-source, in-memory database that supports a variety of data structures, including strings, hashes, lists, sets, and sorted sets. It’s highly performant, making it ideal for caching, real‑time analytics, messaging, and managing application state.

## Features

This Redis server implementation supports:
- Basic key-value operations (SET, GET, DEL)
- List operations (LPUSH, RPUSH, LPOP, RPOP, etc.)
- Hash Operations(HSET, HGET, HEXISTS, HDEL, HGETALL, HKEYS / HVALS, HLEN, HMSET)
- Key expiration (EXPIRE)
- Database persistence (automatic saving)
- Multi-threaded client handling

## Concepts

1. TCP/IP  and Socket Programming
2. Concurrency and Multithreading
3. Mutex and Sync..
4. Data Structures -> Hash Tables, Vectors
5. Parsing and RESP protocol 
6. File I/O Persistence
7. Signal Handling
8. Command Processing and Response Formatting 
9. Singleton Pattern 
10. std libraries

## Building the Project

### Using CMake
```cmd
mkdir build
cd build
cmake ..
cmake --build .
```

## Running the Server

After a successful build, make a connection with the server:
```cmd
./my_redis_server.exe
```

The server will start listening on port 6379 by default. 
```cmd
redis-cli -p 6379
```

## Testing the Server

Testing the server using the Redis client. Note: You need to install Redis on your system.

```cmd
redis-cli -h localhost -p 6379
```

## Stopping the Server

Press `Ctrl+C` to stop the server. The database will be automatically saved to `dump.my_rdb`.

## Flow of the Redis Server


## Architecture of the Server





