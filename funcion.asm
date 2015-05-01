section .bss

	BufferReader 	 resb 2048
	lenBufferReader equ $ - BufferReader ; 

	Operacion  resb 1024; aqui va a ir guardada la expresion separada de las variables
	lenOperacion equ $ - Operacion;



section .text
	global _start
_start:
main:
	call read
	call imprimir
	call salir




read:
	mov rax, 0 ; (sysread)
	mov rdi, 0 ;(stdimp)
	mov rsi, BufferReader
	mov rdx, lenBufferReader
	syscall
	cmp rax, 1
	jz salir
	ret

imprimir:
	mov rax,1
	mov rdi,1
	syscall

salir:
	mov rax,60 ; (sysExit)
	mov rdi, 0
	syscall