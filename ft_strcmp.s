section .text
    global ft_strcmp

ft_strcmp:
.loop:
    mov al, byte [rdi]
    mov dl, byte [rsi]

    test al, al     ; Check if first string ended (al == 0)
    jz .done        ; If al is 0, jump to done

    ; No need to check second string for null separately because if
    ; the first string ends (al = 0) but second doesn't (dl ≠ 0)
    ; the `cmp al, dl` will catch the difference.

    cmp al, dl      ; Check if characters are different
    jne .done       ; If different, jump to done

    inc rdi
    inc rsi
    jmp .loop

.done:
    movzx rax, al   ; Zero-extend al to rax
    movzx rdx, dl   ; Zero-extend dl to rdx
    sub rax, rdx
    ret

section .note.GNU-stack noexec
