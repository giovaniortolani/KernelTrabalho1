.section    .text
.globl      _start
.code16

_start:
    nop

loop:   
    jmp loop    

. = _start + 510 
.byte   0x55, 0xAA
