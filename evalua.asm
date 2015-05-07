section .data

	; mensajes que se imprimen en pantalla


				   
	msg1:	db	10,'================================================================================',10, '||||||||||||||||||||||||||| Evaluador De Operaciones |||||||||||||||||||||||||||', 10, '================================================================================', 10,0
	lenmsg1:  equ $ - msg1

	msg2:	db	10, '  Introduzca expresion matematica seguido de las variables separadas por comas',10,0
	lenmsg2:  equ $ - msg2

	msg3:	db	10, 10, 'EXPRESION >> ',0
	lenmsg3:  equ $ - msg3

	msgErrorParentesis: db 10, 'ERROR DE SINTAXIS - Parentesis Erroneos ',0
	lenMsgErrorParentesis: equ $ - msgErrorParentesis

	msgErrorPunto:  db 10, 'ERROR DE SINTAXIS - Puntos en la expresion ',0
	lenMsgErrorPunto: equ $ -msgErrorPunto

	msgErrorOperacional:  db 10, 'ERROR DE SINTAXIS - Operaciones Incorrectas ',0
	lenMsgErrorOperacional: equ $ -msgErrorPunto

	msgErrorParametro:  db 10, 'ERROR DE SINTAXIS - Parametros no estipulados ',0
	lenMsgErrorParametro: equ $ -msgErrorParametro


section .bss
	; espacios reservados para almacenar los valores proporcionados por el usuario.FALTA GUARDAR EL LARGO 
	BufferLectura 	 resb 4096
	lenBufferLectura equ $ - BufferLectura ; 

	listaValorIncognita resb 1024
	lenlistaValorIncognita equ $- listaValorIncognita

	expresionMatematica  resb 1024; aqui va a ir guardada la expresion separada de las variables
	lenExpresionMatematica equ $ - expresionMatematica;

	expresionMateExplicita resb 1024
	lenExpresionMateExplicita equ $ - expresionMateExplicita ; Para guardar la expresion matematica implicita ya hacerla EXpresion Explicita

	expresionCompleta resb 1024
	lenexpresionCompleta equ $ - expresionCompleta 

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
			mov rsi, msg3
			mov rdx, lenmsg3
			call imprimir


			call obtenerOperacion
			call mover
			mov r13, r10                ; en r13 tenemos el largo de la expresionMatematica
			call validarParentesis
			call validarPuntos          ; valida que no exista nunca un . en la operacion	
			call validarOperaciones
			call ExpresionExplicita
			call Lista_Incognita_Valor
			mov rsi, expresionCompleta
			mov rdx, lenexpresionCompleta	
			call imprimir
			call salir

imprimir:
	mov rax,1;(syswrite)
	mov rdi,1;(stdout)
	syscall
	ret

;obtener la operacion del usuario

obtenerOperacion:
	mov rax, 0 ; (sysread)
	mov rdi, 0 ; (stdimp)
	mov rsi, BufferLectura
	mov rdx, lenBufferLectura
	syscall
	cmp rax, 1
	jz salir
	ret

mover:            ;Guarda en cada buffer la expresion y la variable , tambien quita los espacios ..
	xor rcx,rcx
	mov rcx,-1    ;Indice para empezar a revisar la BufferLectura
	xor r9, r9
	mov r9,0      ;registro contador de comas
	mov r11,-1    ;contador para las variables
	xor r10,r10
	mov r10,0
	dec rax
	
	.ciclo:
	inc rcx
	cmp rcx, rax                       ;compara lo que leyo con lo que lleva leido para saber si llego al final 
	ja .salirDeMover ;
	cmp byte[BufferLectura + rcx], ' '
	je .ciclo
	cmp byte[BufferLectura + rcx], 10
	je .ciclo
	cmp byte[BufferLectura + rcx], ',' ; revisamos la  letra[rcx] de la expresion 
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
		inc r11
		mov al, byte[BufferLectura + rcx]
		mov byte [variable1	 + r11] , al
		jmp .ciclo
			
	.agregarAVariable2:
		inc r11
		mov al, byte[BufferLectura + rcx]
		mov byte [variable2	 + r11] , al
		jmp .ciclo	
	.agregarAVariable3:
		inc r11
		mov al, byte[BufferLectura + rcx]
		mov byte [variable3	 + r11] , al
		jmp .ciclo	
	.agregarAVariable4:
		inc r11
		mov al, byte[BufferLectura + rcx]
		mov byte [variable4	 + r11] , al
		jmp .ciclo
	.agregarAVariable5:
		inc r11
		mov al, byte[BufferLectura + rcx]
		mov byte [variable5	 + r11] , al
		jmp .ciclo
	.agregarAVariable6:
		inc r11
		mov al, byte[BufferLectura + rcx]
		mov byte [variable6	 + r11] , al
		jmp .ciclo
	.agregarAVariable7:
		inc r11
		mov al, byte[BufferLectura + rcx]
		mov byte [variable7	 + r11] , al
		jmp .ciclo
	.agregarAVariable8:
		inc r11
		mov al, byte[BufferLectura + rcx]
		mov byte [variable8	 + r11] , al
		jmp .ciclo
	.agregarAVariable9:
		inc r11
		mov al, byte[BufferLectura + rcx]
		mov byte [variable9	 + r11] , al
		jmp .ciclo
	.agregarAVariable10:
		inc r11
		mov al, byte[BufferLectura + rcx]
		mov byte [variable10	 + r11] , al
		jmp .ciclo
	.agregarAVariable11:
		inc r11
		mov al, byte[BufferLectura + rcx]
		mov byte [variable11	 + r11] , al
		jmp .ciclo	
	.agregarAVariable12:
		inc r11
		mov al, byte[BufferLectura + rcx]
		mov byte [variable12	 + r11] , al
		jmp .ciclo
	.agregarAVariable13:
		inc r11
		mov al, byte[BufferLectura + rcx]
		mov byte [variable13	 + r11] , al
		jmp .ciclo
	.agregarAVariable14:
		inc r11
		mov al, byte[BufferLectura + rcx]
		mov byte [variable14	 + r11] , al
		jmp .ciclo
	.agregarAVariable15:
		inc r11
		mov al, byte[BufferLectura + rcx]
		mov byte [variable15	 + r11] , al
		jmp .ciclo
	.agregarAVariable16:
		inc r11
		mov al, byte[BufferLectura + rcx]
		mov byte [variable16	 + r11] , al
		jmp .ciclo
	.agregarAVariable17:
		inc r11
		mov al, byte[BufferLectura + rcx]
		mov byte [variable17	 + r11] , al
		jmp .ciclo
	.agregarAVariable18:
		inc r11
		mov al, byte[BufferLectura + rcx]
		mov byte [variable18	 + r11] , al
		jmp .ciclo
	.agregarAVariable19:
		inc r11
		mov al, byte[BufferLectura + rcx]
		mov byte [variable19	 + r11] , al
		jmp .ciclo
	.agregarAVariable20:
		inc r11
		mov al, byte[BufferLectura + rcx]
		mov byte [variable20	 + r11] , al
		jmp .ciclo
	.salirDeMover:
		ret

validarParentesis:
	xor rcx,rcx                                   ;limpiamos el rcx para usarlo como contador
	xor r9,r9
	mov r9,0                                      ;r9 sera nuestro contador de parentesis
	mov rcx,-1

	.ciclo:
		inc rcx
		cmp r9, -1
		je .finValidarParentesis
		cmp rcx,r10                               ;en r10 tenemos guardado la cantidad de bytes q mide la expresion.
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



validarOperaciones:
	xor rcx,rcx                                   ;limpiamos el rcx para usarlo como contador
	xor r9,r9
	mov r9,0                                      ;r9 sera nuestro contador de caracteres
	mov rcx,-1
	mov r14, 0


	.ciclo:
		xor r14, r14; el r14 es el contador de x y x+1
		xor r9, r9; cuenta cuantos signos iguales lleva
		inc rcx

		cmp rcx, 0
		je .VerInicio

		cmp rcx,r13                               ; r13 es el len de la expresion matematica
		jz .verFin                                ; Llama la funcion que valida el ultimo digito

		jmp .pbit                                 ; Evalua el bit actual

	
	.VerInicio:
		cmp byte[expresionMatematica ],'+'
		je .finalizar
		cmp byte[expresionMatematica], '*'
		je .finalizar
		cmp byte[expresionMatematica ],'/'
		je .finalizar
		jmp .ciclo

	.verFin:

		cmp byte[expresionMatematica + r13 - 2],'+'
		je .finalizar
		cmp byte[expresionMatematica + r13 - 2],'-'
		je .finalizar
		cmp byte[expresionMatematica + r13 - 2],'*'
		je .finalizar
		cmp byte[expresionMatematica + r13 - 2],'/'
		je .finalizar
		jmp .salirValidarOperaciones


	.pbit:
		cmp byte[expresionMatematica + rcx],'+'
		je  .aumentarPrecedencia
		cmp byte[expresionMatematica + rcx],'-'
		je  .aumentarPrecedencia
		cmp byte[expresionMatematica + rcx],'*'
		je  .aumentarPrecedencia
		cmp byte[expresionMatematica + rcx],'/'
		je  .aumentarPrecedencia
		jmp .ciclo

	.sbit:
		cmp byte[expresionMatematica + rcx + 1],'+'
		je  .aumentarPrecedencia
		cmp byte[expresionMatematica + rcx + 1],'-'
		je  .aumentarPrecedencia
		cmp byte[expresionMatematica + rcx + 1],'*'
		je  .aumentarPrecedencia
		cmp byte[expresionMatematica + rcx + 1],'/'
		je  .aumentarPrecedencia
		jmp .ciclo


	.aumentarPrecedencia:
		inc r9
		inc r14
		
		cmp r14, 1
		je .sbit

		cmp r9, 2
		je .finValidarOPeraciones

		cmp r14, 2
		je .ciclo


	.finValidarOPeraciones:
		cmp r9, 0
		je .salirValidarOperaciones
		cmp r9, 1
		je .salirValidarOperaciones
		mov rsi,msgErrorOperacional
		mov rdx,lenMsgErrorOperacional
		call imprimir
		jmp .salirValidarOperaciones

	.finalizar:
		mov rsi,msgErrorOperacional
		mov rdx,lenMsgErrorOperacional
		call imprimir
		jmp .salirValidarOperaciones

	.salirValidarOperaciones:
		ret




Lista_Incognita_Valor:
	 xor rcx, rcx               ; Contador de la cantidad de Variables
	 xor r15, r15				; Contador de los caracteres Int
	 xor r14, r14				; Contador del espacio siguiente en lista de caracteres
	 mov r12, -1				; Se mueve por la expresionMateExplicita
	 mov r15, 2                 ; x=100 (Valor inicia en pos 2) 
	 mov r14, 0
	 mov r11, -1
	 mov r8 , -1				; Indice de expresionCompleta

	.EscogeAccion:
		inc r12

		cmp r12, lenExpresionMateExplicita
		je .salir

		jmp .busca


	.busca:
		mov al, byte[expresionMateExplicita + r12]
		cmp al, 'a'
		jl .copy
		cmp al, 'z'
		jg .copy


		cmp al, byte[variable1]
		je .CopiarValorVariable1

		cmp al, byte[variable2]
		je .CopiarValorVariable2

		cmp al, byte[variable3]
		je .CopiarValorVariable3

		cmp al, byte[variable4]
		je .CopiarValorVariable4

		cmp al, byte[variable5]
		je .CopiarValorVariable5

		cmp al, byte[variable6]
		je .CopiarValorVariable6

		cmp al, byte[variable7]
		je .CopiarValorVariable7

		cmp al, byte[variable8]
		je .CopiarValorVariable8

		cmp al, byte[variable9]
		je .CopiarValorVariable9

		cmp al, byte[variable10]
		je .CopiarValorVariable10
		cmp al, byte[variable11]
		je .CopiarValorVariable11
		cmp al, byte[variable12]
		je .CopiarValorVariable12
		cmp al, byte[variable13]
		je .CopiarValorVariable13
		cmp al, byte[variable14]
		je .CopiarValorVariable14
		cmp al, byte[variable15]
		je .CopiarValorVariable15
		cmp al, byte[variable16]
		je .CopiarValorVariable16
		cmp al, byte[variable17]
		je .CopiarValorVariable17
		cmp al, byte[variable18]
		je .CopiarValorVariable18
		cmp al, byte[variable19]
		je .CopiarValorVariable19
		cmp al, byte[variable20]
		je .CopiarValorVariable20
		
		jmp .error

	.error:
		mov rsi, msgErrorParametro
		mov rdx, lenMsgErrorParametro
		call imprimir
		ret

	.copy:
		inc r8
		mov al, byte[expresionMateExplicita + r12]
		mov byte[expresionCompleta + r8], al
		jmp .EscogeAccion


	.CopiarValorVariable1:
		cmp r15, lenVariable1
		je .siguiente
		inc r8

		mov al, byte[variable1 + r15]
		mov byte[expresionCompleta + r8],al
		inc r15
		inc r8
		jmp .CopiarValorVariable1

	.CopiarValorVariable2:
		cmp r15, lenVariable2
		je .siguiente
		inc r8
		mov al, byte[variable2 + r15]
		mov byte[expresionCompleta + r8],al
		inc r15
		inc r8
		jmp .CopiarValorVariable2

	.CopiarValorVariable3:
		cmp r15, lenVariable3
		je .siguiente
		inc r8
		mov al, byte[variable3 + r15]
		mov byte[expresionCompleta + r8],al
		inc r15
		inc r8
		jmp .CopiarValorVariable3

	.CopiarValorVariable4:
		cmp r15, lenVariable4
		je .siguiente
		inc r8
		mov al, byte[variable4 + r15]
		mov byte[expresionCompleta + r8],al
		inc r15
		inc r8
		jmp .CopiarValorVariable4

	.CopiarValorVariable5:
		cmp r15, lenVariable5
		je .siguiente
		inc r8
		mov al, byte[variable5 + r15]
		mov byte[expresionCompleta + r8],al
		inc r15
		inc r8
		jmp .CopiarValorVariable5

	.CopiarValorVariable6:
		cmp r15, lenVariable6
		je .siguiente
		inc r8
		mov al, byte[variable6 + r15]
		mov byte[expresionCompleta + r8],al
		inc r15
		inc r8
		jmp .CopiarValorVariable6

	.CopiarValorVariable7:
		cmp r15, lenVariable7
		je .siguiente
		inc r8
		mov al, byte[variable7 + r15]
		mov byte[expresionCompleta + r8],al
		inc r15
		inc r8
		jmp .CopiarValorVariable7

	.CopiarValorVariable8:
		cmp r15, lenVariable8
		je .siguiente
		inc r8
		mov al, byte[variable8 + r15]
		mov byte[expresionCompleta + r8],al
		inc r15
		inc r8
		jmp .CopiarValorVariable8

	.CopiarValorVariable9:
		cmp r15, lenVariable9
		je .siguiente
		inc r8
		mov al, byte[variable9 + r15]
		mov byte[expresionCompleta + r8],al
		inc r15
		inc r8
		jmp .CopiarValorVariable9

	.CopiarValorVariable10:
		cmp r15, lenVariable10
		je .siguiente
		inc r8
		mov al, byte[variable10 + r15]
		mov byte[expresionCompleta + r8],al
		inc r15
		inc r8
		jmp .CopiarValorVariable10

	.CopiarValorVariable11:
		cmp r15, lenVariable11
		je .siguiente
		inc r8
		mov al, byte[variable11+ r15]
		mov byte[expresionCompleta + r8],al
		inc r15
		inc r8
		jmp .CopiarValorVariable11

	.CopiarValorVariable12:
		cmp r15, lenVariable12
		je .siguiente
		inc r8
		mov al, byte[variable12 + r15]
		mov byte[expresionCompleta + r8],al
		inc r15
		inc r8
		jmp .CopiarValorVariable12

	.CopiarValorVariable13:
		cmp r15, lenVariable13
		je .siguiente
		inc r8
		mov al, byte[variable13 + r15]
		mov byte[expresionCompleta + r8],al
		inc r15
		inc r8
		jmp .CopiarValorVariable13

	.CopiarValorVariable14:
		cmp r15, lenVariable14
		je .siguiente
		inc r8
		mov al, byte[variable14 + r15]
		mov byte[expresionCompleta + r8],al
		inc r15
		inc r8
		jmp .CopiarValorVariable14

	.CopiarValorVariable15:
		cmp r15, lenVariable15
		je .siguiente
		inc r8
		mov al, byte[variable15 + r15]
		mov byte[expresionCompleta + r8],al
		inc r15
		inc r8
		jmp .CopiarValorVariable15

	.CopiarValorVariable16:
		cmp r15, lenVariable16
		je .siguiente
		inc r8
		mov al, byte[variable16 + r15]
		mov byte[expresionCompleta + r8],al
		inc r15
		inc r8
		jmp .CopiarValorVariable16

	.CopiarValorVariable17:
		cmp r15, lenVariable17
		je .siguiente
		inc r8
		mov al, byte[variable17 + r15]
		mov byte[expresionCompleta + r8],al
		inc r15
		inc r8
		jmp .CopiarValorVariable17

	.CopiarValorVariable18:
		cmp r15, lenVariable18
		je .siguiente
		inc r8
		mov al, byte[variable18 + r15]
		mov byte[expresionCompleta + r8],al
		inc r15
		inc r8
		jmp .CopiarValorVariable18

	.CopiarValorVariable19:
		cmp r15, lenVariable19
		je .siguiente
		inc r8
		mov al, byte[variable19 + r15]
		mov byte[expresionCompleta + r8],al
		inc r15
		inc r8
		jmp .CopiarValorVariable19

	.CopiarValorVariable20:
		cmp r15, lenVariable20
		je .siguiente
		inc r8
		mov al, byte[variable20 + r15]
		mov byte[expresionCompleta + r8],al
		inc r15
		inc r8
		jmp .CopiarValorVariable20

	.siguiente:
		mov r15, 2
		jmp .EscogeAccion

	.salir:
		ret


ExpresionExplicita:
	xor rcx,rcx  
	xor r8,r8                                 ;limpiamos el rcx para usarlo como contador
	mov rcx,-1
	xor r14,r14
	mov r14, -1	
	xor r9,r9
	mov r9,0							          ; Cuando exista multiplicación implicita; se guardar en esta variable
												  ; el numero. e.g xy (se guardaria "y" para reemplazar por "*" y en la siguiente se pone)
	.ciclo:
		inc rcx  
		inc r14								  ;r9 indica si los dos seguidos son letra y numero o dos numeros (siempre inicia en 0)
		mov r9, 0
		mov r8, 0

		cmp rcx, r13
		je .salida
		                     								  ; SI hubo un "*"; se debe cambiar el sigueinte por la letra sustituida
		mov al, byte[expresionMatematica + rcx]               ; Agregar un numero o letra de forma normal
		mov byte [expresionMateExplicita + r14] , al

		cmp byte[expresionMatematica + rcx +1],'('
		je .Parentesis1

		cmp byte[expresionMatematica + rcx ],')'
		je .Parentesis2

		cmp byte[expresionMatematica + rcx],'0'
		jl .ciclo

		cmp byte[expresionMatematica + rcx+1],'0'
		jl .ciclo

		cmp byte[expresionMatematica + rcx],'9'
		jl  .setBandera1

		
	.seguir:
		cmp byte[expresionMatematica + rcx+1],'9'
		jl  .setBandera2
		
	.seguir2:
		jmp .comparateFirstByte

	.Parentesis1:
		cmp byte[expresionMatematica + rcx], '+'
		je .ciclo
		cmp byte[expresionMatematica + rcx], '-'
		je .ciclo
		cmp byte[expresionMatematica + rcx], '*'
		je .ciclo
		cmp byte[expresionMatematica + rcx], '/'
		je .ciclo
		jmp .agregarPor

	.Parentesis2:
		cmp byte[expresionMatematica + rcx +1], '+'
		je .ciclo
		cmp byte[expresionMatematica + rcx +1], '-'
		je .ciclo
		cmp byte[expresionMatematica + rcx +1], '*'
		je .ciclo
		cmp byte[expresionMatematica + rcx +1], '/'
		je .ciclo
		cmp byte[expresionMatematica + rcx +1], ''
		je .ciclo
		jmp .agregarPor

	
	.comparateFirstByte:
		and r9,r8
		cmp r9,0
		je .agregarPor
		jmp .ciclo                                     ; numero y letra o ambas son letras. -1, 0 y 1 indican multiplicacion

	.setBandera2:
		mov r8,1
		jmp .seguir2

	.setBandera1:
		mov r9,1
		jmp .seguir

	.setBandera0:
		mov r9,0
		jmp .seguir2

	.agregarPor:
		inc r14
		mov al, '*'
		mov byte [expresionMateExplicita + r14], al           ; Agregar un *
		jmp .ciclo

	.salida:
		ret