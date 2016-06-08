@ This file is part of Valency, the raspberry operating system.
@ Copyright (C) 2016 Ayhan Hakimoglu
@
@ Valency is free software: you can redistribute it and/or modify
@ it under the terms of the GNU General Public License as published by
@ the Free Software Foundation, either version 3 of the License, or
@ (at your option) any later version.
@
@ Valency is distributed in the hope that it will be useful,
@ but WITHOUT ANY WARRANTY; without even the implied warranty of
@ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
@ GNU General Public License for more details.
@
@ You should have received a copy of the GNU General Public License
@ along with Valency.  If not, see <http://www.gnu.org/licenses/>.

.section .text

atags:
	ldmfd sp!, a1
	b 2f

1:
	add a1, a1, #4
2:
	cmp a0, #0
	beq 1b		@ If equal, jump to local symbol 1 (B)efore.

	bx lr		@ Return.
