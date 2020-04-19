#include <cstdio>

int main()
{
    int a, b;
    scanf("%d %d", &a, &b);

    if ((a < b) && ((b ^ a) == 0x3) && ((a | b) >= 3)) {
        return 1;
    }
    else {
        return 0;
    }

    if (true) {
    }
}
