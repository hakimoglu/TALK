# This file is part of TALK, The ARM Lightweight Kernel.
# Copyright (C) 2016 Ayhan Hakimoglu
#
# TALK is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# TALK is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with TALK.  If not, see <http://www.gnu.org/licenses/>.

WARNINGS := -Wall -Wextra -pedantic -Wshadow -Wpointer-arith -Wcast-align \
            -Wwrite-strings -Wmissing-prototypes -Wmissing-declarations \
            -Wredundant-decls -Wnested-externs -Winline -Wno-long-long \
            -Wuninitialized -Wconversion -Wstrict-prototypes

PREFIX := arm-none-eabi-
CC := $(PREFIX)gcc

LINK := src/linker.ld

CFLAGS := -fpic -ffreestanding -std=gnu99  -O2 -mcpu=arm1176jzf-s
LDFLAGS := -ffreestanding -O2 -nostdlib  -lgcc

SRCFILES := $(shell find src -type f -name "*.s")
DEPFILES := $(patsubst %.s,%.d,$(SRCFILES))
OFILES := $(patsubst %.s,%.o,$(patsubst src/%,bin/%,$(SRCFILES)))

-include $(DEPFILES)

all : kernel.img

clean :
	-rm -f $(OFILES)
	-rm -f $(DEPFILES)
	-rm -f bin/talk.elf
	-rm -f kernel.img

kernel.img : bin/talk.elf
	$(PREFIX)objcopy bin/talk.elf -O binary kernel.img

bin/talk.elf : $(OFILES) $(LINK)
	@$(CC) $(LDFLAGS) -T $(LINK) -o bin/talk.elf $(OFILES)

bin/%.o : src/%.s Makefile
	-mkdir -p $(dir $@)
	@$(CC) $(CFLAGS) -MMD -MP -c $< -o $@

src/linker.ld :

.PHONY : all clean
