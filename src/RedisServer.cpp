#include "../include/RedisServer.h"
#include "../include/RedisCommandHandler.h"
#include "../include/RedisDatabase.h"

#include <iostream>
#include <vector>
#include <thread>
#include <cstring>
#include <winsock2.h>
#include <ws2tcpip.h>
#include <windows.h>

#pragma comment(lib, "ws2_32.lib")

// Global pointer for signal handling
static RedisServer* globalServer = nullptr;

BOOL WINAPI signalHandler(DWORD ctrlType) {
    if (globalServer) {
        std::cout << "\nCaught signal " << ctrlType << ", shutting down...\n";
        globalServer->shutdown();
    }
    return TRUE;
}

void RedisServer::setupSignalHandler() {
    SetConsoleCtrlHandler(signalHandler, TRUE);
}

RedisServer::RedisServer(int port) : port(port), server_socket(INVALID_SOCKET), running(true) {
    globalServer = this;
    
    // Initialize Winsock
    WSADATA wsaData;
    int result = WSAStartup(MAKEWORD(2, 2), &wsaData);
    if (result != 0) {
        std::cerr << "WSAStartup failed: " << result << std::endl;
        return;
    }
    
    setupSignalHandler();
}

void RedisServer::shutdown() {
    running = false;
    if (server_socket != INVALID_SOCKET) {
        // Before shutdown, persist the database
        if (RedisDatabase::getInstance().dump("dump.my_rdb"))
            std::cout << "Database Dumped to dump.my_rdb\n";
        else 
            std::cerr << "Error dumping database\n";
        closesocket(server_socket);
    }
    
    // Cleanup Winsock
    WSACleanup();
    std::cout << "Server Shutdown Complete!\n";
}

void RedisServer::run() {
    server_socket = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
    if (server_socket == INVALID_SOCKET) {
        std::cerr << "Error Creating Server Socket: " << WSAGetLastError() << std::endl;
        return;
    }

    // Set socket option to reuse address
    int opt = 1;
    if (setsockopt(server_socket, SOL_SOCKET, SO_REUSEADDR, (char*)&opt, sizeof(opt)) == SOCKET_ERROR) {
        std::cerr << "setsockopt failed: " << WSAGetLastError() << std::endl;
        closesocket(server_socket);
        return;
    }

    sockaddr_in serverAddr{};
    serverAddr.sin_family = AF_INET;
    serverAddr.sin_port = htons(port);
    serverAddr.sin_addr.s_addr = INADDR_ANY;

    if (bind(server_socket, (struct sockaddr*)&serverAddr, sizeof(serverAddr)) == SOCKET_ERROR) {
        std::cerr << "Error Binding Server Socket: " << WSAGetLastError() << std::endl;
        closesocket(server_socket);
        return;
    }

    if (listen(server_socket, 10) == SOCKET_ERROR) {
        std::cerr << "Error Listening On Server Socket: " << WSAGetLastError() << std::endl;
        closesocket(server_socket);
        return;
    } 

    std::cout << "Redis Server Listening On Port " << port << "\n";

    std::vector<std::thread> threads;
    RedisCommandHandler cmdHandler;

    while (running) {
        SOCKET client_socket = accept(server_socket, nullptr, nullptr);
        if (client_socket == INVALID_SOCKET) {
            if (running) 
                std::cerr << "Error Accepting Client Connection: " << WSAGetLastError() << std::endl;
            break;
        }

        threads.emplace_back([client_socket, &cmdHandler](){
            char buffer[1024];
            while (true) {
                memset(buffer, 0, sizeof(buffer));
                int bytes = recv(client_socket, buffer, sizeof(buffer) - 1, 0);
                if (bytes <= 0) break;
                std::string request(buffer, bytes);
                std::string response = cmdHandler.processCommand(request);
                send(client_socket, response.c_str(), response.size(), 0);
            }
            closesocket(client_socket);
        });
    }
    
    for (auto& t : threads) {
        if (t.joinable()) t.join();
    }

    // Before shutdown, persist the database
    if (RedisDatabase::getInstance().dump("dump.my_rdb"))
        std::cout << "Database Dumped to dump.my_rdb\n";
    else 
        std::cerr << "Error dumping database\n";
}
