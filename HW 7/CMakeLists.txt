cmake_minimum_required(VERSION 3.3)
project(hexapawn CXX)
include(.ipd/CMakeLists.txt)

add_program(hexapawn
        src/hexapawn.h
        src/hexapawn.cpp
        src/main.cpp)

add_test_program(hexapawn_test
        test/hexapawn_test.cpp
        src/hexapawn.h
        src/hexapawn.cpp)