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

    movb    $0x00, %ah
    int     $0x16           

    movb    $0x0E, %ah 
    int     $0x10
    
    nop

loop:   
    jmp     _start 

. = _start + 510 
.byte   0x55, 0xAA
