CC=gcc -m32 -Os
AS = nasm
LD=ld -m elf_i386
Flags=-w -fno-exceptions -fno-asynchronous-unwind-tables -fno-stack-protector -fno-pic -fpie -mno-80387 -mno-mmx -mno-3dnow
.PHONY: build
.PHONY: run
.PHONY: clean


build:
	${CC} ${Flags} -c init.c -o init.o
#${CC} ${Flags} -c phys.c -o phys.o
	${AS} entry.asm -f elf32 -o entry.o
	$(LD) -T link.ld init.o -o entry.o

	# Remove useless sections
	objcopy --remove-section .eh_frame init.o

	# Produce final Executable
	cat entry.o init.o > Alba.sys

	# Final build
	${AS} -f bin boot.asm -o boot.bin

run:
#C:/Program Files/qemu/qemu-system-i386.exe -accel whpx boot.bin
clean:
	rm -rf *.o
	rm -rf *.bin
	rm -rf *.sys