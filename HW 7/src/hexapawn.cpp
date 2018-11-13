#include "hexapawn.h"

Manager::Manager(int X, int Y)
{
    row_ = Y; col_ = X;

    array_.resize(row_);
    for(int i=0; i<row_; i++)
        array_.at(i).resize(col_);

    cout << array_.size() << "," << array_.at(1).size() << endl;

    for(int cx = 0; cx < row_; cx++)
    {
        for (int cy = 0; cy < col_; cy++)
        {
            if(cx == 0)
                array_[cx][cy] = 'B';
            else if(cx > 0 && cx < row_-1)
                array_[cx][cy] = '0';
            else if(cx == row_-1)
                array_[cx][cy] = 'W';
        }
    }

    /*
    for(int cx = 0; cx < row_; cx++)
    {
        vector<char> c;
        array_.push_back(c);
        for (int cy = 0; cy < col_; cy++)
        {
            if(cx == 0)
                array_[cx].push_back('B');
            else if(cx > 0 && cx < row_-1)
                array_[cx].push_back('0');
            else if(cx == row_-1)
                array_[cx].push_back('W');
        }
    }
    */
}

void Manager::show_chessboard() {

    //display the whole board
    cout<<"---------------------------"<<endl;
    cout<<"  ";
    for(int cx = 0 ; cx< col_; cx++)
        cout<<"  "<<cx<<"  ";

    cout<<endl;
    for(int cx = 0 ; cx< row_; cx++){
        cout<<cx<<":";
        for (int cy = 0; cy < col_; cy++){
            if (array_[cx][cy] == '0')
                cout<<" [ ] ";
            else
                cout<<" ["<<array_[cx][cy]<<"] ";
        }
        cout<<endl;
    }

    cout<<endl<<"Your Choice:"<<endl<<endl;
}

bool Manager::show_choice(int flag) {

    vector<pair<pos,pos>> choice;
    vector<pos> ret;
    int count = 0;
    int input;

    for(int cx = 0; cx < row_; cx++) {
        for (int cy = 0; cy < col_; cy++)
        {
            ret.clear();
            if(array_[cx][cy] == '0')
                continue;
            if(flag == 0 && array_[cx][cy] == 'B')
                ret = check_possible_move(pos(cx, cy), 0);
            else if(flag == 1 && array_[cx][cy] == 'W')
                ret = check_possible_move(pos(cx, cy), 1);

            for(auto &option : ret)
                choice.push_back(make_pair(pos(cx, cy), option));
        }
    }

    if (choice.size() == 0)
        return false;

    //display the choices using the C++ 'pair'
    vector<pair<pos, pos>>::iterator iter;
    for(iter=choice.begin();iter!=choice.end();iter++){
        cout<<count<<" :  ("<<iter->first.x<<","<<iter->first.y<<") -> (";
        cout<<iter->second.x<<","<<iter->second.y<<");"<<endl;
        count++;
    }

    cin>>input;
    //check if input is valid
    if (input < 0 || input > count - 1)
    {
        cout<<"Wrong Input !" <<endl;
        show_choice(flag);
    }
    move_the_chess(choice[input], flag);
    return true;
}

vector<pos> Manager::check_possible_move(pos p, int flag) const {

    vector<pos> res;

    //different player with different direction move
    //and different compare chess
    int index = (flag == 0 ? 1 : -1);
    char compare = (flag == 0 ? 'W' : 'B');

    //if next index is null
    if (array_[p.x + index][p.y] == '0')
        res.push_back(pos(p.x + index, p.y));

    //boundary chess only check for one diagonal position
    if (p.y == 0){
        if(array_[p.x + index][p.y + 1] == compare)
            res.push_back(pos(p.x + index, p.y + 1));
    }
    else if (p.y == col_ - 1)
    {
        if(array_[p.x + index][p.y - 1] == compare)
            res.push_back(pos(p.x + index, p.y - 1));
    }

        //otherwise check for both sides
    else {
        if (array_[p.x + index][p.y + 1] == compare)
            res.push_back(pos (p.x + index, p.y + 1));
        if (array_[p.x + index][p.y - 1] == compare)
            res.push_back(pos(p.x + index, p.y - 1));
    }

    return res;
}

void Manager::move_the_chess(pair<pos, pos> poss, int flag) {

    array_[poss.first.x][poss.first.y] = '0';

    if(flag)
        array_[poss.second.x][poss.second.y] = 'W';
    else
        array_[poss.second.x][poss.second.y] = 'B';
}

bool Manager::check_game_over(int flag) {

    int end;
    end = (flag==0 ? 0 : row_-1);

    for(int cx = 0; cx < row_; cx++) {
        for (int cy = 0; cy < col_; cy++)
        {
            if(flag == 0 && array_[0][cy] == 'W')
                return true;
            else if(flag == 1 && array_[row_-1][cy] == 'B')
                return true;
        }
    }
    return false;
}
