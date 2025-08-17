section .text
    global ft_strlen

ft_strlen:
    ; Input: rdi = pointer to string
    ; Output: rax = length of string

    xor rax, rax        ; Initialize counter to 0

.loop:
    cmp byte [rdi + rax], 0    ; Compare current byte with null terminator
    je .done                   ; If null terminator found, jump to done
    inc rax                    ; Increment counter
    jmp .loop                  ; Continue loop

.done:
    ret                        ; Return length in rax

section .note.GNU-stack noexec
