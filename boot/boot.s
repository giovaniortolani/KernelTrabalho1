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
    jne     notNL
    mov     $'\r', %al
    int     $0x10   
    jmp     notCR

    notNL: 
        cmp     $'\r', %al
        jne     notCR
        mov     $'\n', %al
        int     $0x10
    
    notCR:
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



