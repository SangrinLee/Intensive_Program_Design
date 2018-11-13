#pragma once

#include "WU_graph.h"
#include "Union_find.h"
#include <iostream>
#include <algorithm>

namespace ipd
{
    // Computes a minimum spanning forest by Kruskal's algorithm.
    WU_graph kruskal(const WU_graph&);
}
