#include "suffix_trie.h"

Suffix_Trie::Suffix_Trie() {
    check_end_ = false;
}

Suffix_Trie::Suffix_Trie(char ch) {
    value_ = ch;
    check_end_ = false;
}

void Suffix_Trie::insert(string words) {
    for(unsigned int i=0; i<words.length(); i++)
    {
        int ch = words[i];
        if(children_[ch] == NULL)
            children_[ch] = new Suffix_Trie(words[i]);

        if(words.substr(i+1, words.length()-i) == "")
            children_[ch]->check_end_ = true;
        else
            children_[ch]->insert_topdown(words.substr(i+1, words.length()-i));
    }
}

bool Suffix_Trie::find_string(string words) {
    if(check_end_ && words == "")
        return true;

    int ch = words[0];
    if(children_[ch] == NULL)
        return false;
    return children_[ch]->find_string(words.substr(1, words.length()));

}

void Suffix_Trie::insert_topdown(string words) {
    int ch = words[0];
    if(children_[ch] == NULL)
        children_[ch] = new Suffix_Trie(words[0]);

    if(words.substr(1, words.length()) == "")
        children_[ch]->check_end_ = true;
    else
        children_[ch]->insert_topdown(words.substr(1, words.length()));
}
