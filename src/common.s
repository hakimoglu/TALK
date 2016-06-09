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

.section .data

@ Hardware description types.
.global DESCATAGS
.global DESCDT
.global DESCHARD
.global DESCUNKN
.equ DESCATAGS,	0	@ Should be set if r2 contains an ATAGS pointer.
.equ DESCDT,	1	@ Should be set if r2 contains an DEVICE TREE pointer.
.equ DESCHARD,	2	@ Should be set if r2 is useless and the hardware is hardcoded.
.equ DESCUNKN,	3	@ Should be set if r2 is useless because the hardware is unknown.

@ Hardware description stored variables.
DESCTYPE:
	.word 0
DESCADDR:
	.word 0




.section .text

.global halt
halt:
	wfe
	b halt
