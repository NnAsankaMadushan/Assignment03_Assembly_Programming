Assignment3_3659.x:Assignment3_3659.o
	ld -o Assignment3_3659.x Assignment3_3659.o
	
Assignment3_3659.o:Assignment3_3659.asm
	nasm -f elf64 -o Assignment3_3659.o Assignment3_3659.asm
