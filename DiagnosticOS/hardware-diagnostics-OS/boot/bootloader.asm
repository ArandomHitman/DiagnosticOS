; bootloader.asm - A simple bootloader template

BITS 16
ORG 0x7C00

start:
    ; Set up the stack
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax 
    mov sp, 0x7C00

    ; Print a message
    mov si, msg
print_char:
    lodsb
    cmp al, 0
    je done
    mov ah, 0x0E
    int 0x10
    jmp print_char

done:
    ; Hang the system
    hlt
    jmp $

msg db 'Hello, World!', 0

times 510-($-$$) db 0
dw 0xAA55