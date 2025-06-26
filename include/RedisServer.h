#ifndef REDIS_SERVER_H
#define REDIS_SERVER_H

#include <string>
#include <atomic>
#include <winsock2.h>

class RedisServer {
public:
    RedisServer(int port);
    void run();
    void shutdown();

private:
    int port;
    SOCKET server_socket;
    std::atomic<bool> running;

    // Setup signal handling for graceful shutdown (ctrl + c) 
    void setupSignalHandler();
};

#endif