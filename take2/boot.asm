use16
org 0x7C00

    xor     ax, ax
    mov     ds, ax
    mov     es, ax

    ; Setup stack address

    cli                         ; don't want interrupts
    mov     ss, ax
    mov     bp, 0x7c00
    mov     sp, bp
    sti

    ; Read in sectors for second stage where everything happens
    mov ax, 0x07E0
    mov es, ax
    xor bx, bx

    mov ah, 0x02
    mov al, 0x0A
    mov ch, 0x00
    mov cl, 0x02
    mov dh, 0x00
    mov dl, 0x80
    int 0x13
    jc failed

    mov ax, 0x0920
    mov es, ax
    xor bx, bx

    mov ah, 0x02
    mov al, 0x02
    mov ch, 0x00
    mov cl, 0x02
    mov dh, 0x00
    mov dl, 0x80
    int 0x13
    jc failed

    ; If it doesn't fail, jump to second stage
    jmp 0x0:0x7E00

jmp $

failed:
    mov ah, 0x0e
    mov al, 'E'
    int 0x10

    ; Halt the system
    cli
    hlt

times 510 - ($ - $$) db 0x0
dw 0xAA55