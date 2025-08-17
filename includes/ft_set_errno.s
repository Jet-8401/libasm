section .text
    global ft_set_errno
    extern __errno_location

ft_set_errno:
    ; rdi as negative error code
    neg rdi
    ; wrt = with respect to
    ; plt = Procedure Linkage Table
    call __errno_location wrt ..plt
    mov [rax], rdi
    mov rax, -1
    ret

section .note.GNU-stack noexec
