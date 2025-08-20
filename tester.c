#include "./libasm.h"
#include <strings.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int compare(void *data, void *data_ref) {
    return !( *((int*) data) < *((int*) data_ref));
}

int main() {
    printf("\n=== ft_write && ft_read && ft_strlen ===\n");
    fflush(stdout);

    const char *string = "Print maximum of 10 chars:\n";
    ft_write(1, string, ft_strlen(string));

    char result[11];
    bzero(&result, sizeof(result));
    ssize_t bytes = ft_read(0, result, sizeof(result) - 1);

    printf("You printed ('\\n' may be included): [%s]", result);
    printf("\nResult of the ft_write function: %ld\n", bytes);
    printf("ft_strlen of result: %ld\n", ft_strlen(result));

    printf("--- Tesing errno ---\n");
    fflush(stdout);

    if (ft_write(450, "Oui\n", 4) == -1) {
        perror("Error while writing");
    }

    if (ft_read(450, result, sizeof(0))) {
        perror("Error while reading");
    }

    printf("\n=== ft_strcpy ===\n");

    const char *string_to_copy = "Hello World !";
    const char copy[256];
    bzero((char*) &copy, sizeof(copy));

    printf("result of strcpy: [%s]\n", ft_strcpy((char*) copy, string_to_copy));
    printf("value inside copy: [%s]\n", copy);

    printf("\n=== ft_strcmp ===\n");

    const char *s1 = "a";
    const char *s2 = "b";

    printf("difference between [%s] and [%s] is %d\n", s1, s2, ft_strcmp(s1, s2));
    printf("--- original strcmp ---\n");
    printf("difference between [%s] and [%s] is %d\n", s1, s2, strcmp(s1, s2));

    printf("\n=== ft_strdup ===\n");

    char *origin = "This is the original string !";
    char *dup = ft_strdup(origin);

    printf("Orignal string: [%s](%p)\n", origin, (void*) &origin);
    printf("Duplicate string: [%s](%p)\n", dup, (void*) dup);
    for (int i = 0; i < ft_strlen(dup); i++) {
        dup[i]++;
    }
    printf("--- after incrementing every chars of dup... ---\n");
    printf("Orignal string: [%s]\n", origin);
    printf("Duplicate string: [%s]\n", dup);

    free(dup);
    dup = NULL;

    t_list *begin = NULL;
    int *a = malloc(sizeof(int));
    *a = 0;

    printf("\n=== ft_list_size && ft_list_push_front ===\n");

    printf("pushing one element inside begin...\n");
    ft_list_push_front(&begin, a);
    printf("begin size = %d\n", ft_list_size(begin));

    const int elements_to_push = 30;
    printf("pushing %d elements...\n", elements_to_push);
    for (int i = 0; i < elements_to_push; i++) {
        int *value = malloc(sizeof(int));
        *value = i;
        if (!value)
            break;
        ft_list_push_front(&begin, value);
    }

    int value = 10;
    ft_list_remove_if(&begin, &value, &compare, free);

    printf("list length is now %d\n", ft_list_size(begin));

    printf("freeing the list...\n");
    while (begin) {
        t_list *next = begin->next;
        free(begin->data);
        free(begin);
        begin = next;
    }

    printf("\n=== END OF TESTS ===\n");

    return 0;
}
