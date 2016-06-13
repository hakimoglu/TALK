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

.section .data

@ Data structure for interrupts.
interrupts:
	b		@ RESET - Supervisor Mode
	b		@ UNDEFINED - Undefined Mode
	b		@ SOFTWARE - Supervisor Mode
	b		@ PREFETCH - Abort Mode
	b		@ DATA - Abort Mode
	b		@ RESERVED
	b		@ EXTERNAL - Irq Mode
	b		@ FASTEXTERNAL - Fiq Mode
