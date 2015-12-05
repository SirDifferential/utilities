cmake_minimum_required(VERSION 2.6)
set(CMAKE_CXX_COMPILER g++)
set(CMAKE_INSTALL_PREFIX /opt)
project(osc_receiver)

add_definitions(-std=c++11 -g -o0 2>&1)

SET (cpp_files osc_receiver.cpp
        osc/OscOutboundPacketStream.cpp
        osc/OscPrintReceivedElements.cpp
        osc/OscReceivedElements.cpp
        osc/OscTypes.cpp
        ip/IpEndpointName.cpp)

SET(h_files osc/OscException.h
        osc/OscHostEndianness.h
        osc/OscOutboundPacketStream.h
        osc/OscPacketListener.h
        osc/OscPrintReceivedElements.h
        osc/OscReceivedElements.h
        osc/OscTypes.h
        ip/IpEndpointName.h
        ip/NetworkingUtils.h
        ip/PacketListener.h
        ip/TimerListener.h
        ip/UdpSocket.h)

if (WIN32)
    LIST(APPEND cpp_files ip/win32/NetworkingUtils.cpp)
    LIST(APPEND cpp_files ip/win32/UdpSocket.cpp)
ELSE()
    LIST(APPEND cpp_files ip/posix/NetworkingUtils.cpp)
    LIST(APPEND cpp_files ip/posix/UdpSocket.cpp)
ENDIF()

add_executable(osc_receiver ${cpp_files} ${h_files})
target_link_libraries(osc_receiver)

