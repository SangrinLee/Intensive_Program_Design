#include "hexapawn.h"
#include <UnitTest++/UnitTest++.h>

using namespace std;
TEST(Hexapawn_TEST1)
{
    Manager m(3, 3);

    CHECK_EQUAL('B', m.show_pos(0, 0));
    CHECK_EQUAL('B', m.show_pos(0, 1));
    CHECK_EQUAL('B', m.show_pos(0, 2));
    CHECK_EQUAL('0', m.show_pos(1, 0));
    CHECK_EQUAL('0', m.show_pos(1, 1));
    CHECK_EQUAL('0', m.show_pos(1, 2));
    CHECK_EQUAL('W', m.show_pos(2, 0));
    CHECK_EQUAL('W', m.show_pos(2, 1));
    CHECK_EQUAL('W', m.show_pos(2, 2));
}

TEST(Hexapawn_TEST2)
{
    Manager m(3, 3);

    pos x(0, 1);
    pos y(1, 1);
    vector<pos> ret = m.check_possible_move(x, 0);
    vector<pos> should_be;
    should_be.push_back(y);

    CHECK_EQUAL(should_be[0].x, ret[0].x);
    CHECK_EQUAL(should_be[0].y, ret[0].y);
}

TEST(Hexapawn_TEST3)
{
    Manager m(3, 3);

    CHECK_EQUAL(false, m.check_game_over(0));
    CHECK_EQUAL(false, m.check_game_over(1));
}



