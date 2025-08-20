#!/bin/bash

clear
make re
make bonus
make clean

# Compile mandatory tests
clang mandatory_tests.c libasm.a -o test_mandatory -pie -g

# Compile bonus tests
clang bonus_tests.c libasm.a -o test_bonus -pie -g

# Run tests with valgrind
echo -e "\n\033[1;33m=== RUNNING MANDATORY TESTS ===\033[0m\n"
valgrind ./test_mandatory

echo -e "\n\033[1;33m=== RUNNING BONUS TESTS ===\033[0m\n"
valgrind ./test_bonus
