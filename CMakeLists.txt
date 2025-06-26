cmake_minimum_required(VERSION 3.10)
project(RedisServer)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Find source files
file(GLOB_RECURSE SOURCES "src/*.cpp")

# Create executable
add_executable(my_redis_server ${SOURCES})

# Include directories
target_include_directories(my_redis_server PRIVATE include)

# Link libraries
if(WIN32)
    target_link_libraries(my_redis_server ws2_32)
endif()

# Set output directory
set_target_properties(my_redis_server PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}
)

# Copy executable to project root for convenience
add_custom_command(TARGET my_redis_server POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_if_different
    $<TARGET_FILE:my_redis_server>
    ${CMAKE_SOURCE_DIR}/my_redis_server.exe
) 