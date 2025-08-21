section .bss
    ; lookup table for 256 ASCII characters
    ; each character have its value setup by its position inside
    ; the base string, else the default value if `UNSET_VALUE`
    table resb 256

UNSET_VALUE equ 255

section .text
    global ft_atoi_base

; check if reg dl is a space character
; return 1 or 0 inside rax
check_white_space:
    cmp dl, 32
    je .is_white_space

    ; if dl is is in range 9-13 (tab, LF, VT, FF, CR)
    ; the result inside dl would be below or equal to 4
    mov al, dl
    sub al, 9
    cmp al, 5
    jb .is_white_space
    xor rax, rax
    ret

.is_white_space:
    mov rax, 1
    ret

; int ft_atoi_base(char *str, char *base);
; Except for the base rule, the function should behave exactly like ft_atoi.
; If an invalid argument is provided, the function should return 0.
; Examples of invalid arguments:
; ◦ The base is empty or has only one character.
; ◦ The base contains duplicate characters.
; ◦ The base contains ‘+’, ‘-’, or whitespace characters.
ft_atoi_base:
    push r12
    push r13
    push r14
    push r15

    push qword 0     ; push boolean in stack for negation

    xor r12, r12    ; result of atoi
    mov r13, rsi    ; save *base pointer
    mov r14, rdi    ; save *str pointer

    test rsi, rsi
    jz .done

    ; reset the entire look-up table
    lea r11, [rel table]
    mov rcx, 256
.clear_table:
    mov byte [r11 + rcx - 1], UNSET_VALUE
    loop .clear_table

; check every chars
.check_base_char:
    mov dl, byte [rsi]
    test dl, dl
    jz .check_base

    cmp dl, 43    ; '+'
    je .done

    cmp dl, 45    ; '-'
    je .done

    call check_white_space
    test rax, rax
    jnz .done

    ; check duplicates
    ; r11 should already be setup to table address
    ; lea r11, [rel table]   ; load table address
    movzx rax, dl               ; zero-extend dl to rax (character as index)
    lea r8, [r11 + rax]
    cmp byte [r8], UNSET_VALUE  ; check if character already seen
    jne .done                   ; if not zero, it's a duplicate
    mov rdx, rsi
    sub rdx, r13
    mov byte [r8], dl           ; mark character as seen and set its value to its index

    ; move to next char
    inc rsi
    jmp .check_base_char

; global check
.check_base:
    sub rsi, r13    ; get size of orignal base inside rsi
    cmp rsi, 2
    jl .done

; iterate through *str
; skip whitespace characters at the begining
; check the sign
; then convert value
; stop at the first value not found inside the base
.convert:
    xor r12, r12    ; restore register
    mov r15, rsi    ; store size of base inside r15

.skip_whitespaces:
    mov dl, byte [r14]
    call check_white_space
    test rax, rax
    jz .check_sign
    inc r14
    jmp .skip_whitespaces

.check_sign:
    cmp byte [r14], 45  ; '-' char
    jne .check_plus
    mov qword [rsp], 1   ; set negation flag
    inc r14
    jmp .convert_loop

.check_plus:
    cmp byte [r14], 43  ; '+' char
    jne .convert_loop
    inc r14             ; skip '+' sign

.convert_loop:
    mov dl, byte [r14]
    ; check null byte
    test dl, dl
    jz .done

    ; search the value of the char inside the base from its index
    movzx rax, dl
    movzx rdi, byte [r11 + rax]     ; value of char
    cmp rdi, UNSET_VALUE            ; if char has no value
    je .done

    imul r12, r15   ; multiply the result by base length
    add r12, rdi    ; add the value

    inc r14
    jmp .convert_loop

.done:
    mov rax, r12
    ; check for negation
    neg r12
    pop rdx              ; boolean for negation
    test rdx, rdx
    cmovnz rax, r12

    pop r15
    pop r14
    pop r13
    pop r12
    ret

section .note.GNU-stack noexec
