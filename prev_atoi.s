section .text
    global ft_atoi_base
    extern ft_strlen
    extern strchr

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
    jnl .convert

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

    ; Search the index of character inside the base

    push rdi
    push rax
    push rsi

    mov rdx, rdi            ; Save str inside rdx
    mov rdi, rsi            ; Move base inside first param
    movzx rsi, byte [rdx]   ; Set the second param as the char
    call strchr
    test rax, rax
    jz .done                ; Done if char is not find inside base
    ; rax is now the address of the char found

    pop rsi                 ; Restore the address of base inside rsi
    mov rdi, rsi
    sub rax, rdi            ; rdi now store the value to add
    mov rdi, rax

    pop rax                 ; Restore the old value of rax before adding it

    add rax, rdi            ; result += index_of_char

    pop rdi                 ; Restore the value of the string before incrementing it
    inc rdi

    cmp byte [rdi], 0
    jne .loop

.done:
    pop r12     ; Restore r12
    ret

section .note.GNU-stack noexec

; AI solution
; section .text
;     global ft_atoi_base
;     extern ft_strlen
;     extern strchr

; ft_atoi_base:
;     ; rdi = char *str
;     ; rsi = char *base

;     ; Save registers we'll need
;     push r12
;     push r13
;     push r14
;     push r15

;     ; Save original string pointer
;     mov r15, rdi

; .check_base:
;     ; Check base length
;     mov r14, rsi            ; Save base pointer
;     mov rdi, rsi            ; Put base in rdi for ft_strlen
;     call ft_strlen
;     cmp rax, 2              ; Check if length >= 2
;     jl .error
;     mov r12, rax            ; Store base length in r12

;     ; Check for invalid characters ('+', '-', whitespace)
;     mov rdi, r14            ; Restore base pointer
;     mov r13, 0              ; Initialize counter
; .check_invalid_chars:
;     cmp byte [rdi + r13], 0
;     je .check_duplicates

;     ; Check if current char is '+' or '-'
;     cmp byte [rdi + r13], '+'
;     je .error
;     cmp byte [rdi + r13], '-'
;     je .error

;     ; Check for whitespace (simplified check for space only)
;     cmp byte [rdi + r13], ' '
;     je .error

;     inc r13
;     jmp .check_invalid_chars

; .check_duplicates:
;     ; Check for duplicate characters in the base
;     mov r13, 0              ; Initialize outer loop counter
; .outer_loop:
;     cmp r13, r12
;     jge .start_conversion

;     movzx rcx, byte [r14 + r13]  ; Get current character

;     mov rdx, r13
;     inc rdx                 ; Start inner loop at outer+1
; .inner_loop:
;     cmp rdx, r12
;     jge .outer_loop_next

;     cmp cl, byte [r14 + rdx]
;     je .error                ; Duplicate found

;     inc rdx
;     jmp .inner_loop

; .outer_loop_next:
;     inc r13
;     jmp .outer_loop

; .start_conversion:
;     ; Restore original string pointer
;     mov rdi, r15

;     ; Skip whitespaces
;     .skip_spaces:
;         cmp byte [rdi], ' '
;         jne .check_sign
;         inc rdi
;         jmp .skip_spaces

;     ; Handle sign
; .check_sign:
;     mov r13, 1              ; Initialize sign (1 = positive)

;     cmp byte [rdi], '+'
;     je .skip_sign

;     cmp byte [rdi], '-'
;     jne .convert
;     mov r13, -1             ; Set sign to negative

; .skip_sign:
;     inc rdi                 ; Skip the sign

; .convert:
;     xor rax, rax            ; Initialize result to 0

; .loop:
;     cmp byte [rdi], 0       ; Check if end of string
;     je .apply_sign

;     ; Multiply result by base length
;     imul rax, r12

;     ; Find current character in base
;     push rdi
;     push rsi

;     mov rdx, rdi            ; Save current position in string
;     mov rdi, r14            ; First param = base
;     movzx rsi, byte [rdx]   ; Second param = current char
;     call strchr

;     ; Check if character was found
;     test rax, rax
;     jz .end_loop            ; If not in base, end conversion

;     ; Calculate index
;     sub rax, r14            ; rax = index of char in base

;     pop rsi
;     pop rdi

;     ; Add index to result
;     add rax, rax            ; result += index

;     inc rdi                 ; Move to next character
;     jmp .loop               ; Continue loop

; .end_loop:
;     ; Clean up if char not found
;     pop rsi
;     pop rdi

; .apply_sign:
;     ; Apply sign to result
;     imul rax, r13

;     ; Restore saved registers
;     pop r15
;     pop r14
;     pop r13
;     pop r12
;     ret

; .error:
;     ; Return 0 for any error
;     xor rax, rax

;     ; Restore saved registers
;     pop r15
;     pop r14
;     pop r13
;     pop r12
;     ret
