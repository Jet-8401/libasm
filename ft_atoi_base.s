section .text
    global ft_atoi_base
    extern ft_strlen

; If an invalid argument is provided, the function should return 0.
; Examples of invalid arguments:
; ◦ The base is empty or has only one character.
; ◦ The base contains duplicate characters.
; ◦ The base contains ‘+’, ‘-’, or whitespace characters.
ft_atoi_base:
    ; rdi = char *str
    ; rsi = char *base

.check_base:
    push rdi
    push rsi
    mov rdi, rsi    ; Put base in rdi
    call ft_strlen

    pop rsi
    pop rdi

    cmp rax, 2      ; Check the length of base
    jl .error
    jmp .convert

.error:
    mov rax, 0
    ret

.convert:
    push r12        ; Save r12
    mov r12, rax    ; Length of base
    xor rax, rax    ; Store the result into rax

; loop through the str
.loop:
    imul rax, r12       ; result *= base_length
    ; instead of adding the ASCII value at %rdi make a function to search
    ; its position inside the base and add that position value
    add rax, [rdi]      ; result += value_of_current_char
    inc rdi
    cmp [rdi], 0
    je .done

.done:
    pop r12     ; Restore r12
    ret

; 345
; 300 /   3 * 100
; +40 / + 4 * 10
;  +5 / + 5

section .note.GNU-stack noexec
