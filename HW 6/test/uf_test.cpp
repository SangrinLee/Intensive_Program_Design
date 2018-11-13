#include "Union_find.h"
#include <UnitTest++/UnitTest++.h>

using namespace ipd;

TEST(Uf_TEST1)
{
    Union_find uf0(0);
    Union_find uf2(2);
    Union_find uf4(4);

    CHECK_EQUAL(0, uf0.size());
    CHECK_EQUAL(2, uf2.size());
    CHECK_EQUAL(4, uf4.size());
}

TEST(Uf_TEST2)
{
    Union_find uf(3);

    uf.do_union(0, 1);
    uf.do_union(0, 2);

    CHECK_EQUAL(0, uf.find(1));
    CHECK_EQUAL(0, uf.find(2));
}

TEST(Uf_TEST3)
{
    Union_find uf(10);

    uf.do_union(3, 4);
    uf.do_union(3, 5);
    uf.do_union(3, 6);
    uf.do_union(4, 7);
    uf.do_union(4, 8);
    uf.do_union(4, 9);

    CHECK_EQUAL(3, uf.find(4));
    CHECK_EQUAL(3, uf.find(6));
    CHECK_EQUAL(3, uf.find(7));
    CHECK_EQUAL(3, uf.find(9));
}

TEST(Uf_TEST4)
{
    Union_find uf(10);

    uf.do_union(0, 1);
    uf.do_union(0, 2);
    uf.do_union(3, 4);
    uf.do_union(3, 5);
    uf.do_union(3, 6);
    CHECK_EQUAL(3, uf.find(6));
    uf.do_union(4, 7);
    uf.do_union(4, 8);
    CHECK_EQUAL(3, uf.find(8));
    uf.do_union(4, 9);
    uf.do_union(0, 3);

    CHECK_EQUAL(0, uf.find(0));
    CHECK_EQUAL(0, uf.find(2));
    CHECK_EQUAL(0, uf.find(3));
    CHECK_EQUAL(0, uf.find(4));
    CHECK_EQUAL(0, uf.find(7));
    CHECK_EQUAL(0, uf.find(8));
}