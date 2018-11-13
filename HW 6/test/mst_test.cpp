#include "mst.h"
#include <UnitTest++/UnitTest++.h>

using namespace ipd;

TEST(Kruskal_TEST1)
{
    WU_graph g(7);
    g.add_edge(1, 2, 7);
    g.add_edge(2, 3, 9);
    g.add_edge(3, 4, 15);
    g.add_edge(4, 1, 6);
    g.add_edge(4, 2, 22);

    WU_graph mst = kruskal(g);
    auto result_edges = get_all_edges(mst);

    CHECK_EQUAL(1, result_edges[0].u);
    CHECK_EQUAL(2, result_edges[0].v);
    CHECK_EQUAL(7, result_edges[0].w);
    CHECK_EQUAL(2, result_edges[1].u);
    CHECK_EQUAL(3, result_edges[1].v);
    CHECK_EQUAL(9, result_edges[1].w);
    CHECK_EQUAL(1, result_edges[2].u);
    CHECK_EQUAL(4, result_edges[2].v);
    CHECK_EQUAL(6, result_edges[2].w);
}

TEST(Kruskal_TEST2)
{
    WU_graph g(7);
    g.add_edge(1, 2, 7);
    g.add_edge(1, 3, 9);
    g.add_edge(1, 6, 14);
    g.add_edge(2, 3, 10);
    g.add_edge(2, 4, 15);
    g.add_edge(3, 4, 11);
    g.add_edge(3, 6, 2);
    g.add_edge(4, 5, 6);
    g.add_edge(5, 6, 9);

    WU_graph mst = kruskal(g);
    auto result_edges = get_all_edges(mst);

    CHECK_EQUAL(1, result_edges[0].u);
    CHECK_EQUAL(2, result_edges[0].v);
    CHECK_EQUAL(7, result_edges[0].w);
    CHECK_EQUAL(1, result_edges[1].u);
    CHECK_EQUAL(3, result_edges[1].v);
    CHECK_EQUAL(9, result_edges[1].w);
    CHECK_EQUAL(4, result_edges[2].u);
    CHECK_EQUAL(5, result_edges[2].v);
    CHECK_EQUAL(6, result_edges[2].w);
    CHECK_EQUAL(3, result_edges[3].u);
    CHECK_EQUAL(6, result_edges[3].v);
    CHECK_EQUAL(2, result_edges[3].w);
    CHECK_EQUAL(5, result_edges[4].u);
    CHECK_EQUAL(6, result_edges[4].v);
    CHECK_EQUAL(9, result_edges[4].w);
}