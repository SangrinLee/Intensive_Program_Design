#include <string>
#include <unordered_map>

using namespace std;

class Suffix_Trie{
public:
    // Constructor : Initializes all memeber variables.
    Suffix_Trie();

    // Constructor : Initializes all memeber variables.
    Suffix_Trie(char);

    // inserts a strings, and constructs suffix_trie
    void insert(string);

    // check if Suffix_Trie contains specified string. If so, returns true, otherwise false
    bool find_string(string);

private:
    // data structure for Suffix_Trie.
    unordered_map<char, Suffix_Trie*> children_;

    // member variable to check if Suffix_Trie is end or not.
    bool check_end_;

    // member variable to store each character into node
    char value_;

    // inserts each nodes from top to leaf
    void insert_topdown(string);
};