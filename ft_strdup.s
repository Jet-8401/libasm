section .text
    global ft_strdup
    extern ft_strcpy
    extern ft_strlen
    extern malloc

ft_strdup:
    push rdi        ; Save parameter address
    call ft_strlen

    mov rdi, rax    ; Put the lenth of the string as first param
    add rdi, 1
    call malloc wrt ..plt

    test rax, rax      ; Check for erros
    jl .error

    mov rdi, rax    ; Move the allocated value as dst
    pop rsi         ; Move the original string as src
    call ft_strcpy
    ret

.error:
    xor rax, rax
    ret

section .note.GNU-stack noexec
