cmake_minimum_required(VERSION 3.3)
project(mst CXX)
include(.ipd/CMakeLists.txt)

add_test_program(minmax_heap_test
        test/minmax_heap_test.cpp src/minmax_heap.h src/minmax_heap.cpp)

add_test_program(suffix_trie_test
        test/suffix_trie_test.cpp src/suffix_trie.h src/suffix_trie.cpp)
