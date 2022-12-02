#include <stdio.h>

void run1() {
    int ret;
    int player1 = 0, player2 = 0;
    int score = 0;

    for (;;) {
        // " %c" (with empty space before %c) means:
        // consume all consecutive whitespace, then read a char
        ret = scanf(" %c %c", &player1, &player2);
        if (ret != 2) {
            break;
        }

        player1 -= 'A';
        player2 -= 'X';

        score += player2+1;

        switch((player2-player1+3) % 3) {
        case 0:
            score += 3;
            break;
        case 1:
            score += 6;
            break;
        case 2:
            score += 0;
            break;
        }
    }

    printf("%d\n", score);
}

#define NEED_TO_LOSE 0
#define NEED_TO_DRAW 1
#define NEED_TO_WIN 2

void run2() {
    int ret;
    int player1 = 0, need_to = 0;
    int score = 0;

    for (;;) {
        ret = scanf(" %c %c", &player1, &need_to);
        if (ret != 2) {
            break;
        }

        player1 -= 'A';
        need_to -= 'X';

        score += need_to*3;

        switch(need_to) {
        case NEED_TO_LOSE:
            score += (player1+2) % 3 + 1;
            break;
        case NEED_TO_DRAW:
            score += player1 + 1;
            break;
        case NEED_TO_WIN:
            score += (player1+1) % 3 + 1;
            break;
        }
    }

    printf("%d\n", score);
}

int main(int argc, char *argv[]) {
    if (argc == 2 && argv[1][0] == '1') {
        run1();
    } else if (argc == 2 && argv[1][0] == '2') {
        run2();
    }
}
