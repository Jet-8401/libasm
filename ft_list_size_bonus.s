section .text
    global ft_list_size

ft_list_size:
    ; rdi = pointer of list
    xor rax, rax

.loop:
    cmp rdi, 0
    je .done

    inc rax
    mov rdi, [rdi + 8]
    jmp .loop

.done:
    ret

section .note.GNU-stack noexec
