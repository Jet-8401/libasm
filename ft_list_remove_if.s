section .text
    global ft_list_remove_if
    extern free

; void ft_list_remove_if(
;     t_list **begin_list,
;     void *data_ref,
;     int (*cmp)(void *data, void *data_ref),
;     void (*free_fct)(void *)
; );

ft_list_remove_if:
    push r12
    push r13
    push r14
    push r15

    mov r12, rdi    ; **begin_list (pointer to pointer to current node)
    mov r13, rsi    ; data_ref
    mov r14, rdx    ; cmp function
    mov r15, rcx    ; free_fct

.loop:
    mov rsi, [r12]  ; current node
    test rsi, rsi
    jz .done        ; if null, we're done

    ; Call comparison function
    ; push r12        ; save r12
    push rsi        ; save current node

    mov rdi, [rsi]  ; node->data (first argument)
    mov rsi, r13    ; data_ref (second argument)
    call r14        ; call cmp function

    pop rsi         ; restore current node
    ; pop r12         ; restore r12

    ; Check if we should delete this node (cmp returned 0)
    test rax, rax
    jz .delete_node

    ; No match, move to next node
    lea r12, [rsi + 8]  ; r12 = &(current->next)
    jmp .loop

.delete_node:
    ; Save the node to delete
    push rsi

    ; Update the pointer to skip this node
    mov rdi, [rsi + 8]  ; next node
    mov [r12], rdi      ; *current_ptr = current->next

    ; Free the data if free_fct is not NULL
    test r15, r15
    jz .skip_data_free

    push r12
    mov rdi, [rsi]      ; node->data
    call r15            ; free_fct(node->data)

    pop r12

.skip_data_free:
    ; Free the node itself
    pop rdi             ; node to delete
    call free wrt ..plt

    ; Continue with the same position (don't advance r12)
    jmp .loop

.done:
    pop r15
    pop r14
    pop r13
    pop r12
    ret

section .note.GNU-stack noexec
