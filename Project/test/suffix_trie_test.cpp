#include "suffix_trie.h"
#include <UnitTest++/UnitTest++.h>

TEST(SUFFIX_TRIE_TEST1)
{
    Suffix_Trie st;
    st.insert("NorthWestern");

    CHECK_EQUAL(true, st.find_string("Western"));
    CHECK_EQUAL(false, st.find_string("South"));
    CHECK_EQUAL(false, st.find_string("North"));
    CHECK_EQUAL(true, st.find_string("ern"));
}

TEST(SUFFIX_TRIE_TEST2)
{
    Suffix_Trie st;
    st.insert("abcdaa");

    CHECK_EQUAL(false, st.find_string("ab"));
    CHECK_EQUAL(false, st.find_string("baa"));
    CHECK_EQUAL(false, st.find_string("abcd"));
    CHECK_EQUAL(false, st.find_string("abcda"));
    CHECK_EQUAL(false, st.find_string("aaa"));
    CHECK_EQUAL(false, st.find_string("daaa"));
    CHECK_EQUAL(true, st.find_string("aa"));
    CHECK_EQUAL(true, st.find_string("daa"));
    CHECK_EQUAL(true, st.find_string("cdaa"));
    CHECK_EQUAL(true, st.find_string("abcdaa"));
}

TEST(SUFFIX_TRIE_TEST3)
{
    Suffix_Trie st;
    st.insert("banana");

    CHECK_EQUAL(false, st.find_string("ab"));
    CHECK_EQUAL(false, st.find_string("banan"));
    CHECK_EQUAL(false, st.find_string("anan"));
    CHECK_EQUAL(false, st.find_string("nan"));
    CHECK_EQUAL(false, st.find_string("an"));
    CHECK_EQUAL(false, st.find_string("n"));
    CHECK_EQUAL(true, st.find_string("na"));
    CHECK_EQUAL(true, st.find_string("ana"));
    CHECK_EQUAL(true, st.find_string("nana"));
}