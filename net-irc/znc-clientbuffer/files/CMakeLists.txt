# Autogenerated using znc-buildmod -v from net-irc/znc-1.8.2
cmake_minimum_required(VERSION 3.1)
project(ExternalModules LANGUAGES CXX)
find_package(ZNC HINTS /usr/share/znc REQUIRED)

add_library(module_clientbuffer MODULE clientbuffer.cpp)
znc_setup_module(TARGET module_clientbuffer NAME clientbuffer)
target_link_libraries(module_clientbuffer PRIVATE)
