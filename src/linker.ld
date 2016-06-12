ENTRY(start)

SECTIONS {
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
}
