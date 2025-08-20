#include "libasm_bonus.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define RESET   "\033[0m"
#define RED     "\033[31m"
#define GREEN   "\033[32m"
#define YELLOW  "\033[33m"

void test_ft_atoi_base(void)
{
    printf(YELLOW "\n=== Testing ft_atoi_base ===\n" RESET);

    struct {
        const char *str;
        const char *base;
        int expected;
    } test_cases[] = {
        {"101", "01", 5},            // Binary
        {"1010", "01", 10},          // Binary
        {"12", "0123456789", 12},    // Decimal
        {"FF", "0123456789ABCDEF", 255}, // Hex
        {"377", "01234567", 255},    // Octal
        {"  +101", "01", 5},         // With spaces and +
        {"  -101", "01", -5},        // With spaces and -
        {"Z", "Z", 0},               // Invalid base (single character)
        {"101", "", 0},              // Invalid base (empty)
        {"101", "011", 0},           // Invalid base (duplicate)
        {"101", "0+", 0},            // Invalid base (with +)
        {"101", "0-", 0},            // Invalid base (with -)
        {"101", "0 1", 0},           // Invalid base (with space)
        {"10a1", "01", 2},           // Invalid char in str
        {NULL, NULL, 0}
    };

    for (int i = 0; test_cases[i].str != NULL; i++) {
        int result = ft_atoi_base(test_cases[i].str, test_cases[i].base);

        printf("Test %d: ft_atoi_base(\"%s\", \"%s\")\n", i + 1,
               test_cases[i].str, test_cases[i].base);
        printf("  Expected: %d\n", test_cases[i].expected);
        printf("  Result: %d\n", result);

        if (result == test_cases[i].expected)
            printf(GREEN "  ✓ OK\n" RESET);
        else
            printf(RED "  ✗ KO\n" RESET);
    }
}

// Utility functions for list tests
void print_list(t_list *lst, const char *prefix)
{
    printf("%s", prefix);
    while (lst) {
        printf("%s -> ", (char *)lst->data);
        lst = lst->next;
    }
    printf("NULL\n");
}

void free_list(t_list *lst)
{
    t_list *tmp;

    while (lst) {
        tmp = lst->next;
        free(lst);
        lst = tmp;
    }
}

t_list *create_node(void *data)
{
    t_list *node = (t_list *)malloc(sizeof(t_list));
    if (!node)
        return NULL;

    node->data = data;
    node->next = NULL;
    return node;
}

void test_ft_list_size(void)
{
    printf(YELLOW "\n=== Testing ft_list_size ===\n" RESET);

    t_list *list = NULL;

    printf("Test 1: Empty list\n");
    int size = ft_list_size(list);
    printf("  ft_list_size result: %d\n", size);
    if (size == 0)
        printf(GREEN "  ✓ OK\n" RESET);
    else
        printf(RED "  ✗ KO\n" RESET);

    list = create_node("First");
    printf("Test 2: List with 1 element\n");
    print_list(list, "  List: ");
    size = ft_list_size(list);
    printf("  ft_list_size result: %d\n", size);
    if (size == 1)
        printf(GREEN "  ✓ OK\n" RESET);
    else
        printf(RED "  ✗ KO\n" RESET);

    list->next = create_node("Second");
    list->next->next = create_node("Third");
    printf("Test 3: List with 3 elements\n");
    print_list(list, "  List: ");
    size = ft_list_size(list);
    printf("  ft_list_size result: %d\n", size);
    if (size == 3)
        printf(GREEN "  ✓ OK\n" RESET);
    else
        printf(RED "  ✗ KO\n" RESET);

    free_list(list);
}

void test_ft_list_push_front(void)
{
    printf(YELLOW "\n=== Testing ft_list_push_front ===\n" RESET);

    t_list *list = NULL;

    printf("Test 1: Push to empty list\n");
    ft_list_push_front(&list, "First");
    print_list(list, "  List after push: ");
    int size = ft_list_size(list);
    if (size == 1 && list && strcmp((char *)list->data, "First") == 0)
        printf(GREEN "  ✓ OK\n" RESET);
    else
        printf(RED "  ✗ KO\n" RESET);

    printf("Test 2: Push to non-empty list\n");
    ft_list_push_front(&list, "New First");
    print_list(list, "  List after push: ");
    size = ft_list_size(list);
    if (size == 2 && list && strcmp((char *)list->data, "New First") == 0)
        printf(GREEN "  ✓ OK\n" RESET);
    else
        printf(RED "  ✗ KO\n" RESET);

    free_list(list);
}

int cmp_func(void *data, void *ref)
{
    return strcmp((char *)data, (char *)ref);
}

void free_fct(void *data)
{
    // In this test we're using string literals, so no need to free data
    (void)data;
}

void test_ft_list_remove_if(void)
{
    printf(YELLOW "\n=== Testing ft_list_remove_if ===\n" RESET);

    t_list *list = NULL;

    printf("Test 1: Remove from empty list\n");
    ft_list_remove_if(&list, "Any", cmp_func, free_fct);
    if (list == NULL)
        printf(GREEN "  ✓ OK\n" RESET);
    else
        printf(RED "  ✗ KO\n" RESET);

    ft_list_push_front(&list, "Third");
    ft_list_push_front(&list, "Second");
    ft_list_push_front(&list, "First");
    ft_list_push_front(&list, "Second");
    ft_list_push_front(&list, "Fourth");

    printf("Test 2: Remove element 'Second'\n");
    print_list(list, "  List before: ");
    ft_list_remove_if(&list, "Second", cmp_func, free_fct);
    print_list(list, "  List after: ");

    int found_second = 0;
    t_list *current = list;
    while (current) {
        if (strcmp((char *)current->data, "Second") == 0)
            found_second = 1;
        current = current->next;
    }

    if (!found_second)
        printf(GREEN "  ✓ OK\n" RESET);
    else
        printf(RED "  ✗ KO\n" RESET);

    free_list(list);
}

int main(void)
{
    printf(YELLOW "=== LIBASM BONUS TESTS ===\n" RESET);

    test_ft_atoi_base();
    test_ft_list_size();
    test_ft_list_push_front();
    test_ft_list_remove_if();

    return 0;
}
