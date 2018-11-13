#include <iostream>
#include "minmax_heap.h"

MM_Heap::MM_Heap(int size) {
    current_ = 0;
    heap_.resize(size);
}

void MM_Heap::insert(int element) {
    int parent = ++current_ / 2;
    if(current_ == heap_.size())
    {
        cerr << "MM_heap_ is full" << endl;
        return;
    }

    if(parent == 0)
    {
        heap_[1] = element;
        return;
    }

    if(check_level(current_) && element < heap_[parent])
    {
        check_min_level(current_, element);
    }
    else if(check_level(current_) && element >= heap_[parent])
    {
        heap_[current_] = heap_[parent];
        check_max_level(parent, element);
    }
    else if(!check_level(current_) && element < heap_[parent])
    {
        heap_[current_] = heap_[parent];
        check_min_level(parent, element);
    }
    else if(!check_level(current_) && element >= heap_[parent])
    {
        check_max_level(current_, element);
    }
    show_all_elements();
}

int MM_Heap::delete_min() {
    int min_element;
    if(current_ == 0)
    {
        cerr << "MM_Heap is empty" << endl;
        return -1;
    }

    min_element = heap_[1];
    heap_[1] = heap_[current_];

    trickle_down_min(1);
    current_--;

    show_all_elements();
    return min_element;
}

int MM_Heap::delete_max() {
    int max_element;
    if(current_ == 0)
    {
        cerr << "MM_Heap is empty" << endl;
        return -1;
    }
    if(current_ == 1)
        max_element = heap_[1];
    else if(current_ == 2)
        max_element = heap_[2];
    else
    {
        if(heap_[2] > heap_[3])
        {
            max_element = heap_[2];
            heap_[2] = heap_[current_];
            trickle_down_max(2);
        }
        else
        {
            max_element = heap_[3];
            heap_[3] = heap_[current_];
            trickle_down_max(3);
        }
    }
    current_--;

    show_all_elements();
    return max_element;
}

void MM_Heap::show_all_elements() {
    cout << "MinMax_Heap = ";
    for(int i=1; i<=current_; i++)
        cout << heap_[i] << " ";
    cout << endl;
}

bool MM_Heap::check_level(int current) {
    int grandparent = current / 4;
    int parent = current / 2;

    if(grandparent == 0)
        return false;
    if(heap_[grandparent] <= heap_[parent])
        return true;
    else
        return false;
}

void MM_Heap::check_min_level(int index, int element) {
    int grandparent = index / 4;
    while(grandparent && element < heap_[grandparent])
    {
        heap_[index] = heap_[grandparent];
        index = grandparent;
        grandparent = grandparent / 4;
    }
    heap_[index] = element;
}

void MM_Heap::check_max_level(int index, int element) {
    int grandparent = index / 4;
    while(grandparent && element > heap_[grandparent])
    {
        heap_[index] = heap_[grandparent];
        index = grandparent;
        grandparent = grandparent / 4;
    }
    heap_[index] = element;
}

void MM_Heap::trickle_down_min(int index) {
    int parent, grandparent;
    int left_child, right_child;
    int min_at;

    if(current_ >= index * 2)
    {
        min_at = find_min_at(index);
        grandparent = min_at / 4;
        parent = min_at / 2;

        left_child = index * 2;
        right_child = index * 2 + 1;

        if(index == grandparent)
        {
            if(heap_[min_at] < heap_[index])
            {
                swap_values(&heap_[min_at], &heap_[index]);
                if(heap_[min_at] > heap_[parent])
                    swap_values(&heap_[min_at], &heap_[parent]);
                trickle_down_min(min_at);
            }
        }
        else if(min_at == left_child || min_at == right_child)
        {
            if(heap_[min_at] < heap_[index])
                swap_values(&heap_[min_at], &heap_[index]);
        }
    }
}

void MM_Heap::trickle_down_max(int index) {
    int parent, grandparent;
    int left_child, right_child;
    int max_at;

    if(current_ >= index * 2)
    {
        max_at = find_max_at(index);
        grandparent = max_at / 4;
        parent = max_at / 2;

        left_child = index * 2;
        right_child = index * 2 + 1;

        if(index == grandparent)
        {
            if(heap_[max_at] > heap_[index])
            {
                swap_values(&heap_[max_at], &heap_[index]);
                if(heap_[max_at] < heap_[parent])
                    swap_values(&heap_[max_at], &heap_[parent]);
                trickle_down_max(max_at);
            }
        }
        else if(max_at == left_child || max_at == right_child)
        {
            if(heap_[max_at] > heap_[index])
                swap_values(&heap_[max_at], &heap_[index]);
        }
    }
}

int MM_Heap::find_min_at(int index) {
    int min = index * 2;
    int i, j, inum;
    for(i=2; i <= current_; i=i*2)
    {
        for(j=0; j<i; j++)
        {
            inum = i * index + j;
            if(inum <= current_)
            {
                if(heap_[inum] <= heap_[min])
                    min = inum;
            }
            else
                break;
        }
    }
    return min;
}

int MM_Heap::find_max_at(int index) {
    int max = index * 2;
    int i, j, inum;
    for(i=2; i <= current_; i=i*2)
    {
        for(j=0; j<i; j++)
        {
            inum = i * index + j;
            if(inum <= current_)
            {
                if(heap_[inum] >= heap_[max])
                    max = inum;
            }
            else
                break;
        }
    }
    return max;
}

void MM_Heap::swap_values(int *a, int *b )
{
    int c = *a;
    *a = *b;
    *b = c;
}