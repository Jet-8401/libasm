section .text
    global ft_atoi_base

; int ft_atoi_base(char *str, char *base);
; Except for the base rule, the function should behave exactly like ft_atoi.
; If an invalid argument is provided, the function should return 0.
; Examples of invalid arguments:
; ◦ The base is empty or has only one character.
; ◦ The base contains duplicate characters.
; ◦ The base contains ‘+’, ‘-’, or whitespace characters.
ft_atoi_base:
    push r12        ; Save r12
    push rdi        ; Save *str

    xor r12, r12    ; result of atoi
    mov rax, rsi    ; iterator for *base

; check every chars
.check_base_str:
    test rdi, rdi
    jz .check_base

    mov dl, byte [rdi]

    cmp dl, 43    ; '+'
    je .done

    cmp dl, 45    ; '-'
    je .done

    cmp dl, 32
    je .done

    ; if dl is is in range 0x09-0x0D (tab, LF, VT, FF, CR)
    ; the result inside dl would be below or equal to 4
    sub dl, 0x09
    cmp dl, 0x04
    jbe .done

    ; check duplicates

; global check
.check_base:
    pop rdi         ; Restore *str

    sub rdi, rax    ; get the size of str inside rdi
    cmp rdi, 2

    mov r12, 1

    jl .done

.done:
    mov rax, r12
    pop r12         ; Restore r12
    ret

section .note.GNU-stack noexec
