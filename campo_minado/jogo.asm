call main
halt
print_str:
	push r0
	mov r0, sp
	loadn r7, #4
	sub r7, r0, r7
	mov sp, r7
	loadn r7, #1
	sub r7, r0, r7
	storei r7, r1
	loadn r7, #2
	sub r7, r0, r7
	storei r7, r2
	loadn r1, #0
	loadn r2, #3
	sub r2, r0, r2
	storei r2, r1
L13:
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #3
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #1
	mul r2, r2, r3
	add r1, r1, r2
	loadi r1, r1
	loadn r2, #0
	cmp r1, r2
	push fr
	pop r1
	not r1, r1
	loadn r7, #4
	and r1, r1, r7
	jz L14
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #3
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #1
	mul r2, r2, r3
	add r1, r1, r2
	loadi r1, r1
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #3
	sub r3, r0, r3
	loadi r3, r3
	add r2, r2, r3
	outchar r1, r2
	loadn r1, #3
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #1
	add r1, r1, r2
	loadn r2, #3
	sub r2, r0, r2
	storei r2, r1
	jmp L13
L14:
L15:
Lend4:
	mov sp, r0
	pop r0
	rts
clearScreen:
	push r0
	mov r0, sp
	loadn r7, #2
	sub r7, r0, r7
	mov sp, r7
	loadn r1, #0
	loadn r2, #1
	sub r2, r0, r2
	storei r2, r1
L16:
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #1200
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #2
	and r1, r1, r7
	jz L17
	loadn r1, #32
	loadn r2, #1
	sub r2, r0, r2
	loadi r2, r2
	outchar r1, r2
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #1
	add r1, r1, r2
	loadn r2, #1
	sub r2, r0, r2
	storei r2, r1
	jmp L16
L17:
L18:
Lend5:
	mov sp, r0
	pop r0
	rts
espera_espaco:
	push r0
	mov r0, sp
	loadn r7, #2
	sub r7, r0, r7
	mov sp, r7
	loadn r1, #0
	loadn r2, #1
	sub r2, r0, r2
	storei r2, r1
L19:
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #32
	cmp r1, r2
	push fr
	pop r1
	not r1, r1
	loadn r7, #4
	and r1, r1, r7
	jz L20
	inchar r1
	loadn r2, #1
	sub r2, r0, r2
	storei r2, r1
	jmp L19
L20:
L21:
Lend6:
	mov sp, r0
	pop r0
	rts
main:
	push r0
	mov r0, sp
	loadn r7, #2
	sub r7, r0, r7
	mov sp, r7
	loadn r1, #str3
	loadn r2, #3
	loadn r3, #40
	mul r2, r2, r3
	loadn r3, #14
	add r2, r2, r3
	call print_str
	mov r3, r7
	loadn r1, #str4
	loadn r2, #6
	loadn r3, #40
	mul r2, r2, r3
	loadn r3, #6
	add r2, r2, r3
	call print_str
	mov r3, r7
	call espera_espaco
	mov r1, r7
	call clearScreen
	mov r1, r7
	loadn r1, #10
	loadn r2, #1
	sub r2, r0, r2
	storei r2, r1
	loadn r1, #str5
	loadn r2, #0
	call print_str
	mov r3, r7
L22:
	loadn r1, #1
	jz L23
	jmp L22
L23:
L24:
	loadn r1, #0
	mov r7, r1
	jmp Lend7
Lend7:
	mov sp, r0
	pop r0
	rts
str0 : string "CAMPO MINADO"
str1 : string "PRESSIONE ESPACO PARA JOGAR"
str2 : string "BOMBAS: 10"
str3 : string "CAMPO MINADO"
str4 : string "PRESSIONE ESPACO PARA JOGAR"
str5 : string "BOMBAS: 10"
