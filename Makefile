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
ELF := bin/kernel.elf
OUTPUT := kernel.img
OUTTYPE := binary

CFLAGS := -fpic -ffreestanding -std=gnu99  -O2
LDFLAGS := -ffreestanding -O2 -nostdlib  -lgcc

SRCFILES := $(shell find src -type f -name "*.s")
OFILES := $(patsubst %.s,%.o,$(patsubst src/%,bin/%,$(SRCFILES)))
PLATFILES := $(shell find platforms -type f -name "*.s")
PLATFORMS := $(patsubst %.s,%,$(patsubst platforms/%,%,$(PLATFILES)))
TARGETPLAT := platforms/target.s
OUTPLAT := $(patsubst %.s,%.o,$(patsubst platforms/%,bin/%,$(TARGETPLAT)))

TARGETCPU := -mcpu=$(strip $(subst @,,$(shell head -n 1 $(TARGETPLAT))))

all : $(OUTPUT) distclean

clean : distclean
	-rm -f $(OUTPUT)
	-rm -f $(ELF)
	-rm -f $(TARGETPLAT)

distclean :
	-rm -f $(OFILES)
	-rm -f $(OUTPLAT)

$(OUTPUT) : $(ELF)
	$(PREFIX)objcopy -O $(OUTTYPE) $(ELF) $(OUTPUT)

$(ELF) : $(OFILES) $(LINK)
	$(CC) $(LDFLAGS) -T $(LINK) -o $(ELF) $(OFILES)

bin/%.o : src/%.s
	-mkdir -p $(dir $@)
	$(CC) $(CFLAGS) $(MCPU) -c $< -o $@

$(OUTPLAT) : $(TARGETPLAT)
	-mkdir -p $(dir $@)
	$(CC) $(CFLAGS) $(MCPU) -c $< -o $@

$(PLATFORMS) :
	cp platforms/$@.s $(TARGETPLAT)

.PHONY : all clean distclean $(PLATFORMS)
