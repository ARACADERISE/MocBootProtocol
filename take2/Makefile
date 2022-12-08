.PHONY: build
.PHONY: run
.PHONY: clean

CC=gcc -m32 -Os -O1
AS=nasm
LD=ld -m elf_i386
FLAGS = -w -fno-exceptions -fno-asynchronous-unwind-tables -fno-stack-protector -fno-pic -fpie -mno-80387 -mno-mmx -mno-3dnow

build:
	${CC} ${FLAGS} -c main.c -o main.o
	${AS} boot2.asm -f elf32 -o entry.o
	$(LD) -T link.ld main.o -o image.sys
	${AS} boot.asm -f bin -o boot.bin

clean:
	rm -rf *.o
	rm -rf *.bin
	rm -rf *.sys