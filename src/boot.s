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

.section .boot

.global start

start:
	bl stack

	b halt

.section .text

@ Initialize the stack.
stack:
	msr CPSR_c, #0xD2	@ IRQ Mode, No FIQ/IRQ
	ldr sp,=stacktIRQ

	msr CPSR_c, #0xD1	@ FIQ Mode, No FIQ/IRQ
	ldr sp,=stacktFIQ

	msr CPSR_c, #0xD7	@ ABORT Mode, No FIQ/IRQ
	ldr sp,=stacktABT

	msr CPSR_c, #0xDB	@ UNDEFINED Mode, No FIQ/IRQ
	ldr sp,=stacktUND

	msr CPSR_c, #0xD3	@ SUPERVISOR Mode, No FIQ/IRQ
	ldr sp,=stackt

	bx lr

.section .bss

@ Reserve 2kb of stack space.
stackb:
	.skip 2048
stackt:

stackbIRQ:
	.skip 256
stacktIRQ:
stackbFIQ:
	.skip 256
stacktFIQ:
stackbABT:
	.skip 256
stacktABT:
stackbUND:
	.skip .256
stacktUND:
