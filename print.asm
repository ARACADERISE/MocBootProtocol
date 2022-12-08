BITS 16

; VOID print16(PCHAR si);
print16:
    lodsb               ; Load the address of index register (e/r)si in al

    cmp     al, 0       ; Check if bx contains the end of text
    je      .leave      ; If condition passed, leave the function

    mov     ah, 0x0E    ; Teletype output
    int     0x10        ; Video interrupt service

    inc     al          ; If condition didn't pass, increment the al register

    jmp     print16     ; Loop the operation till break.
         
.leave:
    ret                 ; Return