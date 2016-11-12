.set MAGIC, 	0x1BADB002
.set FLAGS, 	0 | 1
.set CHECKSUM, 	-(MAGIC + FLAGS)

multiboot_header:
	.align 4
	.long FLAGS
	.long MAGIC
	.long CHECKSUM

.section .bss
.align 16
stack_bottom:
.skip 16384 # 16 KiB
stack_top:

.section 	.text
.global 	start, _start

start:
_start:
	cli
	mov $stack_top, %esp	# Move stack pointer to top of stack
	call main

loop:	
	jmp loop

.size _start, . - _start
