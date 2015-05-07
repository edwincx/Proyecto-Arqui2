evalua: evalua.o
	ld -o evalua evalua.o

evalua.o: evalua.asm
	yasm -f elf64 evalua.asm
