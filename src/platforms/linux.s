@ This file is part of TALK, The ARM Linuxlike Kernel.
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

.global describe

@ Read the description type.
@ IN:	r0:	ARM Linux device type.
@ OUT:	r0:	DESC* - Defined in common.s.
describe:
	ldr r1, #0xC42		@ Raspberry Pi - Uses ATAGS.
	cmp r0, r1
	ldreq r0, =DESCATAGS
	bxeq lr

	ldr r0, =DESCUNKN	@ We don't support it at the moment, return UNKNOWN.
	bx lr
