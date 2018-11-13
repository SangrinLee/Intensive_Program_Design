#include "mst.h"

namespace ipd
{
    // kruskal : &WU_graph -> WU_graph
    // Computes a minimum spanning forest by Kruskal's algorithm.
    // WU_graph kruskal(const WU_graph &graph) { ... }
    WU_graph kruskal(const WU_graph &graph)
    {
        WU_graph result(graph.size());
        Union_find uf(graph.size());

        auto edges = get_all_edges(graph);
        std::cout << "<< All the edges before Kruskal Algorithm >>\n";
        for (size_t i = 0; i < edges.size(); ++i)
            std::cout << "   From "
                      << edges.at(i).u << " To "
                      << edges.at(i).v << " = "
                      << edges.at(i).w << "\n";


        sort(edges.begin(), edges.end(),
        [] (WU_edge const& a, WU_edge const& b) { return a.w < b.w; } );

        for(auto edge : edges)
        {
            int a = uf.find(edge.u);
            int b = uf.find(edge.v);

            if(a != b)
            {
                result.add_edge(edge.u, edge.v, edge.w);
                uf.do_union(a, b);
            }
        }

        auto result_edges = get_all_edges(result);
        std::cout << "<< All the edges after Kruskal Algorithm >>\n";
        for (size_t i = 0; i < result_edges.size(); ++i)
            std::cout << "   From "
                      << result_edges.at(i).u << " To "
                      << result_edges.at(i).v << " = "
                      << result_edges.at(i).w << "\n";
        std::cout << "\n";

        return result;
    }
}
