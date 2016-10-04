.section    .text
.globl      _start
.code16

_start:

    cli     # desabilita interrupcoes
    # limpa os registradores (faz um XOR com ele proprio)
    xorw    %ax, %ax    
    movw    %ax, %ds
    movw    %ax, %ss
    movw    %ax, %es
    movw    %ax, %fs
    sti     # habilita interrupcoes

    jmp     main

readChar:

    movb    $0x00, %ah
    int     $0x16    

    ret

printChar:

    movb    $0x0E, %ah 
    int     $0x10

    cmp     $'\n', %al
    jne     not_nl
    mov     $'\r', %al
    int     $0x10   
    jmp     not_cr

    not_nl: 
        cmp     $'\r', %al
        jne     not_cr
        mov     $'\n', %al
        int     $0x10
    
    not_cr:
        ret

clearScreen:

    movb    $0x00, %ah
    movb    $0x02, %al
    int     $0x10
    
    ret

printBootVer:

    movw    $str0, %si
    printBootVerStart:
        lodsb
        orb     %al, %al
        jz      printBootVerEnd
        movb    $0x0E, %ah
        int     $0x10
        jmp     printBootVerStart
    
    printBootVerEnd:
        ret

connectedDevices:

availableRAM:


main:

    call    readChar

    cmp     $'1', %al
    je      clearScreenMain

    cmp     $'2', %al
    je      printBootVerMain    

    cmp     $'3', %al
    je      connectedDevicesMain

    cmp     $'4', %al
    je      rebootMain

    cmp     $'5', %al
    je      availableRAMMain

    call    printChar
    jmp     main

    clearScreenMain:
        call    clearScreen
        jmp     main
    printBootVerMain:
        call    printBootVer
        jmp     main
    connectedDevicesMain:
        jmp     main
    rebootMain:
    
    availableRAMMain:
        jmp     main

str0:    .asciz  "Bootloader v0.4\n\r"

. = _start + 510 
.byte   0x55, 0xAA



