
bits 16
section .entry

extern __bss_start
extern __end
extern _init

extern BldrInitBoot

global entry

entry:
    ; clear bss (uninitialized data)
    mov edi, __bss_start
    mov ecx, __end
    sub ecx, edi
    mov al, 0
    cld
    rep stosb

    jmp BldrInitBoot