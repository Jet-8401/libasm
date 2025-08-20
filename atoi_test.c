#include "libasm_bonus.h"
#include <stdio.h>
#include <stdlib.h>

int main() {
    const char *prompt = "-1";

    {
        int result = atoi(prompt);
        printf("%d\n", result);
    }

    {
        int result = ft_atoi_base(prompt, "0123456789");

        printf("%d\n", result);
    }

}
