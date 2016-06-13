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

@ Sets up interrupts.
intsetup:
	@ Load the interrupt structure into registers, then unload into the beginning of ram.
	ldr r0, =interrupts
	push {r4-r11}
	ldmia r0!, {r4-r11}
	mov r0, #0
	stmia r0!, {r4-r11}
	pop {r4-r11}

	@ Enable IRQ and FIQ.
	msr CPSR_c, #0x13

	bx lr

@ Undefined Instruction Interrupt
intUND:
	bx lr
@ Syscall
intSWI:
	bx lr
@ Abort in Instruction Prefetch
intPRE:
	bx lr
@ Abort in Data Handling
intDAT:
	bx lr
@ External IRQ
intIRQ:
	bx lr
@ External FIQ
intFIQ:
	bx lr

.section .data

@ Data structure for interrupts.
interrupts:
	b reset		@ RESET - Supervisor Mode
	b intUND	@ UNDEFINED - Undefined Mode
	b intSWI	@ SOFTWARE - Supervisor Mode
	b intPRE	@ PREFETCH - Abort Mode
	b intDAT	@ DATA - Abort Mode
	b halt		@ RESERVED
	b intIRQ	@ EXTERNAL - Irq Mode
	b intFIQ	@ FASTEXTERNAL - Fiq Mode
