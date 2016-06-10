@ This file is part of TALK, The ARM Lightweight Kernel.
@ Copyright (C) 2016 Ayhan Hakimoglu
@
@ TALK is free software: you can redistribute it and/or modify
@ it under the terms of the GNU General Public License as published by
@ the Free Software Foundation, either version 3 of the License, or
@ (at your option) any later version.
@
@ TALK is distributed in the hope that it will be useful,
@ but WITHOUT ANY WARRANTY; without even the implied warranty of
@ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
@ GNU General Public License for more details.
@
@ You should have received a copy of the GNU General Public License
@ along with TALK.  If not, see <http://www.gnu.org/licenses/>.

.section .text

.global start

start:
	ldr sp,=stackt		@ Initialize stack.

	mov r0, r1
	stmfd ld!, {r1-r3}
	bl describe		@ Get the method in which hardware is described.
	ldmfd ld!, {r1-r3}
	cmp r0, =DESCUNKN
	beq halt		@ HALT if unknown.

	ldr r3, =DESCTYPE	@ Store the description type and ram address of descriptor.
	stm r3!, r0
	ldr r3, =DESCADDR
	stm r3!, r2

.section .bss

@ Reserve 2kb of stack space.
stackb:
	.skip 2048
stackt:
