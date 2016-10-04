.section    .text
.globl      _start
.code16

_start:

    movb    $0x00, %ah
    int     $0x16           

    movb    $0x0E, %ah 
    int     $0x10
    
    nop

loop:   
    jmp     _start 

. = _start + 510 
.byte   0x55, 0xAA
