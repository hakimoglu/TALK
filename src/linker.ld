ENTRY(reset)

SECTIONS {
	. = 0x8000;
	KERNSTART = .;
	.text : ALIGN(0x1000){
		*(.boot)
		*(.text)
	}
	.data : ALIGN(0x1000){
		*(.data)
	}
	.bss : ALIGN(0x1000) {
		*(.bss)
		*(COMMON)
	}
	KERNEND = .;
	KERNSIZE = KERNEND - KERNSTART;
}
