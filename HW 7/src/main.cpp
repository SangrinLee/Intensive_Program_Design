#include <iostream>
using namespace std;
#include "hexapawn.h"

int main()
{
    int setx(0), sety(0);
    int flag = 0;

    do {
        cout << "Welcome to Hexapawn!\n";
        cout << "How may chess do you want?(number! 3~8)\n";
        cin >> setx;
        cout << "What's the y value of chessboard?(number! 3~8)\n";
        cin >> sety;

        if (setx < 3 || setx > 8 || sety < 3 || sety >8)
            cout<<"Invalid Input !!"<<endl;
    }while (setx < 3 || setx > 8 || sety < 3 || sety >8);

    cout << "Press any key to start the Game\n";
    cin.sync();
    getchar();

    Manager m(setx, sety);
    while (!m.check_game_over(flag)) {

        //set player's chess pos
        m.show_chessboard();
        if (!m.show_choice(flag)){
            //if no choices, game over;
            break;
        }
        //change player
        flag ^= 1;
    }

    m.show_chessboard();
    if (flag == 0)
        cout<<endl<<"Black LOSE!"<<endl;
    if (flag == 1)
        cout<<endl<<"White LOSE!"<<endl;
    return 0;
}