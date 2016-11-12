.set MAGIC, 	0x1BADB002
.set FLAGS, 	0 | 1
.set CHECKSUM, 	-(MAGIC + FLAGS)

.section .multiboot
multiboot_header:
	.align 4
	.long MAGIC
	.long FLAGS
	.long CHECKSUM

.section .bss
.align 16
stack_bottom:
.skip 16384
stack_top:

.section 	.text
.global 	start, _start

start:
_start:
	cli
	mov $stack_top, %esp
	call main

loop:	
	jmp loop

.size _start, . - _start
