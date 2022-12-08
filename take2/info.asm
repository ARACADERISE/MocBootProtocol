use16
org 0x9200

moca_file_system:
    ; First 512 bytes of MFS is for the bootloader
    boot:               incbin "boot.bin"
    ; Address of second stage bootloader(if there is one)
    second_stage_addr:  dw 0x0
    revision:           dw 0x0
    kernel_addr:        dw 0x0


times 1024 - ($ - $$) db 0x0