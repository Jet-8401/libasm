section .text
    global ft_list_push_front
    extern malloc

ft_list_push_front:
    ; rdi = t_list **begin_list
    ; rsi = void *data

    push rdi
    push rsi

    ; Allocate memory for the new node.
    mov rdi, 16
    call malloc wrt ..plt

    pop rsi
    pop rdi

    test rax, rax               ; Check malloc error
    jz .error

    mov [rax], rsi              ; Set the data property of the new node
    mov rcx, [rdi]              ; Dereference list head
    mov [rax + 8], rcx          ; Put the last head inside the new node->next

    mov [rdi], rax              ; Update the head of the list to point to the new node.
    ret

.error:
    ret

section .note.GNU-stack noexec
