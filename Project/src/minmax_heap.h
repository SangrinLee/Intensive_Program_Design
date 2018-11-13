#include <vector>

using namespace std;

class MM_Heap{
public:
    // Constructor : Initializes all memeber variables.
    MM_Heap (int);

    // insert elements into min-max heap
    void insert(int);

    // deletes the element with lowest value, and then reconstruct the heap to stay in min-max heap.
    int delete_min();

    // deletes the element with highest value, and then reconstruct the heap to stay in min-max heap.
    int delete_max();

private:
    // displays all the elements in heap
    void show_all_elements();

    // checks if the element is in min-level or max-level. If it is in min-level, return true. otherwise, return false
    bool check_level(int);

    // in case the element should be in min-level, find appropriate position within max-level and replace it with original one..
    void check_min_level(int, int);

    // in case the element should be in min-level, find appropriate position within min-level and replace it with original one.
    void check_max_level(int, int);

    // From the given index starting from topmost min level, tree is reconstructed based on min_max heap invariants
    void trickle_down_min(int index);

    // From the given index starting from topmost max level, tree is reconstructed based on min_max heap invariants
    void trickle_down_max(int index);

    // finds the element with lowest value within the heap from the given index.
    int find_min_at(int);

    // finds the element with highest value within the heap from the given index.
    int find_max_at(int);

    // swaps two values
    void swap_values(int*, int*);

    // data structure for min-max heap
    vector<int>heap_;
    // the number of elements in min-max heap, which indicates the last index of element.
    int current_;
};