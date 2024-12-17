section .data
    prompt db "Enter your password: ", 0
    too_short db "Password is TOO SHORT!", 0xA, 0
    too_weak db "Password is TOO WEAK!", 0xA, 0
    weak db "Password is WEAK!", 0xA, 0
    medium db "Password is MEDIUM!", 0xA, 0
    strong db "Password is STRONG!", 0xA, 0
    too_strong db "Password is TOO STRONG!", 0xA, 0
    too_repetitive db "Password has too much repetition!", 0xA, 0
    specials db "!@#$%^&*()-_+=[]{}|;:'<>,.?/", 0

section .bss
    password resb 64

section .text
    global _start

_start:
    ; Print prompt
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt
    mov rdx, 21
    syscall

    ; Read input
    mov rax, 0
    mov rdi, 0
    mov rsi, password
    mov rdx, 64
    syscall

    ; Replace newline with null terminator
    mov rcx, 0
replace_newline:
    cmp byte [rsi + rcx], 0xA
    je set_null
    cmp byte [rsi + rcx], 0
    je length_checked
    inc rcx
    jmp replace_newline

set_null:
    mov byte [rsi + rcx], 0

length_checked:
    cmp rcx, 8
    jl too_short_msg

    ; Initialize counters
    mov r8b, 0   ; Uppercase count
    mov r9b, 0   ; Lowercase count
    mov r10b, 0  ; Digit count
    mov r11b, 0  ; Special count
    mov r12b, 0  ; Repetition count
    mov r13b, 0  ; Previous character
    mov rcx, 0   ; Index

validate_password:
    mov al, [rsi + rcx]
    cmp al, 0
    je evaluate_strength

    ; Check for repetition
    cmp al, r13b
    jne reset_repetition
    inc r12b
    cmp r12b, 3
    jg repetitive_msg
    jmp next_char

reset_repetition:
    mov r12b, 0
    mov r13b, al

    ; Check uppercase
    cmp al, 'A'
    jl check_lower
    cmp al, 'Z'
    jg check_lower
    inc r8b
    jmp next_char

check_lower:
    cmp al, 'a'
    jl check_digit
    cmp al, 'z'
    jg check_digit
    inc r9b
    jmp next_char

check_digit:
    cmp al, '0'
    jl check_special
    cmp al, '9'
    jg check_special
    inc r10b
    jmp next_char

check_special:
    mov rbx, specials
    mov rdx, 0
check_each_special:
    cmp byte [rbx + rdx], 0
    je next_char
    cmp al, byte [rbx + rdx]
    je set_special
    inc rdx
    jmp check_each_special

set_special:
    inc r11b

next_char:
    inc rcx
    jmp validate_password

evaluate_strength:
    ; Check if password uses only one type (Too Weak)
    mov r14b, 0
    cmp r8b, 0
    jne count_types
    cmp r9b, 0
    jne count_types
    cmp r10b, 0
    jne count_types
    cmp r11b, 0
    jne count_types
    jmp too_weak_msg

count_types:
    mov r14b, 0
    cmp r8b, 0
    jz count_lower
    inc r14b
count_lower:
    cmp r9b, 0
    jz count_digit
    inc r14b
count_digit:
    cmp r10b, 0
    jz count_special
    inc r14b
count_special:
    cmp r11b, 0
    jz check_final
    inc r14b

check_final:
    cmp r14b, 1
    je too_weak_msg   ; Only one type

    cmp r14b, 2
    je check_medium   ; Two types -> Medium

    ; Too Strong: Length >= 10, 4 types, 2 of each
    cmp rcx, 10
    jl strong_msg
    cmp r8b, 2
    jl strong_msg
    cmp r9b, 2
    jl strong_msg
    cmp r10b, 2
    jl strong_msg
    cmp r11b, 2
    jl strong_msg
    jmp too_strong_msg

check_medium:
    cmp rcx, 8
    jge medium_msg
    jmp weak_msg

too_short_msg:
    mov rsi, too_short
    mov rdx, 23
    jmp print_msg

too_weak_msg:
    mov rsi, too_weak
    mov rdx, 23
    jmp print_msg

weak_msg:
    mov rsi, weak
    mov rdx, 17
    jmp print_msg

medium_msg:
    mov rsi, medium
    mov rdx, 21
    jmp print_msg

strong_msg:
    mov rsi, strong
    mov rdx, 21
    jmp print_msg

too_strong_msg:
    mov rsi, too_strong
    mov rdx, 24
    jmp print_msg

repetitive_msg:
    mov rsi, too_repetitive
    mov rdx, 35
    jmp print_msg

print_msg:
    mov rax, 1
    mov rdi, 1
    syscall

    ; Exit
    mov rax, 60
    xor rdi, rdi
    syscall
