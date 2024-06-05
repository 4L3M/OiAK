cmake_minimum_required(VERSION 3.27)
project(OIAK)

set(CMAKE_CXX_STANDARD 17)

add_executable(OIAK main.cpp
        Timer.cpp
        Timer.h
        FileReader.cpp
        FileReader.h
        DataGenerator.cpp
        DataGenerator.h
        BbAlgorithm.cpp
        BbAlgorithm.h
        NehAlgorithm.cpp
        NehAlgorithm.h)
