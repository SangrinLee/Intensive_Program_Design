#include "common.h"
#include "bit_io.h"
#include "huffman.h"

int main(int argc, const char* argv[])
{
    /* Initializing Huffman Code */
	HuffmanCode huffman;
	huffman.make_heap();
	huffman.make_huff_tree();
	huffman.make_symbol_table(huffman.Root(), 0, 0);

    /* Decoding files */
	huffman.puff();
	return 0;
}