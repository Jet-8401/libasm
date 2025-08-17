section .text
    global ft_write
    extern ft_set_errno

ft_write:
    mov rax, 1
    syscall

    cmp rax, 0
    jl .error
    ret

.error:
    mov rdi, rax
    call ft_set_errno
    ret

section .note.GNU-stack noexec
