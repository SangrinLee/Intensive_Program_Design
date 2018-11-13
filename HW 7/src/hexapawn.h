#include <iostream>
#include <string>
#include <vector>

using namespace std;
struct pos {
    int x;
    int y;

    pos(int ix, int iy){
        x = ix;
        y = iy;
    }
};

class Manager
{

public:

    //Constructor, Initialize the chessboard
    Manager(int, int);

    // Displays all the state of the board depending on the positions of white & black pawns
    void show_chessboard();

    // Displays all the available moves of the pawns
    bool show_choice(int);

    // Checks if the pawn is possible to move on the board
    vector<pos> check_possible_move(pos, int) const;

    // Moves the pawn to the requested position on board
    void move_the_chess(pair<pos,pos>, int);

    // Checks if the game is over
    bool check_game_over(int);

    //hepler-function, show the array_ of the array_[x][y]
    char show_pos(int x, int y){
        return array_[x][y];
    }

private:
    int row_, col_;
    vector<vector<char>> array_;
};