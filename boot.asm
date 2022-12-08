BITS 16
ORG 0x7C00

jmp 0x0:EntryPoint

EntryPoint:

    xor     ax, ax
    mov     ds, ax
    mov     es, ax

    ; Setup stack address

    cli                         ; don't want interrupts
    mov     ss, ax
    mov     bp, 0x7c00
    mov     sp, bp
    sti

    call LoadStage2

    ; Setup X86

    ; A20 Line Fast
    in al, 0x92
    or al, 2
    out 0x92, al

    ; Video Mode
    mov     ah, 0               ; Function code
    mov     al, 0x03            ; Video mode
    int     0x10                ; Video interrupt service

    ; GDT
    cli                         ; disable interrupts
    lgdt    [GlobalDescriptorTable.Descriptor]

    ; Protection Mode
    mov     eax, cr0 
    or      al, 0x1             ; Set the protection bit in cr0 register
    mov     cr0, eax

    ; Setup Segments
    mov ax, 0x10
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    jmp 0x8:0x7e00             ; Far Jump to C Code

; Read stage 2
LoadStage2:
	mov     si, DAPACK
	mov     ah, 0x42
	int     0x13
	jc      short .error
	
	ret		                    ; Return if everything is ok

    .error:
        mov     si, failure
        call    print16

    .hlt:
        hlt
        jmp     .hlt


DAPACK:
	db 0x16 								    ; DAP Lenght
	db 0									    ; Reserved
	dw (EndOfStage2 - StartOfStage2) / 1024 + 2  ; Sectors to read
    dw 0x0000, 0x7e00 >> 4  				    ; Buffer
	dq 1 									    ; Second sector

GlobalDescriptorTable:
    dq 0x00                     ; Null segment
.BootloaderCodeSeg:
    dq 0x00CF9A000000FFFF       ; Kernel code segment
.BootloaderDataSeg:
    dq 0x00CF92000000FFFF       ; Kernel data segment
.End:

.Descriptor:
    dw .End - GlobalDescriptorTable - 1
    dd GlobalDescriptorTable

%include "print.asm"
failure: db "Disk Error", 0

times 510 - ($-$$) db 0
dw 0xAA55

StartOfStage2: incbin "Alba.sys"
EndOfStage2: times 512 - ($-$$) % 512 db 0