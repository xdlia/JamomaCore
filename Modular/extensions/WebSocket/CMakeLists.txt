cmake_minimum_required(VERSION 3.0)
project(WebSocket)

if(ANDROID OR WIN64 OR MINGW)
	message("Does not work yet on Win64 and android and mingw")
	return()
endif()
if(CMAKE_GENERATOR MATCHES "Visual Studio 14")
	message("Does not work yet on VS2015")
	return()
endif()

set(PROJECT_SRCS
	$<TARGET_OBJECTS:TTProtocol>
${CMAKE_CURRENT_SOURCE_DIR}/source/WebSocket.cpp
${CMAKE_CURRENT_SOURCE_DIR}/source/WebSocketAnswer.cpp
${CMAKE_CURRENT_SOURCE_DIR}/source/WebSocketAnswerManager.cpp
${CMAKE_CURRENT_SOURCE_DIR}/source/WebSocketSenderManager.cpp
${CMAKE_CURRENT_SOURCE_DIR}/libjson/_internal/Source/internalJSONNode.cpp
${CMAKE_CURRENT_SOURCE_DIR}/libjson/_internal/Source/JSONAllocator.cpp
${CMAKE_CURRENT_SOURCE_DIR}/libjson/_internal/Source/JSONChildren.cpp
${CMAKE_CURRENT_SOURCE_DIR}/libjson/_internal/Source/JSONDebug.cpp
${CMAKE_CURRENT_SOURCE_DIR}/libjson/_internal/Source/JSONIterators.cpp
${CMAKE_CURRENT_SOURCE_DIR}/libjson/_internal/Source/JSONMemory.cpp
${CMAKE_CURRENT_SOURCE_DIR}/libjson/_internal/Source/JSONNode_Mutex.cpp
${CMAKE_CURRENT_SOURCE_DIR}/libjson/_internal/Source/JSONNode.cpp
${CMAKE_CURRENT_SOURCE_DIR}/libjson/_internal/Source/JSONPreparse.cpp
${CMAKE_CURRENT_SOURCE_DIR}/libjson/_internal/Source/JSONStream.cpp
${CMAKE_CURRENT_SOURCE_DIR}/libjson/_internal/Source/JSONValidator.cpp
${CMAKE_CURRENT_SOURCE_DIR}/libjson/_internal/Source/JSONWorker.cpp
${CMAKE_CURRENT_SOURCE_DIR}/libjson/_internal/Source/JSONWriter.cpp
${CMAKE_CURRENT_SOURCE_DIR}/libjson/_internal/Source/libjson.cpp
)

include_directories("${PROJECT_SOURCE_DIR}/")
include_directories("${PROJECT_SOURCE_DIR}/includes")
include_directories("${PROJECT_SOURCE_DIR}/libjson")

if(CMAKE_BUILD_TYPE STREQUAL "Debug")
	add_definitions(-DTT_PROTOCOL_DEBUG)
	add_definitions(-DJAMOMA_WEBSOCKET_JSON_DEBUG)
else()
	add_definitions(-DNDEBUG)
endif()

file(GLOB_RECURSE PROJECT_HDRS ${CMAKE_CURRENT_SOURCE_DIR}/includes/*.h)
add_jamoma_extension()

if(WIN32)
	target_link_libraries(${PROJECT_NAME} PRIVATE winmm)
endif()

if(BUILD_JAMOMAPD)
        install(TARGETS ${PROJECT_NAME}
                        DESTINATION "${JAMOMAPD_INSTALL_FOLDER}/Jamoma/support"
                        COMPONENT JamomaPd)
endif()
