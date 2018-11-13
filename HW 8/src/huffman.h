#include <iostream>
#include <fstream>
#include <memory>
#include <string.h>
#include <algorithm>
#include <cassert>
#include <utility>
#include <vector>

#pragma once

using namespace std;

class HNode
{
private:
	friend class Heap;
	HNode(int f, void *s)
	{
		frequency = f;
		symbol = s;
	}
	int frequency;
	void *symbol;
};

class Heap
{
public:
	Heap()
	{
		hindex_ = 0;
	}
    // add elements into the heap
	bool add(int frequency, void *hnode)
	{
		if(hindex_ >= 256)
			return false;
		hnode_[hindex_] = new HNode(frequency, hnode);
		int parent;
		int child = hindex_;
		while(get_parent(parent,child))
		{
			if(hnode_[parent]->frequency > hnode_[child]->frequency)
			{
				HNode *temp = hnode_[parent];
				hnode_[parent] = hnode_[child];
				hnode_[child] = temp;
			}
			else
				break;
			child = parent;
		}
		++hindex_;
		return true;
	}
    // get the minimum elements from the heap
	bool get_min(void *&hnode)
	{
		if(hindex_ == 0)
			return false;
		hnode = hnode_[0]->symbol;
		delete hnode_[0];
		hindex_ = hindex_-1;
		hnode_[0] = hnode_[hindex_];

		int parent = 0;
		int left_child;
		int right_child;
		while(true)
		{
			int current = parent;
			if(!get_left_child(parent, left_child))
				return true;
			if (hnode_[parent]->frequency > hnode_[left_child]->frequency)
				current = left_child;
			if(get_right_child(parent,right_child))
				if(hnode_[current]->frequency > hnode_[right_child]->frequency)
					current = right_child;
			if (parent == current)
				break;

			HNode *temp = hnode_[parent];
			hnode_[parent] = hnode_[current];
			hnode_[current] = temp;

			parent = current;
		}
		return true;
	}
    // get the left child of the parent
	bool get_left_child(int parent, int &left_child)
	{
		left_child = parent * 2 + 1;
		if(left_child >= hindex_)
			return false;
		return true;
	}
    // get the right child of the parent
	bool get_right_child(int parent, int &right_child)
	{
		right_child = parent * 2 + 2;
		if(parent >= hindex_)
			return false;
		return true;
	}
    // get the parent of the child
	bool get_parent(int &parent, int child)
	{
		if(child == 0)
			return false;
		parent = (child - 1)/2;
		return true;
	}
private:
	HNode *hnode_[256];
	int hindex_;
};

class Node
{
	friend class HuffmanCode;
	Node(char s, int f, Node *l = NULL, Node *r = NULL)
	{
		symbol = s;
		frequency = f;
		left = l;
		right = r;
	}
private:
	char symbol;
	int frequency;
	Node *left;
	Node *right;
};

struct Symbols
{
	char symbol;
	int hcode;
	int length;
};

union Byte
{
	unsigned char value;
	struct code
	{
		char b0:1;
		char b1:1;
		char b2:1;
		char b3:1;
		char b4:1;
		char b5:1;
		char b6:1;
		char b7:1;
	}bit_fields;
};

class HuffmanCode
{
public:
	HuffmanCode()
	{
		root_ = NULL;
		memset(symbols_, 0, sizeof(symbols_));
		index_ = 0;
	}
    // makes heap for nodes with symbol and frequency
	void make_heap()
	{
		int sym[257];
		char s;
		memset(sym, 0, sizeof(sym));

		ifstream fin("testcase.txt");
		while(!fin.eof() && fin.get(s))
			sym[s] = sym[s] + 1;

		for(int i=0; i<256; i++)
		{
			if(sym[i])
			{
				Node *node = new Node(i, sym[i]);
				heap_.add(sym[i], node);
			}
		}

		sym[256] = 10000;
		Node *eof = new Node(256, sym[256]);
		heap_.add(sym[256], eof);
	}
    // makes huffman tree using heap
	void make_huff_tree()
	{
		while(true)
		{
			void *parent;
			heap_.get_min(parent);
			Node *left_node = (Node *)parent;
			Node *right_node;
			if(!heap_.get_min(parent))
			{
				root_ = left_node;
				return;
			}
			right_node = (Node *)parent;

			int sum = left_node->frequency + right_node->frequency;
			Node *node = new Node(' ', sum, left_node, right_node);
			heap_.add(sum, node);
		}
	}
    // makes symbol tables which has the information of symbols and their frequencies.
	void make_symbol_table(Node *root, size_t hcode, size_t length)
	{
		if (root == NULL)
			return;
		if (root->left != NULL)
			make_symbol_table(root->left, hcode << 1, length+1);
		if (root->right != NULL)
			make_symbol_table(root->right, (hcode << 1)|1, length+1);
		if (root->left == NULL && root->right == NULL)
		{
			symbols_[index_].symbol = root->symbol;
			symbols_[index_].hcode = hcode;
			symbols_[index_++].length = length;
		}
	}
    // makes encoding of the file
	void huff()
	{
		ifstream fin("testcase.txt");
		ofstream fout("testcase.huff.txt");
		Byte byte;
		byte.value = NULL;
		int count = 0;
		while(true)
		{
			int index = -1;
			char c;
			fin.get(c);
			if(fin.eof())
			{
				while(count < 8)
				{
					switch(count)
					{
						case 0:	byte.bit_fields.b7 = 1;	break;
						case 1:	byte.bit_fields.b6 = 1;	break;
						case 2: byte.bit_fields.b5 = 1;	break;
						case 3: byte.bit_fields.b4 = 1;	break;
						case 4:	byte.bit_fields.b3 = 1;	break;
						case 5:	byte.bit_fields.b2 = 1;	break;
						case 6:	byte.bit_fields.b1 = 1;	break;
						case 7:	byte.bit_fields.b0 = 1;	break;
					}
					count++;
				}
				fout.put(byte.value);
				break;
			}
			for(int i = 0;i < index_;i++)
				if (symbols_[i].symbol == c)
					index = i;

			if (index >= 0)
			{
				int check_bit = 1;
				for(int i=0; i<symbols_[index].length-1; i++)
					check_bit = check_bit << 1;

				for(int i=0; i<symbols_[index].length; i++)
				{
					if (symbols_[index].hcode & check_bit)
					{
						switch(count)
						{
						case 0:	byte.bit_fields.b7 = 1;	break;
						case 1:	byte.bit_fields.b6 = 1;	break;
						case 2: byte.bit_fields.b5 = 1;	break;
						case 3: byte.bit_fields.b4 = 1;	break;
						case 4:	byte.bit_fields.b3 = 1;	break;
						case 5:	byte.bit_fields.b2 = 1;	break;
						case 6:	byte.bit_fields.b1 = 1;	break;
						case 7:	byte.bit_fields.b0 = 1;	break;
						}
					}
					check_bit = check_bit >> 1;
					count++;
					if(count%8 == 0)
					{
						fout.put(byte.value);
						byte.value = NULL;
						count = 0;
					}
				}
			}
		}
	}
    // makes decoding of the file
	void puff()
	{
		FILE *file = fopen("testcase.huff.txt","r");
		int index(0), count(8), len(0);
		char *buf(NULL);

		fseek(file, 0, SEEK_END);
		len = ftell(file);
		buf = new char[len];

		ifstream fin("testcase.huff.txt");
		fin.read(buf, len);
		ofstream fout("testcase.puff.txt");
		make_puff(root_, buf, len, index, count, fout);
	}
    // helper function for decoing the file
	void make_puff(Node *root, char *buf, int len, int index, int count, ofstream &fout)
	{
		if(count == 0)
		{
			index++;
			count = 8;
		}

		int check_bit = 1;
		for(int i=0; i<count-1; i++)
			check_bit = check_bit << 1;

		if (root->left != NULL && root->right != NULL)
		{
			if (buf[index] & check_bit)
				make_puff(root->right, buf, len, index, --count, fout);
			else
				make_puff(root->left, buf, len, index, --count, fout);
		}
		else
		{
			fout.put(root->symbol);
			if (len == index+1)
				return;
			if (buf[index] & check_bit)
				make_puff(root_->right, buf, len, index, --count, fout);
			else
				make_puff(root_->left, buf, len, index, --count, fout);
		}
	}

	Node* Root () { return root_; }

private:
	Node *root_;
	Symbols symbols_[256];
	size_t index_;
	Heap heap_;
};

