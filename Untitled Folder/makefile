
calcu: calcu.o
	ld -o calcu calcu.o

calcu.o: calcu.asm
	yasm -f elf64 calcu.asm
