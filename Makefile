# Windows-compatible Makefile for Redis Server
CXX = g++
CXXFLAGS = -std=c++17 -Wall -O2
LDFLAGS = -lws2_32

SRC_DIR = src
BUILD_DIR = build

SRCS := $(wildcard $(SRC_DIR)/*.cpp)
OBJS := $(patsubst $(SRC_DIR)/%.cpp, $(BUILD_DIR)/%.o, $(SRCS))

TARGET = my_redis_server.exe

all: $(TARGET)

$(BUILD_DIR):
	if not exist $(BUILD_DIR) mkdir $(BUILD_DIR)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(TARGET): $(OBJS)
	$(CXX) $(OBJS) -o $(TARGET) $(LDFLAGS)

clean:
	if exist $(BUILD_DIR) rmdir /s /q $(BUILD_DIR)
	if exist $(TARGET) del $(TARGET)

rebuild: clean all

run: all
	./$(TARGET)

# Alternative for MSVC compiler (uncomment if using Visual Studio)
# CXX = cl
# CXXFLAGS = /std:c++17 /EHsc /W3
# LDFLAGS = ws2_32.lib
# TARGET = my_redis_server.exe
