* how you tested your programs to ensure correctness

- Test for Union_find(test/uf_test.cpp Uf_TEST4)
First, I created Union_find with 10 elements.
Then, initial state should be like
{0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}, {8}, {9}
After uf.do_union(0, 1), it should be like {0, 1}, {2}, {3}, {4}, {5}, {6}, {7}, {8}, {9}
so, {0} is pointing itself as it is initialized inside constructor,
and the parent of {1} is pointing {0}(case the rank of them are same, just it makes the first one parent).
Also, the rank of {0} increases by 1.
Like before, when doing uf.do_union(0, 2), it should be like {0, 1, 2}, {3}, {4}, {5}, {6}, {7}, {8}, {9}.
So, {0} is pointing itself, {1} is pointing {0}, and {2} is pointing {0}.
In this case, rank doesn't change in any of them because the rank of {0, 1} and {2} was different.
Likewise, some do_union operation are done as shown below.
uf.do_union(3, 4);
uf.do_union(3, 5);
uf.do_union(3, 6);
uf.do_union(4, 7);
uf.do_union(4, 8);
uf.do_union(4, 9);
uf.do_union(0, 3);
and the final result of uf.find(any number) is 0.

- Test for MST(test/mst_test.cpp Kruskal_TEST2)
I started by creating 7 vertices by using WU_graph g(7).
Then added 9 edges as shown below.
g.add_edge(1, 2, 7);
g.add_edge(1, 3, 9);
g.add_edge(1, 6, 14);
g.add_edge(2, 3, 10);
g.add_edge(2, 4, 15);
g.add_edge(3, 4, 11);
g.add_edge(3, 6, 2);
g.add_edge(4, 5, 6);
g.add_edge(5, 6, 9);
I called kruskal(g) to get the minimum spanning tree by kruskal algorithm.
And then I got all the vector of WU_edge by calling get_all_edges function.
The result I got this is shown below.
From 1 To 2 = 7
From 1 To 3 = 9
From 4 To 5 = 6
From 3 To 6 = 2
From 5 To 6 = 9
In CHECK_EQUAL operation, I checked if two vertices and weight of each WU_edge is correct.
In addition to this test case, I added the result of all edges before kruskal algorithms applied and after it
to clarify what exactly the graph holds(two vertices and weight between them).
that is shown in result message after running mst_test.cpp.


* anything that surprised you while doing this assignment.
1. when using vector instead of pointer to an array, it's dynamically sized,
which means I don't need to allocate memory using new keyword.
However, it still needs to require "resize" of the vector to approach element using vector_name.[number]
(in case of using push_back, no need).
That's where I was surprised because I thought dynamically allocating is quite identical to
using any element before I officially allocate it(by using push_back, or resizing operation).

2. I tried to figure out what the rank should be based on, and noticed that there're two ways.
One is a rank based on height, and the other is a rank based on the size of WU_graph(to be specific, size of edges).
In case of the latter one which I tried at first, I found it complicated because I need to consider
a way from root to the furthest leaf(which I could implement by using reverse path compression),
and the time complexity is worse. So I chose a rank based on height.

3. Doing_union(A, B),
where the rank of A is 3, and the rank of B is 3, and both A and B are the root, makes a tree with rank 4.
However, I noticed that calling "find" function with every furthest leaf such as find(a), find(b),
where a and b are the leaf, doesn't change the rank of whole tree, which should have changed.
Rather, it might make inbalanced tree when I call do_union in future.
To fix this problem, I guess I need to have another data structure to keep track of information from root to every leaf.
The time complexity is worse, so I excluded this special case
(because, find is basically called inside do_union, not called outside of it individually).

4. I didn't noticed the "auto" keyword until I saw the one in WU_graph.cpp.
There seems to be a drawback of "auto" keyword as it is determined in running time.
So, I guess it might be a bit hard to utilize it with "static" variables in class,
as "static" variable is created in compiling time.

5. When accessing vector with [] keyword, It basically doesn't check "bounds checks".
And I can't check "bounds checks" whenever I approach some elements as well.
So I used ".at()" keyword, which checks "bounds checks" automatically.
