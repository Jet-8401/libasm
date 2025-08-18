section .text
    ft_list_remove_if

; Notes:
; function = t_list **begin_list, void *data_ref, int (*cmp)(data, data_ref), void (*free_fct)(void *)
; calling convention = %rdi, %rsi, %rdx, %rcx, %r8, %r9, stack
ft_list_remove_if:
    ; rdi = source list
    ; rsi = data reference
    ; rdx = compare function
    ; rcx = free function

    push r12    ; iterator for list
    ; same order as (parameters + 1)
    push r13
    push r14
    push r15

    mov r12, [rdi]
    mov r13, rsi
    mov r14, rdx
    mov r13, rcx

.loop:
    ; call compare function
    mov rdi, [r12]
    mov rsi, r13
    call r14

    ; if function return 0 => delete node
    test rax, rax
    jnz .go_to_next

.delete_node:


.go_to_next:
    ; goes to next node
    mov r12, [r12 + 8]
    test r12, r12
    jnz .loop

.done:
    pop r15
    pop r14
    pop r13
    pop r12
    ret
