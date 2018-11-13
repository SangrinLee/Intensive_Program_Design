#include "Union_find.h"

namespace ipd
{
    // Union_find : size_t -> Union_find
    // Creates a new union-find of `n` objects, and initializes all member variables.
    // Union_find::Union_find(size_t n) { ... }
    Union_find::Union_find(size_t n) {
        count_ = n;
        parent_.resize(n);
        rank_.resize(n);
        for(size_t i = 0; i < n; i++)
        {
            parent_[i] = i;
            rank_[i] = 1;
        }
    }

    // size : void -> size_t
    // Returns the number of objects in the union-find.
    // size_t Union_find::size() const { ... }
    size_t Union_find::size() const {
        return count_;
    }

    // do_union : size_t size_t -> void
    // Unions the sets specified by the two given objects.
    // void Union_find::do_union(size_t obj1, size_t obj2) { ... }
    void Union_find::do_union(size_t obj1, size_t obj2) {
        size_t root1 = find(obj1);
        size_t root2 = find(obj2);

        if(root1 == root2)
            return;
        if(rank_[root1] < rank_[root2])
            parent_[root1] = root2;
        else if(rank_[root1] > rank_[root2])
            parent_[root2] = root1;
        else
        {
            parent_[root2] = root1;
            rank_[root1]++;
        }
        count_--;
    }

    // find : size_t -> size_t
    // Finds the set representative for a given object.
    // size_t Union_find::find(size_t obj) { ... }
    size_t Union_find::find(size_t obj) {
        if(parent_[obj] != obj)
            parent_[obj] = find(parent_[obj]);
        return parent_[obj];
    }
}
