#include "minmax_heap.h"
#include <UnitTest++/UnitTest++.h>
#include <iostream>

using namespace std;

TEST(MM_HEAP_TEST1)
{
    cout << "========== TESTCASE 1 START ==========" << endl;
    MM_Heap mm_heap(100);

    mm_heap.insert(10);
    mm_heap.insert(2);
    mm_heap.insert(8);
    mm_heap.insert(4);
    mm_heap.insert(6);
    mm_heap.insert(12);

    CHECK_EQUAL(2, mm_heap.delete_min());
    CHECK_EQUAL(12, mm_heap.delete_max());
    CHECK_EQUAL(4, mm_heap.delete_min());
    CHECK_EQUAL(10, mm_heap.delete_max());
    CHECK_EQUAL(8, mm_heap.delete_max());
    CHECK_EQUAL(6, mm_heap.delete_max());
    cout << "========== TESTCASE 1 END ==========" << endl;
}

TEST(MM_HEAP_TEST2)
{
    cout << "========== TESTCASE 2 START ==========" << endl;
    MM_Heap mm_heap(100);

    mm_heap.insert(1);
    mm_heap.insert(10);
    mm_heap.insert(20);
    mm_heap.insert(2);
    mm_heap.insert(3);
    mm_heap.insert(15);
    mm_heap.insert(16);
    mm_heap.insert(4);
    mm_heap.insert(5);
    mm_heap.insert(6);
    mm_heap.insert(7);
    mm_heap.insert(17);
    mm_heap.insert(18);

    CHECK_EQUAL(1, mm_heap.delete_min());
    CHECK_EQUAL(2, mm_heap.delete_min());
    CHECK_EQUAL(20, mm_heap.delete_max());
    CHECK_EQUAL(18, mm_heap.delete_max());
    CHECK_EQUAL(17, mm_heap.delete_max());
    CHECK_EQUAL(3, mm_heap.delete_min());
    CHECK_EQUAL(4, mm_heap.delete_min());
    CHECK_EQUAL(5, mm_heap.delete_min());
    CHECK_EQUAL(16, mm_heap.delete_max());
    CHECK_EQUAL(15, mm_heap.delete_max());
    CHECK_EQUAL(6, mm_heap.delete_min());
    CHECK_EQUAL(7, mm_heap.delete_min());
    CHECK_EQUAL(10, mm_heap.delete_min());
    cout << "========== TESTCASE 2 END ==========" << endl;
}

TEST(MM_HEAP_TEST3)
{
    cout << "========== TESTCASE 3 START ==========" << endl;
    MM_Heap mm_heap(100);

    mm_heap.insert(15);
    mm_heap.insert(16);
    mm_heap.insert(1);
    CHECK_EQUAL(16, mm_heap.delete_max());
    mm_heap.insert(7);
    mm_heap.insert(11);
    mm_heap.insert(2);
    mm_heap.insert(4);
    CHECK_EQUAL(1, mm_heap.delete_min());
    mm_heap.insert(13);
    mm_heap.insert(10);
    CHECK_EQUAL(15, mm_heap.delete_max());
    CHECK_EQUAL(2, mm_heap.delete_min());
    mm_heap.insert(12);
    mm_heap.insert(14);
    mm_heap.insert(6);
    CHECK_EQUAL(4, mm_heap.delete_min());
    CHECK_EQUAL(14, mm_heap.delete_max());
    mm_heap.insert(3);
    mm_heap.insert(9);
    CHECK_EQUAL(3, mm_heap.delete_min());
    mm_heap.insert(5);
    mm_heap.insert(8);
    CHECK_EQUAL(13, mm_heap.delete_max());
    CHECK_EQUAL(5, mm_heap.delete_min());
    CHECK_EQUAL(12, mm_heap.delete_max());
    cout << "========== TESTCASE 3 END ==========" << endl;
}

