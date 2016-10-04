.section    .text
.globl      _start
.code16

_start:

    movb    $0x00, %ah
    int     $0x16          

    movb    $0x0E, %ah 
    int     $0x10

    cmp     $'1', %al
    je      clear 

loop:   
    jmp     _start 

clear:
    movb    $0x00, %ah
    movb    $0x02, %al
    int     $0x10
    jmp     _start

. = _start + 510 
.byte   0x55, 0xAA
