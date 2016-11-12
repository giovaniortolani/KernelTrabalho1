CFLGAS = -m32 -nostdlib -ffreestanding
ASSEMLY_FLAGS = --32

all:	boot.o video.o string.o stdlib.o register.o stdio.o kernel.o 
	ld -m elf_i386 -T setup.ld -o kernel *.o 
	rm -f *.o 

boot.o: bootloader.s
	as $(ASSEMLY_FLAGS) bootloader.s -o boot.o

video.o:   video.c
	gcc $(CFLGAS) -c $<

kernel.o:   kernel.c
	gcc $(CFLGAS) -I./libc -c $<

%.o:	libc/%.c	
	gcc $(CFLGAS) -I./libc -c $<

run:
	qemu-system-i386 -kernel kernel

clean:
	rm -f *.o
	rm kernel
