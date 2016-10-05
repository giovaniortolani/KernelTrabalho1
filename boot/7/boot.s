# Copyright © 2016 ­ Giovani Ortolani Barbosa (8936648), Bruno　Lanzoni Rossi　
# (4309596), Renan Rodrigues (9278132), Gustavo Henrique Oliveira Aguiar (8936912).
# This file is part of KernelTrabalho1.
#
# KernelTrabalho1 is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# KernelTrabalho1 is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with KernelTrabalho1.  If not, see <http://www.gnu.org/licenses/>.

.section    .text
.globl      _start
.code16

.type _start, @function
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

.type readChar, @function
readChar:

    movb    $0x00, %ah
    int     $0x16    

    ret

.type printChar, @function
printChar:

    movb    $0x0E, %ah 
    int     $0x10

    cmp     $'\n', %al
    jne     .notNL
    mov     $'\r', %al
    int     $0x10   
    jmp     .notCR

    .notNL: 
        cmp     $'\r', %al
        jne     .notCR
        mov     $'\n', %al
        int     $0x10
    
    .notCR:
        ret

.type clearScreen, @function
clearScreen:

    movb    $0x00, %ah
    movb    $0x02, %al
    int     $0x10
    
    ret

.type printString, @function
printString:
    lodsb
    orb     %al, %al
    jz      .printStringEnd
    movb    $0x0E, %ah
    int     $0x10
    jmp     printString

    .printStringEnd:
        ret

.type connectedDevices, @function
connectedDevices:
    
    int     $0x11
    movw    %ax, %bx
    
    movw    $connected, %si
    call    printString

    and     $0x0001, %ax
    cmp     $0, %ax
    je      .disketteNOTFound
    movw    $disketteF, %si
    call    printString
    jmp     .coprocessor

    .disketteNOTFound:
        movw    $disketteNF, %si
        call    printString

    .coprocessor:
        movw    %bx, %ax
        and     $0x0002, %ax
        cmp     $0, %ax
        je      .coprocessorNOTFound
        movw    $coprocessorF, %si
        call    printString
        jmp     .pointingdev

        .coprocessorNOTFound:
            movw    $coprocessorNF, %si
            call    printString

        .pointingdev:
            movw    %bx, %ax
            and     $0x0004, %ax
            cmp     $0, %ax
            je      .pointingdevNOTFound
            movw    $pointingdevF, %si
            call    printString
            jmp     .connectedDevicesEnd

            .pointingdevNOTFound:
                movw    $pointingdevNF, %si
                call    printString

    .connectedDevicesEnd:
        ret

.type availableRAM, @function
availableRAM:
    
    int     $0x12

    movw    %ax, %bx
    and     $0xF, %al
    xorw    %cx, %cx
    movw    $16, %cx

    .printHEX:
        sub     $4, %cx
        shr     %cl, %ax
        and     $0xF, %ax

        cmp     $10, %ax
        jl      .printHEXnumber

        # apos a mascara fica 00001111 (15 dec - 0F hex) - tab. ASCII
        # subtraimos 10 para ficar 00000101
        # 0100 0110 (F) = 00000101 (%ax) + 0100 0001 (A)
        sub     $10, %ax    
        add     $'A', %ax
        call    printChar
        jmp     .printHEXend

        .printHEXnumber:
            add     $'0', %ax
            call    printChar

        .printHEXend:
            movw    %bx, %ax
            cmp     $0, %cx
            jne     .printHEX

    ret

.type main, @function
main:
    
    call    readChar

    cmp     $'1', %al
    je      .clearScreenMain

    cmp     $'2', %al
    je      .printBootVerMain    

    cmp     $'3', %al
    je      .connectedDevicesMain

    cmp     $'4', %al
    je      .rebootMain

    cmp     $'5', %al
    je      .availableRAMMain

    call    printChar
    jmp     main

    .clearScreenMain:
        call    clearScreen
        jmp     main
    .printBootVerMain:
        movw    $versionmsg, %si
        call    printString
        movw    $version, %si
        call    printString
        jmp     main
    .connectedDevicesMain:
        call    connectedDevices
        jmp     main
    .rebootMain:
        call    clearScreen
        int     $0x19
    .availableRAMMain:
        movw    $rammsg, %si
        call    printString
        call    availableRAM
        movw    $rammsg2, %si
        call    printString
        jmp     main

versionmsg:     .asciz  "Version:\n\r"
version:        .asciz  "KernelTrabalho1 v0.5\n\r"
rammsg:         .asciz  "RAM available:\r\n0x"
rammsg2:        .asciz  " kB\r\n"
connected:      .asciz  "Devices:\n\r"
disketteF:      .asciz  "Diskette found\n\r"
disketteNF:     .asciz  "Diskette not found\n\r"
coprocessorF:   .asciz  "Math coprocessor found\n\r"
coprocessorNF:  .asciz  "Math coprocessor not found\n\r"
pointingdevF:   .asciz  "Pointing device found\n\r"
pointingdevNF:  .asciz  "Pointing device not found\n\r"

. = _start + 510 
.byte   0x55, 0xAA



