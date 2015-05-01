section .data

	; mensajes que se imprimen en pantalla

	msg1:	db	10, '====EVALUADOR DE OPERACIONES MATEMATICAS====',10,0
	lenmsg1:  equ $ - msg1

	msg2:	db	10, 'Introduzca la expresion matematica seguido de las variables separadas con una coma',10,0
	lenmsg2:  equ $ - msg2

	msgErrorParentesis: db 10, 'ERROR DE SINTAXIS 00',10,0
	lenMsgErrorParentesis: equ $ - msgErrorParentesis

	msgErrorPunto:  db 10, 'ERROR DE SINTAXIS 01',10,0
	lenMsgErrorPunto: equ $ -msgErrorPunto

section .bss
	; espacios reservados para almacenar los valores proporcionados por el usuario.FALTA GUARDAR EL LARGO 
	BufferLectura 	 resb 2048
	lenBufferLectura equ $ - BufferLectura ; 

	expresionMatematica  resb 1024; aqui va a ir guardada la expresion separada de las variables
	lenExpresionMatematica equ $ - expresionMatematica;

	variable1	 resw 10
	lenVariable1  equ $ - variable1

	variable2    resw 10
	lenVariable2  equ $ - variable2

	variable3    resw 10
	lenVariable3  equ $ - variable3

	variable4    resw 10
	lenVariable4  equ $ - variable4

	variable5    resw 10
	lenVariable5  equ $ - variable5

	variable6    resw 10
	lenVariable6  equ $ - variable6

	variable7    resw 10
	lenVariable7  equ $ - variable7

	variable8    resw 10
	lenVariable8  equ $ - variable8

	variable9    resw 10
	lenVariable9  equ $ - variable9

	variable10   resw 10 
	lenVariable10  equ $ - variable10

	variable11   resw 10
	lenVariable11  equ $ - variable11

	variable12   resw 10
	lenVariable12  equ $ - variable12

	variable13   resw 10
	lenVariable13  equ $ - variable13

	variable14   resw 10
	lenVariable14 equ $ - variable14

	variable15   resw 10
	lenVariable15  equ $ - variable15

	variable16   resw 10
	lenVariable16  equ $ - variable16

	variable17   resw 10
	lenVariable17  equ $ - variable17

	variable18   resw 10
	lenVariable18  equ $ - variable18

	variable19   resw 10
	lenVariable19  equ $ - variable19

	variable20   resw 10
	lenVariable20  equ $ - variable20



section .text

global _start

	_start:

			main:

			mov rsi, msg1
			mov rdx, lenmsg1
			call imprimir
			mov rsi, msg2
			mov rdx, lenmsg2
			call imprimir
			call obtenerOperacion
			call mover
			call validarParentesis
			call validarPuntos; valida que no exista nunca un . en la operacion	
			call salir


; imprimir el mensaje 1

imprimir:
	mov rax,1;(syswrite)
	mov rdi,1;(stdout)
	syscall
	ret

;obtener la operacion del usuario

obtenerOperacion:

	mov rax, 0 ; (sysread)
	mov rdi, 0 ;(stdimp)
	mov rsi, BufferLectura
	mov rdx, lenBufferLectura
	syscall
	cmp rax, 1
	jz salir
	ret

mover:;Guarda en cada buffer la expresion y la variable , tambien quita los espacios ..
	xor rcx,rcx
	mov rcx,-1 ; indice para empezar a revisar la BufferLectura
	xor r9, r9
	mov r9,0 ; registro contador de comas
	mov r11,-1 ; contador para las variables
	mov r10,0
	dec rax
	
	.ciclo:
	inc rcx
	inc r11
	cmp rcx,rax; compara lo que leyo con lo que lleva leido para saber si llego al final 
	ja imprimir
	ja .salirDeMover ;
	cmp byte[BufferLectura + rcx], ' '
	je .ciclo
	cmp byte[BufferLectura + rcx], 10
	je .ciclo
	cmp byte[BufferLectura + rcx], ','; revisamos la  letra[rcx] de la expresion 
	je .incrementarContadorDeComas
	
	.verificarEnCualBufferGuardar:
		cmp r9,0
		je .agregarAExpresionMatematica
		cmp r9,1
		je .agregarAVariable1
		cmp r9,2
		je .agregarAVariable2
		cmp r9,3
		je .agregarAVariable3
		cmp r9,4
		je .agregarAVariable4
		cmp r9,5
		je .agregarAVariable5
		cmp r9,6
		je .agregarAVariable6
		cmp r9,7
		je .agregarAVariable7
		cmp r9,8
		je .agregarAVariable8
		cmp r9,9
		je .agregarAVariable9
		cmp r9,10
		je .agregarAVariable10
		cmp r9,11
		je .agregarAVariable11
		cmp r9,12
		je .agregarAVariable12
		cmp r9,13
		je .agregarAVariable13
		cmp r9,14
		je .agregarAVariable14
		cmp r9,15
		je .agregarAVariable15
		cmp r9,16
		je .agregarAVariable16
		cmp r9,17
		je .agregarAVariable17
		cmp r9,18
		je .agregarAVariable18
		cmp r9,19
		je .agregarAVariable19
		cmp r9,20
		je .agregarAVariable20

	.incrementarContadorDeComas:
		inc r9 ; incrementamos el r9 si encuentro la coma
		xor r11,r11
		mov r11,-1
		jmp .ciclo

	.agregarAExpresionMatematica:
		inc r10; contador de bytes de expresionMatematica
		mov al, byte[BufferLectura + rcx]
		mov byte [expresionMatematica + rcx] , al
		jmp .ciclo	
	.agregarAVariable1:
		mov al, byte[BufferLectura + rcx]
		mov byte [variable1	 + r11] , al
		jmp .ciclo	
	.agregarAVariable2:
		mov al, byte[BufferLectura + rcx]
		mov byte [variable2	 + r11] , al
		jmp .ciclo	
	.agregarAVariable3:
		mov al, byte[BufferLectura + rcx]
		mov byte [variable3	 + r11] , al
		jmp .ciclo	
	.agregarAVariable4:
		mov al, byte[BufferLectura + rcx]
		mov byte [variable4	 + r11] , al
		jmp .ciclo
	.agregarAVariable5:
		mov al, byte[BufferLectura + rcx]
		mov byte [variable1	 + r11] , al
		jmp .ciclo
	.agregarAVariable6:
		mov al, byte[BufferLectura + rcx]
		mov byte [variable6	 + r11] , al
		jmp .ciclo
	.agregarAVariable7:
		mov al, byte[BufferLectura + rcx]
		mov byte [variable7	 + r11] , al
		jmp .ciclo
	.agregarAVariable8:
		mov al, byte[BufferLectura + rcx]
		mov byte [variable8	 + r11] , al
		jmp .ciclo
	.agregarAVariable9:
		mov al, byte[BufferLectura + rcx]
		mov byte [variable9	 + r11] , al
		jmp .ciclo
	.agregarAVariable10:
		mov al, byte[BufferLectura + rcx]
		mov byte [variable10	 + r11] , al
		jmp .ciclo
	.agregarAVariable11:
		mov al, byte[BufferLectura + rcx]
		mov byte [variable11	 + r11] , al
		jmp .ciclo	
	.agregarAVariable12:
		mov al, byte[BufferLectura + rcx]
		mov byte [variable12	 + r11] , al
		jmp .ciclo
	.agregarAVariable13:
		mov al, byte[BufferLectura + rcx]
		mov byte [variable13	 + r11] , al
		jmp .ciclo
	.agregarAVariable14:
		mov al, byte[BufferLectura + rcx]
		mov byte [variable14	 + r11] , al
		jmp .ciclo
	.agregarAVariable15:
		mov al, byte[BufferLectura + rcx]
		mov byte [variable15	 + r11] , al
		jmp .ciclo
	.agregarAVariable16:
		mov al, byte[BufferLectura + rcx]
		mov byte [variable16	 + r11] , al
		jmp .ciclo
	.agregarAVariable17:
		mov al, byte[BufferLectura + rcx]
		mov byte [variable17	 + r11] , al
		jmp .ciclo
	.agregarAVariable18:
		mov al, byte[BufferLectura + rcx]
		mov byte [variable18	 + r11] , al
		jmp .ciclo
	.agregarAVariable19:
		mov al, byte[BufferLectura + rcx]
		mov byte [variable19	 + r11] , al
		jmp .ciclo
	.agregarAVariable20:
		mov al, byte[BufferLectura + rcx]
		mov byte [variable20	 + r11] , al
		jmp .ciclo
	.salirDeMover:
		ret

validarParentesis:
	xor rcx,rcx ; limpiamos el rcx para usarlo como contador
	xor r9,r9
	mov r9,0; r9 sera nuestro contador de parentesis
	mov rcx,-1

	.ciclo:
		inc rcx
		cmp r9, -1
		je .finValidarParentesis
		cmp rcx,r10; en r10 tenemos guardado la cantidad de bytes q mide la expresion.
		jz .finValidarParentesis
		cmp byte[expresionMatematica + rcx],'('
		je .aumentarContadorDeParentesis
		cmp byte [expresionMatematica + rcx],')'
		je .disminuirContadorDeParentesis
		jmp .ciclo

	.aumentarContadorDeParentesis:
		inc r9
		jmp .ciclo

	.disminuirContadorDeParentesis:
		dec r9
		jmp .ciclo

	.finValidarParentesis:
		cmp r9,0
		je .salirValidarParentesis
		mov rsi,msgErrorParentesis
		mov rdx,lenMsgErrorParentesis
		call imprimir
		jmp salir

	.salirValidarParentesis:
	ret

validarPuntos:
	xor rcx,rcx ; limpiamos el rcx para usarlo como contador
	mov rcx,-1

	.ciclo:
		inc rcx
		cmp rcx,r10; en r10 tenemos guardado la cantidad de bytes q mide la expresion.
		jz .salirValidarPunto
		cmp byte[expresionMatematica + rcx],'.'
		je .lanzarError
		jmp .ciclo

	.lanzarError:
		mov rsi,msgErrorPunto
		mov rdx,lenMsgErrorPunto
		call imprimir
		jmp salir			

	.salirValidarPunto:
	ret

salir:
	mov rax,60 ; (sysExit)
	mov rdi, 0
	syscall

