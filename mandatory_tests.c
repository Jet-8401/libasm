#include "libasm.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>

#define RESET   "\033[0m"
#define RED     "\033[31m"
#define GREEN   "\033[32m"
#define YELLOW  "\033[33m"

void test_ft_strlen(void)
{
    printf(YELLOW "\n=== Testing ft_strlen ===\n" RESET);

    const char *test_strings[] = {
        "",
        "Hello",
        "This is a test string",
        "1234567890",
        "String with\nnewline",
        "String with\0hidden null byte",
        NULL
    };

    for (int i = 0; test_strings[i] != NULL; i++) {
        size_t lib_result = strlen(test_strings[i]);
        size_t ft_result = ft_strlen(test_strings[i]);

        printf("Test %d: \"%s\"\n", i + 1, test_strings[i]);
        printf("  strlen: %zu\n", lib_result);
        printf("  ft_strlen: %zu\n", ft_result);

        if (lib_result == ft_result)
            printf(GREEN "  ✓ OK\n" RESET);
        else
            printf(RED "  ✗ KO\n" RESET);
    }
}

void test_ft_strcpy(void)
{
    printf(YELLOW "\n=== Testing ft_strcpy ===\n" RESET);

    const char *test_strings[] = {
        "",
        "Hello",
        "This is a test string",
        "String with\nnewline",
        NULL
    };

    for (int i = 0; test_strings[i] != NULL; i++) {
        char buffer1[100] = {0};
        char buffer2[100] = {0};

        char *lib_result = strcpy(buffer1, test_strings[i]);
        char *ft_result = ft_strcpy(buffer2, test_strings[i]);

        printf("Test %d: \"%s\"\n", i + 1, test_strings[i]);
        printf("  strcpy result: \"%s\"\n", buffer1);
        printf("  ft_strcpy result: \"%s\"\n", buffer2);

        if (strcmp(buffer1, buffer2) == 0 && lib_result == buffer1 && ft_result == buffer2)
            printf(GREEN "  ✓ OK\n" RESET);
        else
            printf(RED "  ✗ KO\n" RESET);
    }
}

void test_ft_strcmp(void)
{
    printf(YELLOW "\n=== Testing ft_strcmp ===\n" RESET);

    struct {
        const char *s1;
        const char *s2;
    } test_pairs[] = {
        {"", ""},
        {"Hello", "Hello"},
        {"Hello", "World"},
        {"aaa", "aab"},
        {"bbb", "aaa"},
        {"abc", "ab"},
        {"ab", "abc"},
        {NULL, NULL}
    };

    for (int i = 0; test_pairs[i].s1 != NULL; i++) {
        int lib_result = strcmp(test_pairs[i].s1, test_pairs[i].s2);
        int ft_result = ft_strcmp(test_pairs[i].s1, test_pairs[i].s2);

        printf("Test %d: \"%s\" vs \"%s\"\n", i + 1, test_pairs[i].s1, test_pairs[i].s2);
        printf("  strcmp: %d\n", lib_result);
        printf("  ft_strcmp: %d\n", ft_result);

        // We only care if they're both positive, negative, or zero
        if ((lib_result > 0 && ft_result > 0) ||
            (lib_result < 0 && ft_result < 0) ||
            (lib_result == 0 && ft_result == 0))
            printf(GREEN "  ✓ OK\n" RESET);
        else
            printf(RED "  ✗ KO\n" RESET);
    }
}

void test_ft_write(void)
{
    printf(YELLOW "\n=== Testing ft_write ===\n" RESET);

    const char *test = "Hello, this is a test string for ft_write\n";
    long lib_result, ft_result;

    printf("Writing to STDOUT:\n");
    printf("  Using write(): ");
    lib_result = write(STDOUT_FILENO, test, strlen(test));

    printf("  Using ft_write(): ");
    ft_result = ft_write(STDOUT_FILENO, test, strlen(test));

    printf("  write returned: %ld\n", lib_result);
    printf("  ft_write returned: %ld\n", ft_result);

    if (lib_result == ft_result)
        printf(GREEN "  ✓ OK\n" RESET);
    else
        printf(RED "  ✗ KO\n" RESET);

    // Test error case
    int invalid_fd = -1;
    errno = 0;
    lib_result = write(invalid_fd, test, strlen(test));
    int lib_errno = errno;

    errno = 0;
    ft_result = ft_write(invalid_fd, test, strlen(test));
    int ft_errno = errno;

    printf("Error handling (invalid fd):\n");
    printf("  write returned: %ld (errno: %d)\n", lib_result, lib_errno);
    printf("  ft_write returned: %ld (errno: %d)\n", ft_result, ft_errno);

    if (lib_result == ft_result && lib_errno == ft_errno)
        printf(GREEN "  ✓ OK\n" RESET);
    else
        printf(RED "  ✗ KO\n" RESET);
}

void test_ft_read(void)
{
    printf(YELLOW "\n=== Testing ft_read ===\n" RESET);

    // Create a test file
    const char *filename = "test_read.txt";
    const char *test_content = "This is a test content for ft_read function.";

    int fd = open(filename, O_WRONLY | O_CREAT | O_TRUNC, 0644);
    if (fd == -1) {
        perror("Failed to create test file");
        return;
    }

    write(fd, test_content, strlen(test_content));
    close(fd);

    // Test reading
    char buffer1[100] = {0};
    char buffer2[100] = {0};

    fd = open(filename, O_RDONLY);
    if (fd == -1) {
        perror("Failed to open test file");
        return;
    }

    long lib_result = read(fd, buffer1, sizeof(buffer1) - 1);
    close(fd);

    fd = open(filename, O_RDONLY);
    if (fd == -1) {
        perror("Failed to open test file");
        return;
    }

    long ft_result = ft_read(fd, buffer2, sizeof(buffer2) - 1);
    close(fd);

    printf("Reading from file:\n");
    printf("  read returned: %ld, content: \"%s\"\n", lib_result, buffer1);
    printf("  ft_read returned: %ld, content: \"%s\"\n", ft_result, buffer2);

    if (lib_result == ft_result && strcmp(buffer1, buffer2) == 0)
        printf(GREEN "  ✓ OK\n" RESET);
    else
        printf(RED "  ✗ KO\n" RESET);

    // Clean up
    unlink(filename);

    // Test error case
    int invalid_fd = -1;
    errno = 0;
    lib_result = read(invalid_fd, buffer1, sizeof(buffer1) - 1);
    int lib_errno = errno;

    errno = 0;
    ft_result = ft_read(invalid_fd, buffer2, sizeof(buffer2) - 1);
    int ft_errno = errno;

    printf("Error handling (invalid fd):\n");
    printf("  read returned: %ld (errno: %d)\n", lib_result, lib_errno);
    printf("  ft_read returned: %ld (errno: %d)\n", ft_result, ft_errno);

    if (lib_result == ft_result && lib_errno == ft_errno)
        printf(GREEN "  ✓ OK\n" RESET);
    else
        printf(RED "  ✗ KO\n" RESET);
}

void test_ft_strdup(void)
{
    printf(YELLOW "\n=== Testing ft_strdup ===\n" RESET);

    const char *test_strings[] = {
        "",
        "Hello",
        "This is a test string",
        "String with\nnewline",
        NULL
    };

    for (int i = 0; test_strings[i] != NULL; i++) {
        char *lib_result = strdup(test_strings[i]);
        char *ft_result = ft_strdup(test_strings[i]);

        printf("Test %d: \"%s\"\n", i + 1, test_strings[i]);
        printf("  strdup result: \"%s\"\n", lib_result);
        printf("  ft_strdup result: \"%s\"\n", ft_result);

        if (strcmp(lib_result, ft_result) == 0)
            printf(GREEN "  ✓ OK\n" RESET);
        else
            printf(RED "  ✗ KO\n" RESET);

        free(lib_result);
        free(ft_result);
    }
}

int main(void)
{
    printf(YELLOW "=== LIBASM BASIC TESTS ===\n" RESET);

    test_ft_strlen();
    test_ft_strcpy();
    test_ft_strcmp();
    test_ft_write();
    test_ft_read();
    test_ft_strdup();

    return 0;
}
