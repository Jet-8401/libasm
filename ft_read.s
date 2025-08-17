section .text
    global ft_read
    extern ft_set_errno

ft_read:
    mov rax, 0
    syscall

    cmp rax, 0
    jl .error
    ret

.error:
    mov rdi, rax
    call ft_set_errno
    ret

section .note.GNU-stack noexec
