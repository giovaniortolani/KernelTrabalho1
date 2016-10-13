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
    # limpa os registradores
    xorw    %ax, %ax    
    movw    %ax, %ds
    movw    %ax, %ss
    movw    %ax, %es
    movw    %ax, %fs
    sti     # habilita interrupcoes

    jmp     main

.type readChar, @function
readChar:
    
    movb    $0x00, %ah  # AH = codigo leitura de teclado
    int     $0x16       # interrupcao de teclado
    # AL = ascii tecla pressionada             

    ret

.type printChar, @function
printChar:

    # AL = caracter a ser escrito na tela
    movb    $0x0E, %ah  # AH = codigo para escrever na pagina ativa
    int     $0x10       # interrupcao de teclado

    # rotina de verificao de New Line e Carriage Return
    cmp     $'\n', %al 
    jne     .notNL      # AL != '\n' (nao apertou ENTER)
    mov     $'\r', %al
    int     $0x10       # imprime \r apos o \n para fazer a quebra de linha
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

    movb    $0x00, %ah  # AH = set video mode
    movb    $0x02, %al  # AL = requested mode (80x25 -  16 colors - alphanumeric)
    int     $0x10       # interrupcao de video
    
    ret

.type printString, @function
printString:
    # deve ser carregado o endereco da string em SI antes da chamada
    lodsb   # carrega o byte no endereço DS:SI em AL, SI possui endereco da string
            # incrementa SI
    orb     %al, %al            # ainda existem caracteres?
    jz      .printStringEnd
    movb    $0x0E, %ah          # AH = codigo para escrever na pagina ativa
    int     $0x10               # interrupcao de teclado
    jmp     printString

    .printStringEnd:
        ret

.type connectedDevices, @function
connectedDevices:
    
    int     $0x11       # interrupcao para determinacao de equipamento
    # AX = retorno com os dispositivos conectados ou nao
    movw    %ax, %bx    # salva o valor de AX
    
    movw    $connected, %si
    call    printString

    and     $0x0001, %ax        # mascara para determinar a presenca de diskette
    cmp     $0, %ax             # if 0 then diskette not found
    je      .disketteNOTFound
    movw    $disketteF, %si     # diskette found
    call    printString
    jmp     .coprocessor

    .disketteNOTFound:
        movw    $disketteNF, %si    # diskette not found
        call    printString

    .coprocessor:
        movw    %bx, %ax                # restaura os valores de AX
        and     $0x0002, %ax            # mascara para determinar a presenca de processador
        cmp     $0, %ax                 # if 0 then math coprocessor not found
        je      .coprocessorNOTFound
        movw    $coprocessorF, %si      # math coprocessor found
        call    printString
        jmp     .pointingdev

        .coprocessorNOTFound:
            movw    $coprocessorNF, %si     # math coprocessor not found
            call    printString

        .pointingdev:
            movw    %bx, %ax                # restaura os valores de AX
            and     $0x0004, %ax            # mascara para determinar a presenca de pointing device
            cmp     $0, %ax                 # if 0 then pointing device not found
            je      .pointingdevNOTFound
            movw    $pointingdevF, %si      # pointing device found
            call    printString
            jmp     .connectedDevicesEnd

            .pointingdevNOTFound:
                movw    $pointingdevNF, %si     # pointing device not found
                call    printString

    .connectedDevicesEnd:
        ret

.type availableRAM, @function
availableRAM:
    
    int     $0x12   # interrupcao memory size determination
    # AX = retorno com o tamanho de memoria disponivel (em blocos de 1 kB)
    movw    %ax, %bx    # salva o valor de AX 
    and     $0xF, %al   # aplica a mascara para pegar os 4 bits menos significativos
    xorw    %cx, %cx    # limpa CX
    movb    $16, %cl    # contador do numero de bits para deslocamento (anda de 4 em 4 - nibbles)

    .printHEX:
        sub     $4, %cx     # CL = CL - 4
        shr     %cl, %ax    # shift right AX em CL bits
        and     $0xF, %ax   # aplica a mascara para obter o valor do digito (mascara = 1111)

        cmp     $10, %ax    # if < 10 then NUMBER (0 - 9) else LETTER (A - F)
        jl      .printHEXnumber

        # apos a mascara fica 00001111 (15 dec - 0F hex) - tab. ASCII
        # subtraimos 10 para ficar 00000101
        # 0100 0110 (F) = 00000101 (%ax) + 0100 0001 (ascii A)
        sub     $10, %ax    
        add     $'A', %ax
        call    printChar
        jmp     .printHEXend

        .printHEXnumber:
            add     $'0', %ax   # soma o valor ASCII do 0 ao NUMBER
            call    printChar

        .printHEXend:
            movw    %bx, %ax    # restaura o valor de AX
            cmp     $0, %cx     # CX == 0, acabaram os digitos
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



