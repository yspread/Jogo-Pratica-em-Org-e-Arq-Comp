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
L1:
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
	jz L2
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
	jmp L1
L2:
L3:
	loadn r1, #0
	mov r7, r1
	jmp Lend0
Lend0:
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
L4:
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #1200
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #2
	and r1, r1, r7
	jz L5
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
	jmp L4
L5:
L6:
	loadn r1, #0
	mov r7, r1
	jmp Lend1
Lend1:
	mov sp, r0
	pop r0
	rts
printNum2:
	push r0
	mov r0, sp
	loadn r7, #5
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
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #4
	sub r2, r0, r2
	storei r2, r1
L7:
	loadn r1, #10
	loadn r2, #4
	sub r2, r0, r2
	loadi r2, r2
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #6
	and r1, r1, r7
	jz L8
	loadn r1, #4
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #10
	sub r1, r1, r2
	loadn r2, #4
	sub r2, r0, r2
	storei r2, r1
	loadn r1, #3
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #1
	add r1, r1, r2
	loadn r2, #3
	sub r2, r0, r2
	storei r2, r1
	jmp L7
L8:
L9:
	loadn r1, #48
	loadn r2, #3
	sub r2, r0, r2
	loadi r2, r2
	add r1, r1, r2
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	outchar r1, r2
	loadn r1, #48
	loadn r2, #4
	sub r2, r0, r2
	loadi r2, r2
	add r1, r1, r2
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #1
	add r2, r2, r3
	outchar r1, r2
	loadn r1, #0
	mov r7, r1
	jmp Lend2
Lend2:
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
L10:
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
	jz L11
	inchar r1
	loadn r2, #1
	sub r2, r0, r2
	storei r2, r1
	jmp L10
L11:
L12:
	loadn r1, #0
	mov r7, r1
	jmp Lend3
Lend3:
	mov sp, r0
	pop r0
	rts
idx_para_tela:
	push r0
	mov r0, sp
	loadn r7, #4
	sub r7, r0, r7
	mov sp, r7
	loadn r7, #1
	sub r7, r0, r7
	storei r7, r1
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #2
	sub r2, r0, r2
	storei r2, r1
	loadn r1, #0
	loadn r2, #3
	sub r2, r0, r2
	storei r2, r1
L13:
	loadn r1, #19
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #6
	and r1, r1, r7
	jz L14
	loadn r1, #2
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #19
	sub r1, r1, r2
	loadn r2, #2
	sub r2, r0, r2
	storei r2, r1
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
	loadn r1, #3
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #8
	add r1, r1, r2
	loadn r2, #40
	mul r1, r1, r2
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	add r1, r1, r2
	loadn r2, #10
	add r1, r1, r2
	mov r7, r1
	jmp Lend4
Lend4:
	mov sp, r0
	pop r0
	rts
pos_para_idx:
	push r0
	mov r0, sp
	loadn r7, #5
	sub r7, r0, r7
	mov sp, r7
	loadn r7, #1
	sub r7, r0, r7
	storei r7, r1
	loadn r7, #2
	sub r7, r0, r7
	storei r7, r2
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #10
	sub r1, r1, r2
	loadn r2, #3
	sub r2, r0, r2
	storei r2, r1
	loadn r1, #2
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #8
	sub r1, r1, r2
	loadn r2, #4
	sub r2, r0, r2
	storei r2, r1
	loadn r1, #4
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #19
	mul r1, r1, r2
	loadn r2, #3
	sub r2, r0, r2
	loadi r2, r2
	add r1, r1, r2
	mov r7, r1
	jmp Lend5
Lend5:
	mov sp, r0
	pop r0
	rts
printar_bomba:
	push r0
	mov r0, sp
	loadn r7, #3
	sub r7, r0, r7
	mov sp, r7
	loadn r1, #9
	loadn r2, #1
	sub r2, r0, r2
	storei r2, r1
	loadn r1, #9
	loadn r2, #2
	sub r2, r0, r2
	storei r2, r1
	loadn r1, #str0
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #0
	add r2, r2, r3
	loadn r3, #40
	mul r2, r2, r3
	loadn r3, #1
	sub r3, r0, r3
	loadi r3, r3
	add r2, r2, r3
	call print_str
	mov r3, r7
	loadn r1, #str1
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #1
	add r2, r2, r3
	loadn r3, #40
	mul r2, r2, r3
	loadn r3, #1
	sub r3, r0, r3
	loadi r3, r3
	add r2, r2, r3
	call print_str
	mov r3, r7
	loadn r1, #str2
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #2
	add r2, r2, r3
	loadn r3, #40
	mul r2, r2, r3
	loadn r3, #1
	sub r3, r0, r3
	loadi r3, r3
	add r2, r2, r3
	call print_str
	mov r3, r7
	loadn r1, #str3
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #3
	add r2, r2, r3
	loadn r3, #40
	mul r2, r2, r3
	loadn r3, #1
	sub r3, r0, r3
	loadi r3, r3
	add r2, r2, r3
	call print_str
	mov r3, r7
	loadn r1, #str4
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #4
	add r2, r2, r3
	loadn r3, #40
	mul r2, r2, r3
	loadn r3, #1
	sub r3, r0, r3
	loadi r3, r3
	add r2, r2, r3
	call print_str
	mov r3, r7
	loadn r1, #str5
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #5
	add r2, r2, r3
	loadn r3, #40
	mul r2, r2, r3
	loadn r3, #1
	sub r3, r0, r3
	loadi r3, r3
	add r2, r2, r3
	call print_str
	mov r3, r7
	loadn r1, #str6
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #6
	add r2, r2, r3
	loadn r3, #40
	mul r2, r2, r3
	loadn r3, #1
	sub r3, r0, r3
	loadi r3, r3
	add r2, r2, r3
	call print_str
	mov r3, r7
	loadn r1, #str7
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #7
	add r2, r2, r3
	loadn r3, #40
	mul r2, r2, r3
	loadn r3, #1
	sub r3, r0, r3
	loadi r3, r3
	add r2, r2, r3
	call print_str
	mov r3, r7
	loadn r1, #str8
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #8
	add r2, r2, r3
	loadn r3, #40
	mul r2, r2, r3
	loadn r3, #1
	sub r3, r0, r3
	loadi r3, r3
	add r2, r2, r3
	call print_str
	mov r3, r7
	loadn r1, #str9
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #9
	add r2, r2, r3
	loadn r3, #40
	mul r2, r2, r3
	loadn r3, #1
	sub r3, r0, r3
	loadi r3, r3
	add r2, r2, r3
	call print_str
	mov r3, r7
	loadn r1, #str10
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #10
	add r2, r2, r3
	loadn r3, #40
	mul r2, r2, r3
	loadn r3, #1
	sub r3, r0, r3
	loadi r3, r3
	add r2, r2, r3
	call print_str
	mov r3, r7
	loadn r1, #0
	mov r7, r1
	jmp Lend6
Lend6:
	mov sp, r0
	pop r0
	rts
make_tabuleiro:
	push r0
	mov r0, sp
	loadn r7, #12
	sub r7, r0, r7
	mov sp, r7
	loadn r7, #1
	sub r7, r0, r7
	storei r7, r1
	loadn r1, #0
	loadn r2, #total_bombas
	storei r2, r1
	loadn r1, #0
	loadn r2, #celulas_reveladas
	storei r2, r1
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #semente_rand
	storei r2, r1
	loadn r1, #0
	loadn r2, #2
	sub r2, r0, r2
	storei r2, r1
L16:
	loadn r1, #2
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #266
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #2
	and r1, r1, r7
	jz L17
	loadn r1, #48
	loadn r2, #mapa_jogo
	loadn r3, #2
	sub r3, r0, r3
	loadi r3, r3
	loadn r4, #1
	mul r3, r3, r4
	add r2, r2, r3
	storei r2, r1
	loadn r1, #48
	loadn r2, #revelado_jogo
	loadn r3, #2
	sub r3, r0, r3
	loadi r3, r3
	loadn r4, #1
	mul r3, r3, r4
	add r2, r2, r3
	storei r2, r1
	loadn r1, #2
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #1
	add r1, r1, r2
	loadn r2, #2
	sub r2, r0, r2
	storei r2, r1
	jmp L16
L17:
L18:
	loadn r1, #0
	loadn r2, #3
	sub r2, r0, r2
	storei r2, r1
L19:
	loadn r1, #3
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #38
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #2
	and r1, r1, r7
	jz L20
	call rand_pos
	mov r1, r7
	loadn r2, #4
	sub r2, r0, r2
	storei r2, r1
	loadn r1, #mapa_jogo
	loadn r2, #4
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #1
	mul r2, r2, r3
	add r1, r1, r2
	loadi r1, r1
	loadn r2, #57
	cmp r1, r2
	push fr
	pop r1
	not r1, r1
	loadn r7, #4
	and r1, r1, r7
	jz L22
	loadn r1, #57
	loadn r2, #mapa_jogo
	loadn r3, #4
	sub r3, r0, r3
	loadi r3, r3
	loadn r4, #1
	mul r3, r3, r4
	add r2, r2, r3
	storei r2, r1
	loadn r1, #3
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #1
	add r1, r1, r2
	loadn r2, #3
	sub r2, r0, r2
	storei r2, r1
	loadn r1, #total_bombas
	loadi r1, r1
	loadn r2, #1
	add r1, r1, r2
	loadn r2, #total_bombas
	storei r2, r1
L22:
	jmp L19
L20:
L21:
	loadn r1, #total_bombas
	loadi r1, r1
	loadn r2, #bandeiras_restantes
	storei r2, r1
	loadn r1, #0
	loadn r2, #dir_x
	loadn r3, #0
	loadn r4, #1
	mul r3, r3, r4
	add r2, r2, r3
	storei r2, r1
	loadn r1, #1
	loadn r2, #dir_x
	loadn r3, #1
	loadn r4, #1
	mul r3, r3, r4
	add r2, r2, r3
	storei r2, r1
	loadn r1, #0
	loadn r2, #dir_x
	loadn r3, #2
	loadn r4, #1
	mul r3, r3, r4
	add r2, r2, r3
	storei r2, r1
	loadn r1, #1
	not r1, r1
	inc r1
	loadn r2, #dir_x
	loadn r3, #3
	loadn r4, #1
	mul r3, r3, r4
	add r2, r2, r3
	storei r2, r1
	loadn r1, #1
	loadn r2, #dir_x
	loadn r3, #4
	loadn r4, #1
	mul r3, r3, r4
	add r2, r2, r3
	storei r2, r1
	loadn r1, #1
	loadn r2, #dir_x
	loadn r3, #5
	loadn r4, #1
	mul r3, r3, r4
	add r2, r2, r3
	storei r2, r1
	loadn r1, #1
	not r1, r1
	inc r1
	loadn r2, #dir_x
	loadn r3, #6
	loadn r4, #1
	mul r3, r3, r4
	add r2, r2, r3
	storei r2, r1
	loadn r1, #1
	not r1, r1
	inc r1
	loadn r2, #dir_x
	loadn r3, #7
	loadn r4, #1
	mul r3, r3, r4
	add r2, r2, r3
	storei r2, r1
	loadn r1, #1
	loadn r2, #dir_y
	loadn r3, #0
	loadn r4, #1
	mul r3, r3, r4
	add r2, r2, r3
	storei r2, r1
	loadn r1, #0
	loadn r2, #dir_y
	loadn r3, #1
	loadn r4, #1
	mul r3, r3, r4
	add r2, r2, r3
	storei r2, r1
	loadn r1, #1
	not r1, r1
	inc r1
	loadn r2, #dir_y
	loadn r3, #2
	loadn r4, #1
	mul r3, r3, r4
	add r2, r2, r3
	storei r2, r1
	loadn r1, #0
	loadn r2, #dir_y
	loadn r3, #3
	loadn r4, #1
	mul r3, r3, r4
	add r2, r2, r3
	storei r2, r1
	loadn r1, #1
	not r1, r1
	inc r1
	loadn r2, #dir_y
	loadn r3, #4
	loadn r4, #1
	mul r3, r3, r4
	add r2, r2, r3
	storei r2, r1
	loadn r1, #1
	loadn r2, #dir_y
	loadn r3, #5
	loadn r4, #1
	mul r3, r3, r4
	add r2, r2, r3
	storei r2, r1
	loadn r1, #1
	not r1, r1
	inc r1
	loadn r2, #dir_y
	loadn r3, #6
	loadn r4, #1
	mul r3, r3, r4
	add r2, r2, r3
	storei r2, r1
	loadn r1, #1
	loadn r2, #dir_y
	loadn r3, #7
	loadn r4, #1
	mul r3, r3, r4
	add r2, r2, r3
	storei r2, r1
	loadn r1, #0
	loadn r2, #2
	sub r2, r0, r2
	storei r2, r1
	loadn r1, #0
	loadn r2, #5
	sub r2, r0, r2
	storei r2, r1
	loadn r1, #0
	loadn r2, #6
	sub r2, r0, r2
	storei r2, r1
L23:
	loadn r1, #2
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #266
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #2
	and r1, r1, r7
	jz L24
	loadn r1, #mapa_jogo
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #1
	mul r2, r2, r3
	add r1, r1, r2
	loadi r1, r1
	loadn r2, #57
	cmp r1, r2
	push fr
	pop r1
	not r1, r1
	loadn r7, #4
	and r1, r1, r7
	jz L26
	loadn r1, #0
	loadn r2, #11
	sub r2, r0, r2
	storei r2, r1
	loadn r1, #0
	loadn r2, #7
	sub r2, r0, r2
	storei r2, r1
L27:
	loadn r1, #7
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #8
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #2
	and r1, r1, r7
	jz L28
	loadn r1, #5
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #dir_x
	loadn r3, #7
	sub r3, r0, r3
	loadi r3, r3
	loadn r4, #1
	mul r3, r3, r4
	add r2, r2, r3
	loadi r2, r2
	add r1, r1, r2
	loadn r2, #8
	sub r2, r0, r2
	storei r2, r1
	loadn r1, #6
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #dir_y
	loadn r3, #7
	sub r3, r0, r3
	loadi r3, r3
	loadn r4, #1
	mul r3, r3, r4
	add r2, r2, r3
	loadi r2, r2
	add r1, r1, r2
	loadn r2, #9
	sub r2, r0, r2
	storei r2, r1
	loadn r1, #0
	loadn r2, #8
	sub r2, r0, r2
	loadi r2, r2
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #6
	and r1, r1, r7
	jz L30
	loadn r1, #8
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #19
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #2
	and r1, r1, r7
	jz L31
	loadn r1, #0
	loadn r2, #9
	sub r2, r0, r2
	loadi r2, r2
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #6
	and r1, r1, r7
	jz L32
	loadn r1, #9
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #14
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #2
	and r1, r1, r7
	jz L33
	loadn r1, #9
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #19
	mul r1, r1, r2
	loadn r2, #8
	sub r2, r0, r2
	loadi r2, r2
	add r1, r1, r2
	loadn r2, #10
	sub r2, r0, r2
	storei r2, r1
	loadn r1, #mapa_jogo
	loadn r2, #10
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #1
	mul r2, r2, r3
	add r1, r1, r2
	loadi r1, r1
	loadn r2, #57
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L34
	loadn r1, #11
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #1
	add r1, r1, r2
	loadn r2, #11
	sub r2, r0, r2
	storei r2, r1
L34:
L33:
L32:
L31:
L30:
	loadn r1, #7
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #1
	add r1, r1, r2
	loadn r2, #7
	sub r2, r0, r2
	storei r2, r1
	jmp L27
L28:
L29:
	loadn r1, #48
	loadn r2, #11
	sub r2, r0, r2
	loadi r2, r2
	add r1, r1, r2
	loadn r2, #mapa_jogo
	loadn r3, #2
	sub r3, r0, r3
	loadi r3, r3
	loadn r4, #1
	mul r3, r3, r4
	add r2, r2, r3
	storei r2, r1
L26:
	loadn r1, #5
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #1
	add r1, r1, r2
	loadn r2, #5
	sub r2, r0, r2
	storei r2, r1
	loadn r1, #19
	loadn r2, #5
	sub r2, r0, r2
	loadi r2, r2
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #6
	and r1, r1, r7
	jz L35
	loadn r1, #0
	loadn r2, #5
	sub r2, r0, r2
	storei r2, r1
	loadn r1, #6
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #1
	add r1, r1, r2
	loadn r2, #6
	sub r2, r0, r2
	storei r2, r1
L35:
	loadn r1, #2
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #1
	add r1, r1, r2
	loadn r2, #2
	sub r2, r0, r2
	storei r2, r1
	jmp L23
L24:
L25:
	loadn r1, #0
	mov r7, r1
	jmp Lend7
Lend7:
	mov sp, r0
	pop r0
	rts
rand:
	loadn r1, #semente_rand
	loadi r1, r1
	loadn r2, #13
	mul r1, r1, r2
	loadn r2, #7
	add r1, r1, r2
	loadn r2, #semente_rand
	storei r2, r1
	loadn r1, #semente_rand
	loadi r1, r1
	loadn r2, #0
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #2
	and r1, r1, r7
	jz L36
	loadn r1, #semente_rand
	loadi r1, r1
	loadn r2, #1
	not r2, r2
	inc r2
	mul r1, r1, r2
	loadn r2, #semente_rand
	storei r2, r1
L36:
	loadn r1, #semente_rand
	loadi r1, r1
	mov r7, r1
	jmp Lend8
Lend8:
	rts
rand_pos:
	push r0
	mov r0, sp
	loadn r7, #2
	sub r7, r0, r7
	mov sp, r7
	call rand
	mov r1, r7
	loadn r2, #1
	sub r2, r0, r2
	storei r2, r1
L37:
	loadn r1, #2660
	loadn r2, #1
	sub r2, r0, r2
	loadi r2, r2
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #6
	and r1, r1, r7
	jz L38
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #2660
	sub r1, r1, r2
	loadn r2, #1
	sub r2, r0, r2
	storei r2, r1
	jmp L37
L38:
L39:
L40:
	loadn r1, #266
	loadn r2, #1
	sub r2, r0, r2
	loadi r2, r2
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #6
	and r1, r1, r7
	jz L41
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #266
	sub r1, r1, r2
	loadn r2, #1
	sub r2, r0, r2
	storei r2, r1
	jmp L40
L41:
L42:
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	mov r7, r1
	jmp Lend9
Lend9:
	mov sp, r0
	pop r0
	rts
revelar_recursivo:
	push r0
	mov r0, sp
	loadn r7, #6
	sub r7, r0, r7
	mov sp, r7
	loadn r7, #1
	sub r7, r0, r7
	storei r7, r1
	loadn r1, #revelado_jogo
	loadn r2, #1
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #1
	mul r2, r2, r3
	add r1, r1, r2
	loadi r1, r1
	loadn r2, #49
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L43
	loadn r1, #0
	mov r7, r1
	jmp Lend10
L43:
	loadn r1, #revelado_jogo
	loadn r2, #1
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #1
	mul r2, r2, r3
	add r1, r1, r2
	loadi r1, r1
	loadn r2, #50
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L44
	loadn r1, #0
	mov r7, r1
	jmp Lend10
L44:
	loadn r1, #49
	loadn r2, #revelado_jogo
	loadn r3, #1
	sub r3, r0, r3
	loadi r3, r3
	loadn r4, #1
	mul r3, r3, r4
	add r2, r2, r3
	storei r2, r1
	loadn r1, #celulas_reveladas
	loadi r1, r1
	loadn r2, #1
	add r1, r1, r2
	loadn r2, #celulas_reveladas
	storei r2, r1
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #2
	sub r2, r0, r2
	storei r2, r1
	loadn r1, #0
	loadn r2, #3
	sub r2, r0, r2
	storei r2, r1
L45:
	loadn r1, #19
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #6
	and r1, r1, r7
	jz L46
	loadn r1, #2
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #19
	sub r1, r1, r2
	loadn r2, #2
	sub r2, r0, r2
	storei r2, r1
	loadn r1, #3
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #1
	add r1, r1, r2
	loadn r2, #3
	sub r2, r0, r2
	storei r2, r1
	jmp L45
L46:
L47:
	loadn r1, #mapa_jogo
	loadn r2, #1
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #1
	mul r2, r2, r3
	add r1, r1, r2
	loadi r1, r1
	loadn r2, #48
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L48
	loadn r1, #32
	loadn r2, #3
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #8
	add r2, r2, r3
	loadn r3, #40
	mul r2, r2, r3
	loadn r3, #2
	sub r3, r0, r3
	loadi r3, r3
	add r2, r2, r3
	loadn r3, #10
	add r2, r2, r3
	outchar r1, r2
	jmp L49
L48:
	loadn r1, #mapa_jogo
	loadn r2, #1
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #1
	mul r2, r2, r3
	add r1, r1, r2
	loadi r1, r1
	loadn r2, #3
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #8
	add r2, r2, r3
	loadn r3, #40
	mul r2, r2, r3
	loadn r3, #2
	sub r3, r0, r3
	loadi r3, r3
	add r2, r2, r3
	loadn r3, #10
	add r2, r2, r3
	outchar r1, r2
L49:
	loadn r1, #mapa_jogo
	loadn r2, #1
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #1
	mul r2, r2, r3
	add r1, r1, r2
	loadi r1, r1
	loadn r2, #48
	cmp r1, r2
	push fr
	pop r1
	not r1, r1
	loadn r7, #4
	and r1, r1, r7
	jz L50
	loadn r1, #0
	mov r7, r1
	jmp Lend10
L50:
	loadn r1, #0
	loadn r2, #4
	sub r2, r0, r2
	storei r2, r1
L51:
	loadn r1, #4
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #8
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #2
	and r1, r1, r7
	jz L52
	loadn r1, #0
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #dir_x
	loadn r4, #4
	sub r4, r0, r4
	loadi r4, r4
	loadn r5, #1
	mul r4, r4, r5
	add r3, r3, r4
	loadi r3, r3
	add r2, r2, r3
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #6
	and r1, r1, r7
	jz L54
	loadn r1, #2
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #dir_x
	loadn r3, #4
	sub r3, r0, r3
	loadi r3, r3
	loadn r4, #1
	mul r3, r3, r4
	add r2, r2, r3
	loadi r2, r2
	add r1, r1, r2
	loadn r2, #19
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #2
	and r1, r1, r7
	jz L55
	loadn r1, #0
	loadn r2, #3
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #dir_y
	loadn r4, #4
	sub r4, r0, r4
	loadi r4, r4
	loadn r5, #1
	mul r4, r4, r5
	add r3, r3, r4
	loadi r3, r3
	add r2, r2, r3
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #6
	and r1, r1, r7
	jz L56
	loadn r1, #3
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #dir_y
	loadn r3, #4
	sub r3, r0, r3
	loadi r3, r3
	loadn r4, #1
	mul r3, r3, r4
	add r2, r2, r3
	loadi r2, r2
	add r1, r1, r2
	loadn r2, #14
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #2
	and r1, r1, r7
	jz L57
	loadn r1, #3
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #dir_y
	loadn r3, #4
	sub r3, r0, r3
	loadi r3, r3
	loadn r4, #1
	mul r3, r3, r4
	add r2, r2, r3
	loadi r2, r2
	add r1, r1, r2
	loadn r2, #19
	mul r1, r1, r2
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	add r1, r1, r2
	loadn r2, #dir_x
	loadn r3, #4
	sub r3, r0, r3
	loadi r3, r3
	loadn r4, #1
	mul r3, r3, r4
	add r2, r2, r3
	loadi r2, r2
	add r1, r1, r2
	loadn r2, #5
	sub r2, r0, r2
	storei r2, r1
	loadn r1, #5
	sub r1, r0, r1
	loadi r1, r1
	call revelar_recursivo
	mov r2, r7
L57:
L56:
L55:
L54:
	loadn r1, #4
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #1
	add r1, r1, r2
	loadn r2, #4
	sub r2, r0, r2
	storei r2, r1
	jmp L51
L52:
L53:
	loadn r1, #0
	mov r7, r1
	jmp Lend10
Lend10:
	mov sp, r0
	pop r0
	rts
alternar_bandeira:
	push r0
	mov r0, sp
	loadn r7, #3
	sub r7, r0, r7
	mov sp, r7
	loadn r7, #1
	sub r7, r0, r7
	storei r7, r1
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	call idx_para_tela
	mov r2, r7
	loadn r1, #2
	sub r1, r0, r1
	storei r1, r2
	loadn r1, #revelado_jogo
	loadn r2, #1
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #1
	mul r2, r2, r3
	add r1, r1, r2
	loadi r1, r1
	loadn r2, #48
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L58
	loadn r1, #0
	loadn r2, #bandeiras_restantes
	loadi r2, r2
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #2
	and r1, r1, r7
	jz L60
	loadn r1, #50
	loadn r2, #revelado_jogo
	loadn r3, #1
	sub r3, r0, r3
	loadi r3, r3
	loadn r4, #1
	mul r3, r3, r4
	add r2, r2, r3
	storei r2, r1
	loadn r1, #bandeiras_restantes
	loadi r1, r1
	loadn r2, #1
	sub r1, r1, r2
	loadn r2, #bandeiras_restantes
	storei r2, r1
	loadn r1, #70
	loadn r2, #768
	add r1, r1, r2
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	outchar r1, r2
L60:
	jmp L59
L58:
	loadn r1, #revelado_jogo
	loadn r2, #1
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #1
	mul r2, r2, r3
	add r1, r1, r2
	loadi r1, r1
	loadn r2, #50
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L61
	loadn r1, #48
	loadn r2, #revelado_jogo
	loadn r3, #1
	sub r3, r0, r3
	loadi r3, r3
	loadn r4, #1
	mul r3, r3, r4
	add r2, r2, r3
	storei r2, r1
	loadn r1, #bandeiras_restantes
	loadi r1, r1
	loadn r2, #1
	add r1, r1, r2
	loadn r2, #bandeiras_restantes
	storei r2, r1
	loadn r1, #42
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	outchar r1, r2
L61:
L59:
	loadn r1, #0
	mov r7, r1
	jmp Lend11
Lend11:
	mov sp, r0
	pop r0
	rts
printar_selecao:
	push r0
	mov r0, sp
	loadn r7, #3
	sub r7, r0, r7
	mov sp, r7
	loadn r7, #1
	sub r7, r0, r7
	storei r7, r1
	loadn r7, #2
	sub r7, r0, r7
	storei r7, r2
	loadn r1, #42
	loadn r2, #7936
	add r1, r1, r2
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #40
	mul r2, r2, r3
	loadn r3, #1
	sub r3, r0, r3
	loadi r3, r3
	add r2, r2, r3
	outchar r1, r2
	loadn r1, #0
	mov r7, r1
	jmp Lend12
Lend12:
	mov sp, r0
	pop r0
	rts
apagar_selecao:
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
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	call pos_para_idx
	mov r3, r7
	loadn r1, #3
	sub r1, r0, r1
	storei r1, r3
	loadn r1, #revelado_jogo
	loadn r2, #3
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #1
	mul r2, r2, r3
	add r1, r1, r2
	loadi r1, r1
	loadn r2, #50
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L62
	loadn r1, #70
	loadn r2, #768
	add r1, r1, r2
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #40
	mul r2, r2, r3
	loadn r3, #1
	sub r3, r0, r3
	loadi r3, r3
	add r2, r2, r3
	outchar r1, r2
	jmp L63
L62:
	loadn r1, #revelado_jogo
	loadn r2, #3
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #1
	mul r2, r2, r3
	add r1, r1, r2
	loadi r1, r1
	loadn r2, #49
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L64
	loadn r1, #mapa_jogo
	loadn r2, #3
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #1
	mul r2, r2, r3
	add r1, r1, r2
	loadi r1, r1
	loadn r2, #48
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L66
	loadn r1, #32
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #40
	mul r2, r2, r3
	loadn r3, #1
	sub r3, r0, r3
	loadi r3, r3
	add r2, r2, r3
	outchar r1, r2
	jmp L67
L66:
	loadn r1, #mapa_jogo
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
	loadn r3, #40
	mul r2, r2, r3
	loadn r3, #1
	sub r3, r0, r3
	loadi r3, r3
	add r2, r2, r3
	outchar r1, r2
L67:
	jmp L65
L64:
	loadn r1, #42
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #40
	mul r2, r2, r3
	loadn r3, #1
	sub r3, r0, r3
	loadi r3, r3
	add r2, r2, r3
	outchar r1, r2
L65:
L63:
	loadn r1, #0
	mov r7, r1
	jmp Lend13
Lend13:
	mov sp, r0
	pop r0
	rts
menu:
	call clearScreen
	mov r1, r7
	loadn r1, #str11
	loadn r2, #3
	loadn r3, #40
	mul r2, r2, r3
	loadn r3, #14
	add r2, r2, r3
	call print_str
	mov r3, r7
	loadn r1, #str12
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
	loadn r1, #0
	mov r7, r1
	jmp Lend14
Lend14:
	rts
printar_tabuleiro:
	push r0
	mov r0, sp
	loadn r7, #4
	sub r7, r0, r7
	mov sp, r7
	loadn r1, #8
	loadn r2, #2
	sub r2, r0, r2
	storei r2, r1
L68:
	loadn r1, #2
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #22
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #2
	and r1, r1, r7
	jz L69
	loadn r1, #10
	loadn r2, #1
	sub r2, r0, r2
	storei r2, r1
L71:
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #29
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #2
	and r1, r1, r7
	jz L72
	loadn r1, #2
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #40
	mul r1, r1, r2
	loadn r2, #1
	sub r2, r0, r2
	loadi r2, r2
	add r1, r1, r2
	loadn r2, #3
	sub r2, r0, r2
	storei r2, r1
	loadn r1, #0
	loadn r2, #3
	sub r2, r0, r2
	loadi r2, r2
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #6
	and r1, r1, r7
	jz L74
	loadn r1, #3
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #1200
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #2
	and r1, r1, r7
	jz L75
	loadn r1, #42
	loadn r2, #3
	sub r2, r0, r2
	loadi r2, r2
	outchar r1, r2
L75:
L74:
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #1
	add r1, r1, r2
	loadn r2, #1
	sub r2, r0, r2
	storei r2, r1
	jmp L71
L72:
L73:
	loadn r1, #2
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #1
	add r1, r1, r2
	loadn r2, #2
	sub r2, r0, r2
	storei r2, r1
	jmp L68
L69:
L70:
	loadn r1, #0
	mov r7, r1
	jmp Lend15
Lend15:
	mov sp, r0
	pop r0
	rts
printYoulostScreen:
	call clearScreen
	mov r1, r7
	loadn r1, #2310
	loadn r2, #2
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #6
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #10
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #11
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #12
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #41
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #42
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #45
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #46
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #47
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #48
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #49
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #50
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #80
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #81
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #82
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #83
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #85
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #86
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #87
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #121
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #122
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #123
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #124
	outchar r1, r2
	loadn r1, #2314
	loadn r2, #130
	outchar r1, r2
	loadn r1, #2350
	loadn r2, #131
	outchar r1, r2
	loadn r1, #2347
	loadn r2, #132
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #133
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #134
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #135
	outchar r1, r2
	loadn r1, #2350
	loadn r2, #136
	outchar r1, r2
	loadn r1, #2350
	loadn r2, #137
	outchar r1, r2
	loadn r1, #2350
	loadn r2, #138
	outchar r1, r2
	loadn r1, #2350
	loadn r2, #139
	outchar r1, r2
	loadn r1, #2348
	loadn r2, #140
	outchar r1, r2
	loadn r1, #2348
	loadn r2, #141
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #142
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #143
	outchar r1, r2
	loadn r1, #2347
	loadn r2, #144
	outchar r1, r2
	loadn r1, #2350
	loadn r2, #145
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #160
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #161
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #162
	outchar r1, r2
	loadn r1, #2350
	loadn r2, #169
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #170
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #171
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #172
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #173
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #174
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #175
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #176
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #177
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #178
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #179
	outchar r1, r2
	loadn r1, #2319
	loadn r2, #185
	outchar r1, r2
	loadn r1, #2398
	loadn r2, #186
	outchar r1, r2
	loadn r1, #2398
	loadn r2, #187
	outchar r1, r2
	loadn r1, #2350
	loadn r2, #188
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #200
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #201
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #207
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #208
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #209
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #210
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #211
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #212
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #213
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #214
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #215
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #216
	outchar r1, r2
	loadn r1, #2320
	loadn r2, #228
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #229
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #230
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #241
	outchar r1, r2
	loadn r1, #2323
	loadn r2, #245
	outchar r1, r2
	loadn r1, #2399
	loadn r2, #246
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #247
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #248
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #249
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #250
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #251
	outchar r1, r2
	loadn r1, #2319
	loadn r2, #254
	outchar r1, r2
	loadn r1, #2399
	loadn r2, #271
	outchar r1, r2
	loadn r1, #2427
	loadn r2, #285
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #286
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #287
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #288
	outchar r1, r2
	loadn r1, #2319
	loadn r2, #294
	outchar r1, r2
	loadn r1, #2319
	loadn r2, #300
	outchar r1, r2
	loadn r1, #2429
	loadn r2, #312
	outchar r1, r2
	loadn r1, #2314
	loadn r2, #321
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #325
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #326
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #327
	outchar r1, r2
	loadn r1, #2390
	loadn r2, #333
	outchar r1, r2
	loadn r1, #2383
	loadn r2, #334
	outchar r1, r2
	loadn r1, #2371
	loadn r2, #335
	outchar r1, r2
	loadn r1, #2373
	loadn r2, #336
	outchar r1, r2
	loadn r1, #2384
	loadn r2, #338
	outchar r1, r2
	loadn r1, #2373
	loadn r2, #339
	outchar r1, r2
	loadn r1, #2386
	loadn r2, #340
	outchar r1, r2
	loadn r1, #2372
	loadn r2, #341
	outchar r1, r2
	loadn r1, #2373
	loadn r2, #342
	outchar r1, r2
	loadn r1, #2389
	loadn r2, #343
	outchar r1, r2
	loadn r1, #2337
	loadn r2, #344
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #352
	outchar r1, r2
	loadn r1, #2314
	loadn r2, #361
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #365
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #366
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #392
	outchar r1, r2
	loadn r1, #2314
	loadn r2, #400
	outchar r1, r2
	loadn r1, #2396
	loadn r2, #406
	outchar r1, r2
	loadn r1, #2351
	loadn r2, #431
	outchar r1, r2
	loadn r1, #2314
	loadn r2, #440
	outchar r1, r2
	loadn r1, #2396
	loadn r2, #446
	outchar r1, r2
	loadn r1, #2350
	loadn r2, #470
	outchar r1, r2
	loadn r1, #2351
	loadn r2, #471
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #487
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #488
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #508
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #509
	outchar r1, r2
	loadn r1, #2400
	loadn r2, #529
	outchar r1, r2
	loadn r1, #2400
	loadn r2, #530
	outchar r1, r2
	loadn r1, #2400
	loadn r2, #531
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #533
	outchar r1, r2
	loadn r1, #2350
	loadn r2, #538
	outchar r1, r2
	loadn r1, #2350
	loadn r2, #540
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #545
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #546
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #547
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #572
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #573
	outchar r1, r2
	loadn r1, #2350
	loadn r2, #574
	outchar r1, r2
	loadn r1, #2350
	loadn r2, #576
	outchar r1, r2
	loadn r1, #2348
	loadn r2, #578
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #580
	outchar r1, r2
	loadn r1, #2324
	loadn r2, #581
	outchar r1, r2
	loadn r1, #2350
	loadn r2, #582
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #583
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #584
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #615
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #617
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #621
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #655
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #657
	outchar r1, r2
	loadn r1, #2318
	loadn r2, #659
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #661
	outchar r1, r2
	loadn r1, #2350
	loadn r2, #692
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #693
	outchar r1, r2
	loadn r1, #2365
	loadn r2, #694
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #695
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #696
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #699
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #701
	outchar r1, r2
	loadn r1, #2365
	loadn r2, #702
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #703
	outchar r1, r2
	loadn r1, #2350
	loadn r2, #704
	outchar r1, r2
	loadn r1, #2400
	loadn r2, #731
	outchar r1, r2
	loadn r1, #2314
	loadn r2, #732
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #735
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #736
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #739
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #741
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #744
	outchar r1, r2
	loadn r1, #2400
	loadn r2, #772
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #773
	outchar r1, r2
	loadn r1, #2365
	loadn r2, #774
	outchar r1, r2
	loadn r1, #2339
	loadn r2, #775
	outchar r1, r2
	loadn r1, #2340
	loadn r2, #776
	outchar r1, r2
	loadn r1, #2341
	loadn r2, #777
	outchar r1, r2
	loadn r1, #2342
	loadn r2, #778
	outchar r1, r2
	loadn r1, #2341
	loadn r2, #779
	outchar r1, r2
	loadn r1, #2340
	loadn r2, #780
	outchar r1, r2
	loadn r1, #2339
	loadn r2, #781
	outchar r1, r2
	loadn r1, #2365
	loadn r2, #782
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #783
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #815
	outchar r1, r2
	loadn r1, #2312
	loadn r2, #820
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #821
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #855
	outchar r1, r2
	loadn r1, #2363
	loadn r2, #857
	outchar r1, r2
	loadn r1, #2362
	loadn r2, #860
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #861
	outchar r1, r2
	loadn r1, #2399
	loadn r2, #886
	outchar r1, r2
	loadn r1, #2399
	loadn r2, #887
	outchar r1, r2
	loadn r1, #2399
	loadn r2, #888
	outchar r1, r2
	loadn r1, #2399
	loadn r2, #889
	outchar r1, r2
	loadn r1, #2399
	loadn r2, #890
	outchar r1, r2
	loadn r1, #2350
	loadn r2, #891
	outchar r1, r2
	loadn r1, #2348
	loadn r2, #892
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #893
	outchar r1, r2
	loadn r1, #2339
	loadn r2, #894
	outchar r1, r2
	loadn r1, #2341
	loadn r2, #895
	outchar r1, r2
	loadn r1, #2342
	loadn r2, #896
	outchar r1, r2
	loadn r1, #2340
	loadn r2, #897
	outchar r1, r2
	loadn r1, #2368
	loadn r2, #898
	outchar r1, r2
	loadn r1, #2341
	loadn r2, #899
	outchar r1, r2
	loadn r1, #2339
	loadn r2, #900
	outchar r1, r2
	loadn r1, #2342
	loadn r2, #901
	outchar r1, r2
	loadn r1, #2339
	loadn r2, #902
	outchar r1, r2
	loadn r1, #2430
	loadn r2, #903
	outchar r1, r2
	loadn r1, #2348
	loadn r2, #904
	outchar r1, r2
	loadn r1, #2350
	loadn r2, #905
	outchar r1, r2
	loadn r1, #2399
	loadn r2, #906
	outchar r1, r2
	loadn r1, #2399
	loadn r2, #907
	outchar r1, r2
	loadn r1, #2399
	loadn r2, #908
	outchar r1, r2
	loadn r1, #2399
	loadn r2, #909
	outchar r1, r2
	loadn r1, #2399
	loadn r2, #910
	outchar r1, r2
	loadn r1, #2319
	loadn r2, #969
	outchar r1, r2
	loadn r1, #2319
	loadn r2, #970
	outchar r1, r2
	loadn r1, #2319
	loadn r2, #971
	outchar r1, r2
	loadn r1, #2319
	loadn r2, #972
	outchar r1, r2
	loadn r1, #2319
	loadn r2, #974
	outchar r1, r2
	loadn r1, #2319
	loadn r2, #975
	outchar r1, r2
	loadn r1, #2319
	loadn r2, #976
	outchar r1, r2
	loadn r1, #2319
	loadn r2, #977
	outchar r1, r2
	loadn r1, #2319
	loadn r2, #979
	outchar r1, r2
	loadn r1, #16
	loadn r2, #1046
	outchar r1, r2
	loadn r1, #25
	loadn r2, #1047
	outchar r1, r2
	loadn r1, #25
	loadn r2, #1048
	outchar r1, r2
	loadn r1, #25
	loadn r2, #1049
	outchar r1, r2
	loadn r1, #25
	loadn r2, #1050
	outchar r1, r2
	loadn r1, #25
	loadn r2, #1051
	outchar r1, r2
	loadn r1, #25
	loadn r2, #1052
	outchar r1, r2
	loadn r1, #25
	loadn r2, #1053
	outchar r1, r2
	loadn r1, #25
	loadn r2, #1054
	outchar r1, r2
	loadn r1, #25
	loadn r2, #1055
	outchar r1, r2
	loadn r1, #25
	loadn r2, #1056
	outchar r1, r2
	loadn r1, #25
	loadn r2, #1057
	outchar r1, r2
	loadn r1, #16
	loadn r2, #1058
	outchar r1, r2
	loadn r1, #526
	loadn r2, #1059
	outchar r1, r2
	loadn r1, #25
	loadn r2, #1060
	outchar r1, r2
	loadn r1, #25
	loadn r2, #1061
	outchar r1, r2
	loadn r1, #25
	loadn r2, #1062
	outchar r1, r2
	loadn r1, #25
	loadn r2, #1063
	outchar r1, r2
	loadn r1, #2327
	loadn r2, #1064
	outchar r1, r2
	loadn r1, #11
	loadn r2, #1065
	outchar r1, r2
	loadn r1, #11
	loadn r2, #1066
	outchar r1, r2
	loadn r1, #11
	loadn r2, #1067
	outchar r1, r2
	loadn r1, #11
	loadn r2, #1068
	outchar r1, r2
	loadn r1, #11
	loadn r2, #1069
	outchar r1, r2
	loadn r1, #11
	loadn r2, #1070
	outchar r1, r2
	loadn r1, #521
	loadn r2, #1087
	outchar r1, r2
	loadn r1, #521
	loadn r2, #1088
	outchar r1, r2
	loadn r1, #521
	loadn r2, #1089
	outchar r1, r2
	loadn r1, #592
	loadn r2, #1090
	outchar r1, r2
	loadn r1, #594
	loadn r2, #1091
	outchar r1, r2
	loadn r1, #581
	loadn r2, #1092
	outchar r1, r2
	loadn r1, #595
	loadn r2, #1093
	outchar r1, r2
	loadn r1, #595
	loadn r2, #1094
	outchar r1, r2
	loadn r1, #585
	loadn r2, #1095
	outchar r1, r2
	loadn r1, #591
	loadn r2, #1096
	outchar r1, r2
	loadn r1, #590
	loadn r2, #1097
	outchar r1, r2
	loadn r1, #581
	loadn r2, #1098
	outchar r1, r2
	loadn r1, #526
	loadn r2, #1099
	outchar r1, r2
	loadn r1, #526
	loadn r2, #1100
	outchar r1, r2
	loadn r1, #526
	loadn r2, #1101
	outchar r1, r2
	loadn r1, #526
	loadn r2, #1102
	outchar r1, r2
	loadn r1, #2319
	loadn r2, #1129
	outchar r1, r2
	loadn r1, #2319
	loadn r2, #1130
	outchar r1, r2
	loadn r1, #581
	loadn r2, #1131
	outchar r1, r2
	loadn r1, #595
	loadn r2, #1132
	outchar r1, r2
	loadn r1, #592
	loadn r2, #1133
	outchar r1, r2
	loadn r1, #577
	loadn r2, #1134
	outchar r1, r2
	loadn r1, #579
	loadn r2, #1135
	outchar r1, r2
	loadn r1, #591
	loadn r2, #1136
	outchar r1, r2
	loadn r1, #2319
	loadn r2, #1137
	outchar r1, r2
	loadn r1, #2319
	loadn r2, #1175
	outchar r1, r2
	loadn r1, #0
	mov r7, r1
	jmp Lend16
Lend16:
	rts
main:
	push r0
	mov r0, sp
	loadn r7, #8
	sub r7, r0, r7
	mov sp, r7
	loadn r1, #42
	loadn r2, #7
	sub r2, r0, r2
	storei r2, r1
L76:
	loadn r1, #1
	loadn r2, #1
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L77
	call menu
	mov r1, r7
	loadn r1, #7
	sub r1, r0, r1
	loadi r1, r1
	call make_tabuleiro
	mov r2, r7
	call printar_tabuleiro
	mov r1, r7
	loadn r1, #10
	loadn r2, #1
	sub r2, r0, r2
	storei r2, r1
	loadn r1, #8
	loadn r2, #2
	sub r2, r0, r2
	storei r2, r1
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	call printar_selecao
	mov r3, r7
	loadn r1, #str13
	loadn r2, #0
	call print_str
	mov r3, r7
	loadn r1, #total_bombas
	loadi r1, r1
	loadn r2, #8
	call printNum2
	mov r3, r7
	loadn r1, #0
	loadn r2, #5
	sub r2, r0, r2
	storei r2, r1
	loadn r1, #255
	loadn r2, #4
	sub r2, r0, r2
	storei r2, r1
L79:
	loadn r1, #5
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #0
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L80
	inchar r1
	loadn r2, #3
	sub r2, r0, r2
	storei r2, r1
	loadn r1, #3
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #255
	cmp r1, r2
	push fr
	pop r1
	not r1, r1
	loadn r7, #4
	and r1, r1, r7
	jz L82
	loadn r1, #3
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #4
	sub r2, r0, r2
	loadi r2, r2
	cmp r1, r2
	push fr
	pop r1
	not r1, r1
	loadn r7, #4
	and r1, r1, r7
	jz L83
	loadn r1, #3
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #39
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L87
	loadn r1, #1
	jmp L88
L87:
	loadn r2, #3
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #100
	cmp r2, r3
	push fr
	pop r2
	loadn r7, #4
	and r2, r2, r7
	mov r1, r2
	jz L88
	loadn r1, #1
L88:
	jz L85
	loadn r1, #1
	jmp L86
L85:
	loadn r2, #3
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #68
	cmp r2, r3
	push fr
	pop r2
	loadn r7, #4
	and r2, r2, r7
	mov r1, r2
	jz L86
	loadn r1, #1
L86:
	jz L84
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #29
	loadn r3, #1
	sub r2, r2, r3
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #2
	and r1, r1, r7
	jz L89
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	call apagar_selecao
	mov r3, r7
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #1
	add r1, r1, r2
	loadn r2, #1
	sub r2, r0, r2
	storei r2, r1
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	call printar_selecao
	mov r3, r7
L89:
L84:
	loadn r1, #3
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #37
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L93
	loadn r1, #1
	jmp L94
L93:
	loadn r2, #3
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #97
	cmp r2, r3
	push fr
	pop r2
	loadn r7, #4
	and r2, r2, r7
	mov r1, r2
	jz L94
	loadn r1, #1
L94:
	jz L91
	loadn r1, #1
	jmp L92
L91:
	loadn r2, #3
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #65
	cmp r2, r3
	push fr
	pop r2
	loadn r7, #4
	and r2, r2, r7
	mov r1, r2
	jz L92
	loadn r1, #1
L92:
	jz L90
	loadn r1, #10
	loadn r2, #1
	sub r2, r0, r2
	loadi r2, r2
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #2
	and r1, r1, r7
	jz L95
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	call apagar_selecao
	mov r3, r7
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #1
	sub r1, r1, r2
	loadn r2, #1
	sub r2, r0, r2
	storei r2, r1
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	call printar_selecao
	mov r3, r7
L95:
L90:
	loadn r1, #3
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #38
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L99
	loadn r1, #1
	jmp L100
L99:
	loadn r2, #3
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #119
	cmp r2, r3
	push fr
	pop r2
	loadn r7, #4
	and r2, r2, r7
	mov r1, r2
	jz L100
	loadn r1, #1
L100:
	jz L97
	loadn r1, #1
	jmp L98
L97:
	loadn r2, #3
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #87
	cmp r2, r3
	push fr
	pop r2
	loadn r7, #4
	and r2, r2, r7
	mov r1, r2
	jz L98
	loadn r1, #1
L98:
	jz L96
	loadn r1, #8
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #2
	and r1, r1, r7
	jz L101
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	call apagar_selecao
	mov r3, r7
	loadn r1, #2
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #1
	sub r1, r1, r2
	loadn r2, #2
	sub r2, r0, r2
	storei r2, r1
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	call printar_selecao
	mov r3, r7
L101:
L96:
	loadn r1, #3
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #40
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L105
	loadn r1, #1
	jmp L106
L105:
	loadn r2, #3
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #115
	cmp r2, r3
	push fr
	pop r2
	loadn r7, #4
	and r2, r2, r7
	mov r1, r2
	jz L106
	loadn r1, #1
L106:
	jz L103
	loadn r1, #1
	jmp L104
L103:
	loadn r2, #3
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #83
	cmp r2, r3
	push fr
	pop r2
	loadn r7, #4
	and r2, r2, r7
	mov r1, r2
	jz L104
	loadn r1, #1
L104:
	jz L102
	loadn r1, #2
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #22
	loadn r3, #1
	sub r2, r2, r3
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #2
	and r1, r1, r7
	jz L107
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	call apagar_selecao
	mov r3, r7
	loadn r1, #2
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #1
	add r1, r1, r2
	loadn r2, #2
	sub r2, r0, r2
	storei r2, r1
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	call printar_selecao
	mov r3, r7
L107:
L102:
	loadn r1, #3
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #13
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L108
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	call pos_para_idx
	mov r3, r7
	loadn r1, #6
	sub r1, r0, r1
	storei r1, r3
	loadn r1, #revelado_jogo
	loadn r2, #6
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #1
	mul r2, r2, r3
	add r1, r1, r2
	loadi r1, r1
	loadn r2, #48
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L109
	loadn r1, #mapa_jogo
	loadn r2, #6
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #1
	mul r2, r2, r3
	add r1, r1, r2
	loadi r1, r1
	loadn r2, #57
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L110
	loadn r1, #49
	loadn r2, #revelado_jogo
	loadn r3, #6
	sub r3, r0, r3
	loadi r3, r3
	loadn r4, #1
	mul r3, r3, r4
	add r2, r2, r3
	storei r2, r1
	loadn r1, #57
	loadn r2, #7936
	add r1, r1, r2
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #40
	mul r2, r2, r3
	loadn r3, #1
	sub r3, r0, r3
	loadi r3, r3
	add r2, r2, r3
	outchar r1, r2
	loadn r1, #2
	loadn r2, #5
	sub r2, r0, r2
	storei r2, r1
	jmp L111
L110:
	loadn r1, #6
	sub r1, r0, r1
	loadi r1, r1
	call revelar_recursivo
	mov r2, r7
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	call printar_selecao
	mov r3, r7
	loadn r1, #celulas_reveladas
	loadi r1, r1
	loadn r2, #266
	loadn r3, #total_bombas
	loadi r3, r3
	sub r2, r2, r3
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L112
	loadn r1, #1
	loadn r2, #5
	sub r2, r0, r2
	storei r2, r1
L112:
L111:
L109:
L108:
	loadn r1, #3
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #102
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L114
	loadn r1, #1
	jmp L115
L114:
	loadn r2, #3
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #70
	cmp r2, r3
	push fr
	pop r2
	loadn r7, #4
	and r2, r2, r7
	mov r1, r2
	jz L115
	loadn r1, #1
L115:
	jz L113
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	call pos_para_idx
	mov r3, r7
	loadn r1, #6
	sub r1, r0, r1
	storei r1, r3
	loadn r1, #6
	sub r1, r0, r1
	loadi r1, r1
	call alternar_bandeira
	mov r2, r7
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	call printar_selecao
	mov r3, r7
L113:
	loadn r1, #3
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #113
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L117
	loadn r1, #1
	jmp L118
L117:
	loadn r2, #3
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #81
	cmp r2, r3
	push fr
	pop r2
	loadn r7, #4
	and r2, r2, r7
	mov r1, r2
	jz L118
	loadn r1, #1
L118:
	jz L116
	loadn r1, #3
	loadn r2, #5
	sub r2, r0, r2
	storei r2, r1
L116:
L83:
L82:
	loadn r1, #3
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #4
	sub r2, r0, r2
	storei r2, r1
	jmp L79
L80:
L81:
	loadn r1, #5
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #1
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L119
	loadn r1, #str14
	loadn r2, #29
	loadn r3, #40
	mul r2, r2, r3
	loadn r3, #8
	add r2, r2, r3
	call print_str
	mov r3, r7
	jmp L120
L119:
	loadn r1, #5
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #2
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L121
	call printYoulostScreen
	mov r1, r7
	jmp L122
L121:
	loadn r1, #str15
	loadn r2, #29
	loadn r3, #40
	mul r2, r2, r3
	loadn r3, #8
	add r2, r2, r3
	call print_str
	mov r3, r7
L122:
L120:
	loadn r1, #7
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #5
	add r1, r1, r2
	loadn r2, #7
	sub r2, r0, r2
	storei r2, r1
	call espera_espaco
	mov r1, r7
	jmp L76
L77:
L78:
	loadn r1, #0
	mov r7, r1
	jmp Lend17
Lend17:
	mov sp, r0
	pop r0
	rts
mapa_jogo : var #266
revelado_jogo : var #266
semente_rand : var #1
dir_x : var #8
dir_y : var #8
total_bombas : var #1
bandeiras_restantes : var #1
celulas_reveladas : var #1
str0 : string "_ -^^---....,,--"
str1 : string " --               --"
str2 : string "<                   >)"
str3 : string "|                   |"
str4 : string " \\_               _/"
str5 : string "   ```-- . , ; .--'''"
str6 : string "        | |  |"
str7 : string "      .-=||  ||=-."
str8 : string "      `-=#$%&%$#=-'"
str9 : string "        | ;  :|"
str10 : string "  __.,-#%&$@%#&#~,.__"
str11 : string "CAMPO MINADO"
str12 : string "PRESSIONE ESPACO PARA JOGAR"
str13 : string "BOMBAS: "
str14 : string "VOCE VENCEU!  ESPACO"
str15 : string "DESISTIU.     ESPACO"
jz L31
	loadn r1, #0
	loadn r2, #9
	sub r2, r0, r2
	loadi r2, r2
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #6
	and r1, r1, r7
	jz L32
	loadn r1, #9
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #14
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #2
	and r1, r1, r7
	jz L33
	loadn r1, #9
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #19
	mul r1, r1, r2
	loadn r2, #8
	sub r2, r0, r2
	loadi r2, r2
	add r1, r1, r2
	loadn r2, #10
	sub r2, r0, r2
	storei r2, r1
	loadn r1, #mapa_jogo
	loadn r2, #10
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #1
	mul r2, r2, r3
	add r1, r1, r2
	loadi r1, r1
	loadn r2, #57
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L34
	loadn r1, #11
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #1
	add r1, r1, r2
	loadn r2, #11
	sub r2, r0, r2
	storei r2, r1
L34:
L33:
L32:
L31:
L30:
	loadn r1, #7
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #1
	add r1, r1, r2
	loadn r2, #7
	sub r2, r0, r2
	storei r2, r1
	jmp L27
L28:
L29:
	loadn r1, #48
	loadn r2, #11
	sub r2, r0, r2
	loadi r2, r2
	add r1, r1, r2
	loadn r2, #mapa_jogo
	loadn r3, #2
	sub r3, r0, r3
	loadi r3, r3
	loadn r4, #1
	mul r3, r3, r4
	add r2, r2, r3
	storei r2, r1
L26:
	loadn r1, #5
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #1
	add r1, r1, r2
	loadn r2, #5
	sub r2, r0, r2
	storei r2, r1
	loadn r1, #19
	loadn r2, #5
	sub r2, r0, r2
	loadi r2, r2
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #6
	and r1, r1, r7
	jz L35
	loadn r1, #0
	loadn r2, #5
	sub r2, r0, r2
	storei r2, r1
	loadn r1, #6
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #1
	add r1, r1, r2
	loadn r2, #6
	sub r2, r0, r2
	storei r2, r1
L35:
	loadn r1, #2
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #1
	add r1, r1, r2
	loadn r2, #2
	sub r2, r0, r2
	storei r2, r1
	jmp L23
L24:
L25:
	loadn r1, #0
	mov r7, r1
	jmp Lend7
Lend7:
	mov sp, r0
	pop r0
	rts
rand:
	loadn r1, #semente_rand
	loadi r1, r1
	loadn r2, #13
	mul r1, r1, r2
	loadn r2, #7
	add r1, r1, r2
	loadn r2, #semente_rand
	storei r2, r1
	loadn r1, #semente_rand
	loadi r1, r1
	loadn r2, #0
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #2
	and r1, r1, r7
	jz L36
	loadn r1, #semente_rand
	loadi r1, r1
	loadn r2, #1
	not r2, r2
	inc r2
	mul r1, r1, r2
	loadn r2, #semente_rand
	storei r2, r1
L36:
	loadn r1, #semente_rand
	loadi r1, r1
	mov r7, r1
	jmp Lend8
Lend8:
	rts
rand_pos:
	push r0
	mov r0, sp
	loadn r7, #2
	sub r7, r0, r7
	mov sp, r7
	call rand
	mov r1, r7
	loadn r2, #1
	sub r2, r0, r2
	storei r2, r1
L37:
	loadn r1, #2660
	loadn r2, #1
	sub r2, r0, r2
	loadi r2, r2
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #6
	and r1, r1, r7
	jz L38
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #2660
	sub r1, r1, r2
	loadn r2, #1
	sub r2, r0, r2
	storei r2, r1
	jmp L37
L38:
L39:
L40:
	loadn r1, #266
	loadn r2, #1
	sub r2, r0, r2
	loadi r2, r2
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #6
	and r1, r1, r7
	jz L41
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #266
	sub r1, r1, r2
	loadn r2, #1
	sub r2, r0, r2
	storei r2, r1
	jmp L40
L41:
L42:
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	mov r7, r1
	jmp Lend9
Lend9:
	mov sp, r0
	pop r0
	rts
revelar_recursivo:
	push r0
	mov r0, sp
	loadn r7, #6
	sub r7, r0, r7
	mov sp, r7
	loadn r7, #1
	sub r7, r0, r7
	storei r7, r1
	loadn r1, #revelado_jogo
	loadn r2, #1
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #1
	mul r2, r2, r3
	add r1, r1, r2
	loadi r1, r1
	loadn r2, #49
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L43
	loadn r1, #0
	mov r7, r1
	jmp Lend10
L43:
	loadn r1, #revelado_jogo
	loadn r2, #1
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #1
	mul r2, r2, r3
	add r1, r1, r2
	loadi r1, r1
	loadn r2, #50
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L44
	loadn r1, #0
	mov r7, r1
	jmp Lend10
L44:
	loadn r1, #49
	loadn r2, #revelado_jogo
	loadn r3, #1
	sub r3, r0, r3
	loadi r3, r3
	loadn r4, #1
	mul r3, r3, r4
	add r2, r2, r3
	storei r2, r1
	loadn r1, #celulas_reveladas
	loadi r1, r1
	loadn r2, #1
	add r1, r1, r2
	loadn r2, #celulas_reveladas
	storei r2, r1
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #2
	sub r2, r0, r2
	storei r2, r1
	loadn r1, #0
	loadn r2, #3
	sub r2, r0, r2
	storei r2, r1
L45:
	loadn r1, #19
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #6
	and r1, r1, r7
	jz L46
	loadn r1, #2
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #19
	sub r1, r1, r2
	loadn r2, #2
	sub r2, r0, r2
	storei r2, r1
	loadn r1, #3
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #1
	add r1, r1, r2
	loadn r2, #3
	sub r2, r0, r2
	storei r2, r1
	jmp L45
L46:
L47:
	loadn r1, #mapa_jogo
	loadn r2, #1
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #1
	mul r2, r2, r3
	add r1, r1, r2
	loadi r1, r1
	loadn r2, #48
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L48
	loadn r1, #32
	loadn r2, #3
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #8
	add r2, r2, r3
	loadn r3, #40
	mul r2, r2, r3
	loadn r3, #2
	sub r3, r0, r3
	loadi r3, r3
	add r2, r2, r3
	loadn r3, #10
	add r2, r2, r3
	outchar r1, r2
	jmp L49
L48:
	loadn r1, #mapa_jogo
	loadn r2, #1
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #1
	mul r2, r2, r3
	add r1, r1, r2
	loadi r1, r1
	loadn r2, #3
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #8
	add r2, r2, r3
	loadn r3, #40
	mul r2, r2, r3
	loadn r3, #2
	sub r3, r0, r3
	loadi r3, r3
	add r2, r2, r3
	loadn r3, #10
	add r2, r2, r3
	outchar r1, r2
L49:
	loadn r1, #mapa_jogo
	loadn r2, #1
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #1
	mul r2, r2, r3
	add r1, r1, r2
	loadi r1, r1
	loadn r2, #48
	cmp r1, r2
	push fr
	pop r1
	not r1, r1
	loadn r7, #4
	and r1, r1, r7
	jz L50
	loadn r1, #0
	mov r7, r1
	jmp Lend10
L50:
	loadn r1, #0
	loadn r2, #4
	sub r2, r0, r2
	storei r2, r1
L51:
	loadn r1, #4
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #8
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #2
	and r1, r1, r7
	jz L52
	loadn r1, #0
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #dir_x
	loadn r4, #4
	sub r4, r0, r4
	loadi r4, r4
	loadn r5, #1
	mul r4, r4, r5
	add r3, r3, r4
	loadi r3, r3
	add r2, r2, r3
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #6
	and r1, r1, r7
	jz L54
	loadn r1, #2
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #dir_x
	loadn r3, #4
	sub r3, r0, r3
	loadi r3, r3
	loadn r4, #1
	mul r3, r3, r4
	add r2, r2, r3
	loadi r2, r2
	add r1, r1, r2
	loadn r2, #19
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #2
	and r1, r1, r7
	jz L55
	loadn r1, #0
	loadn r2, #3
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #dir_y
	loadn r4, #4
	sub r4, r0, r4
	loadi r4, r4
	loadn r5, #1
	mul r4, r4, r5
	add r3, r3, r4
	loadi r3, r3
	add r2, r2, r3
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #6
	and r1, r1, r7
	jz L56
	loadn r1, #3
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #dir_y
	loadn r3, #4
	sub r3, r0, r3
	loadi r3, r3
	loadn r4, #1
	mul r3, r3, r4
	add r2, r2, r3
	loadi r2, r2
	add r1, r1, r2
	loadn r2, #14
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #2
	and r1, r1, r7
	jz L57
	loadn r1, #3
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #dir_y
	loadn r3, #4
	sub r3, r0, r3
	loadi r3, r3
	loadn r4, #1
	mul r3, r3, r4
	add r2, r2, r3
	loadi r2, r2
	add r1, r1, r2
	loadn r2, #19
	mul r1, r1, r2
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	add r1, r1, r2
	loadn r2, #dir_x
	loadn r3, #4
	sub r3, r0, r3
	loadi r3, r3
	loadn r4, #1
	mul r3, r3, r4
	add r2, r2, r3
	loadi r2, r2
	add r1, r1, r2
	loadn r2, #5
	sub r2, r0, r2
	storei r2, r1
	loadn r1, #5
	sub r1, r0, r1
	loadi r1, r1
	call revelar_recursivo
	mov r2, r7
L57:
L56:
L55:
L54:
	loadn r1, #4
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #1
	add r1, r1, r2
	loadn r2, #4
	sub r2, r0, r2
	storei r2, r1
	jmp L51
L52:
L53:
	loadn r1, #0
	mov r7, r1
	jmp Lend10
Lend10:
	mov sp, r0
	pop r0
	rts
alternar_bandeira:
	push r0
	mov r0, sp
	loadn r7, #3
	sub r7, r0, r7
	mov sp, r7
	loadn r7, #1
	sub r7, r0, r7
	storei r7, r1
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	call idx_para_tela
	mov r2, r7
	loadn r1, #2
	sub r1, r0, r1
	storei r1, r2
	loadn r1, #revelado_jogo
	loadn r2, #1
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #1
	mul r2, r2, r3
	add r1, r1, r2
	loadi r1, r1
	loadn r2, #48
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L58
	loadn r1, #0
	loadn r2, #bandeiras_restantes
	loadi r2, r2
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #2
	and r1, r1, r7
	jz L60
	loadn r1, #50
	loadn r2, #revelado_jogo
	loadn r3, #1
	sub r3, r0, r3
	loadi r3, r3
	loadn r4, #1
	mul r3, r3, r4
	add r2, r2, r3
	storei r2, r1
	loadn r1, #bandeiras_restantes
	loadi r1, r1
	loadn r2, #1
	sub r1, r1, r2
	loadn r2, #bandeiras_restantes
	storei r2, r1
	loadn r1, #70
	loadn r2, #768
	add r1, r1, r2
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	outchar r1, r2
L60:
	jmp L59
L58:
	loadn r1, #revelado_jogo
	loadn r2, #1
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #1
	mul r2, r2, r3
	add r1, r1, r2
	loadi r1, r1
	loadn r2, #50
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L61
	loadn r1, #48
	loadn r2, #revelado_jogo
	loadn r3, #1
	sub r3, r0, r3
	loadi r3, r3
	loadn r4, #1
	mul r3, r3, r4
	add r2, r2, r3
	storei r2, r1
	loadn r1, #bandeiras_restantes
	loadi r1, r1
	loadn r2, #1
	add r1, r1, r2
	loadn r2, #bandeiras_restantes
	storei r2, r1
	loadn r1, #42
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	outchar r1, r2
L61:
L59:
	loadn r1, #0
	mov r7, r1
	jmp Lend11
Lend11:
	mov sp, r0
	pop r0
	rts
printar_selecao:
	push r0
	mov r0, sp
	loadn r7, #3
	sub r7, r0, r7
	mov sp, r7
	loadn r7, #1
	sub r7, r0, r7
	storei r7, r1
	loadn r7, #2
	sub r7, r0, r7
	storei r7, r2
	loadn r1, #42
	loadn r2, #7936
	add r1, r1, r2
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #40
	mul r2, r2, r3
	loadn r3, #1
	sub r3, r0, r3
	loadi r3, r3
	add r2, r2, r3
	outchar r1, r2
	loadn r1, #0
	mov r7, r1
	jmp Lend12
Lend12:
	mov sp, r0
	pop r0
	rts
apagar_selecao:
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
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	call pos_para_idx
	mov r3, r7
	loadn r1, #3
	sub r1, r0, r1
	storei r1, r3
	loadn r1, #revelado_jogo
	loadn r2, #3
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #1
	mul r2, r2, r3
	add r1, r1, r2
	loadi r1, r1
	loadn r2, #50
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L62
	loadn r1, #70
	loadn r2, #768
	add r1, r1, r2
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #40
	mul r2, r2, r3
	loadn r3, #1
	sub r3, r0, r3
	loadi r3, r3
	add r2, r2, r3
	outchar r1, r2
	jmp L63
L62:
	loadn r1, #revelado_jogo
	loadn r2, #3
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #1
	mul r2, r2, r3
	add r1, r1, r2
	loadi r1, r1
	loadn r2, #49
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L64
	loadn r1, #mapa_jogo
	loadn r2, #3
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #1
	mul r2, r2, r3
	add r1, r1, r2
	loadi r1, r1
	loadn r2, #48
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L66
	loadn r1, #32
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #40
	mul r2, r2, r3
	loadn r3, #1
	sub r3, r0, r3
	loadi r3, r3
	add r2, r2, r3
	outchar r1, r2
	jmp L67
L66:
	loadn r1, #mapa_jogo
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
	loadn r3, #40
	mul r2, r2, r3
	loadn r3, #1
	sub r3, r0, r3
	loadi r3, r3
	add r2, r2, r3
	outchar r1, r2
L67:
	jmp L65
L64:
	loadn r1, #42
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #40
	mul r2, r2, r3
	loadn r3, #1
	sub r3, r0, r3
	loadi r3, r3
	add r2, r2, r3
	outchar r1, r2
L65:
L63:
	loadn r1, #0
	mov r7, r1
	jmp Lend13
Lend13:
	mov sp, r0
	pop r0
	rts
menu:
	call clearScreen
	mov r1, r7
	loadn r1, #str11
	loadn r2, #3
	loadn r3, #40
	mul r2, r2, r3
	loadn r3, #14
	add r2, r2, r3
	call print_str
	mov r3, r7
	loadn r1, #str12
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
	loadn r1, #0
	mov r7, r1
	jmp Lend14
Lend14:
	rts
printar_tabuleiro:
	push r0
	mov r0, sp
	loadn r7, #4
	sub r7, r0, r7
	mov sp, r7
	loadn r1, #8
	loadn r2, #2
	sub r2, r0, r2
	storei r2, r1
L68:
	loadn r1, #2
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #22
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #2
	and r1, r1, r7
	jz L69
	loadn r1, #10
	loadn r2, #1
	sub r2, r0, r2
	storei r2, r1
L71:
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #29
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #2
	and r1, r1, r7
	jz L72
	loadn r1, #2
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #40
	mul r1, r1, r2
	loadn r2, #1
	sub r2, r0, r2
	loadi r2, r2
	add r1, r1, r2
	loadn r2, #3
	sub r2, r0, r2
	storei r2, r1
	loadn r1, #0
	loadn r2, #3
	sub r2, r0, r2
	loadi r2, r2
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #6
	and r1, r1, r7
	jz L74
	loadn r1, #3
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #1200
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #2
	and r1, r1, r7
	jz L75
	loadn r1, #42
	loadn r2, #3
	sub r2, r0, r2
	loadi r2, r2
	outchar r1, r2
L75:
L74:
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #1
	add r1, r1, r2
	loadn r2, #1
	sub r2, r0, r2
	storei r2, r1
	jmp L71
L72:
L73:
	loadn r1, #2
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #1
	add r1, r1, r2
	loadn r2, #2
	sub r2, r0, r2
	storei r2, r1
	jmp L68
L69:
L70:
	loadn r1, #0
	mov r7, r1
	jmp Lend15
Lend15:
	mov sp, r0
	pop r0
	rts
printYoulostScreen:
	call clearScreen
	mov r1, r7
	loadn r1, #2310
	loadn r2, #2
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #6
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #10
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #11
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #12
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #41
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #42
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #45
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #46
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #47
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #48
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #49
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #50
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #80
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #81
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #82
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #83
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #85
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #86
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #87
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #121
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #122
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #123
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #124
	outchar r1, r2
	loadn r1, #2314
	loadn r2, #130
	outchar r1, r2
	loadn r1, #2350
	loadn r2, #131
	outchar r1, r2
	loadn r1, #2347
	loadn r2, #132
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #133
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #134
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #135
	outchar r1, r2
	loadn r1, #2350
	loadn r2, #136
	outchar r1, r2
	loadn r1, #2350
	loadn r2, #137
	outchar r1, r2
	loadn r1, #2350
	loadn r2, #138
	outchar r1, r2
	loadn r1, #2350
	loadn r2, #139
	outchar r1, r2
	loadn r1, #2348
	loadn r2, #140
	outchar r1, r2
	loadn r1, #2348
	loadn r2, #141
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #142
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #143
	outchar r1, r2
	loadn r1, #2347
	loadn r2, #144
	outchar r1, r2
	loadn r1, #2350
	loadn r2, #145
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #160
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #161
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #162
	outchar r1, r2
	loadn r1, #2350
	loadn r2, #169
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #170
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #171
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #172
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #173
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #174
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #175
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #176
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #177
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #178
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #179
	outchar r1, r2
	loadn r1, #2319
	loadn r2, #185
	outchar r1, r2
	loadn r1, #2398
	loadn r2, #186
	outchar r1, r2
	loadn r1, #2398
	loadn r2, #187
	outchar r1, r2
	loadn r1, #2350
	loadn r2, #188
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #200
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #201
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #207
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #208
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #209
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #210
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #211
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #212
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #213
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #214
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #215
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #216
	outchar r1, r2
	loadn r1, #2320
	loadn r2, #228
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #229
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #230
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #241
	outchar r1, r2
	loadn r1, #2323
	loadn r2, #245
	outchar r1, r2
	loadn r1, #2399
	loadn r2, #246
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #247
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #248
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #249
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #250
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #251
	outchar r1, r2
	loadn r1, #2319
	loadn r2, #254
	outchar r1, r2
	loadn r1, #2399
	loadn r2, #271
	outchar r1, r2
	loadn r1, #2427
	loadn r2, #285
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #286
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #287
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #288
	outchar r1, r2
	loadn r1, #2319
	loadn r2, #294
	outchar r1, r2
	loadn r1, #2319
	loadn r2, #300
	outchar r1, r2
	loadn r1, #2429
	loadn r2, #312
	outchar r1, r2
	loadn r1, #2314
	loadn r2, #321
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #325
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #326
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #327
	outchar r1, r2
	loadn r1, #2390
	loadn r2, #333
	outchar r1, r2
	loadn r1, #2383
	loadn r2, #334
	outchar r1, r2
	loadn r1, #2371
	loadn r2, #335
	outchar r1, r2
	loadn r1, #2373
	loadn r2, #336
	outchar r1, r2
	loadn r1, #2384
	loadn r2, #338
	outchar r1, r2
	loadn r1, #2373
	loadn r2, #339
	outchar r1, r2
	loadn r1, #2386
	loadn r2, #340
	outchar r1, r2
	loadn r1, #2372
	loadn r2, #341
	outchar r1, r2
	loadn r1, #2373
	loadn r2, #342
	outchar r1, r2
	loadn r1, #2389
	loadn r2, #343
	outchar r1, r2
	loadn r1, #2337
	loadn r2, #344
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #352
	outchar r1, r2
	loadn r1, #2314
	loadn r2, #361
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #365
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #366
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #392
	outchar r1, r2
	loadn r1, #2314
	loadn r2, #400
	outchar r1, r2
	loadn r1, #2396
	loadn r2, #406
	outchar r1, r2
	loadn r1, #2351
	loadn r2, #431
	outchar r1, r2
	loadn r1, #2314
	loadn r2, #440
	outchar r1, r2
	loadn r1, #2396
	loadn r2, #446
	outchar r1, r2
	loadn r1, #2350
	loadn r2, #470
	outchar r1, r2
	loadn r1, #2351
	loadn r2, #471
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #487
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #488
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #508
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #509
	outchar r1, r2
	loadn r1, #2400
	loadn r2, #529
	outchar r1, r2
	loadn r1, #2400
	loadn r2, #530
	outchar r1, r2
	loadn r1, #2400
	loadn r2, #531
	outchar r1, r2
	loadn r1, #2310
	loadn r2, #533
	outchar r1, r2
	loadn r1, #2350
	loadn r2, #538
	outchar r1, r2
	loadn r1, #2350
	loadn r2, #540
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #545
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #546
	outchar r1, r2
	loadn r1, #2343
	loadn r2, #547
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #572
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #573
	outchar r1, r2
	loadn r1, #2350
	loadn r2, #574
	outchar r1, r2
	loadn r1, #2350
	loadn r2, #576
	outchar r1, r2
	loadn r1, #2348
	loadn r2, #578
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #580
	outchar r1, r2
	loadn r1, #2324
	loadn r2, #581
	outchar r1, r2
	loadn r1, #2350
	loadn r2, #582
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #583
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #584
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #615
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #617
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #621
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #655
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #657
	outchar r1, r2
	loadn r1, #2318
	loadn r2, #659
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #661
	outchar r1, r2
	loadn r1, #2350
	loadn r2, #692
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #693
	outchar r1, r2
	loadn r1, #2365
	loadn r2, #694
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #695
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #696
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #699
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #701
	outchar r1, r2
	loadn r1, #2365
	loadn r2, #702
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #703
	outchar r1, r2
	loadn r1, #2350
	loadn r2, #704
	outchar r1, r2
	loadn r1, #2400
	loadn r2, #731
	outchar r1, r2
	loadn r1, #2314
	loadn r2, #732
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #735
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #736
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #739
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #741
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #744
	outchar r1, r2
	loadn r1, #2400
	loadn r2, #772
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #773
	outchar r1, r2
	loadn r1, #2365
	loadn r2, #774
	outchar r1, r2
	loadn r1, #2339
	loadn r2, #775
	outchar r1, r2
	loadn r1, #2340
	loadn r2, #776
	outchar r1, r2
	loadn r1, #2341
	loadn r2, #777
	outchar r1, r2
	loadn r1, #2342
	loadn r2, #778
	outchar r1, r2
	loadn r1, #2341
	loadn r2, #779
	outchar r1, r2
	loadn r1, #2340
	loadn r2, #780
	outchar r1, r2
	loadn r1, #2339
	loadn r2, #781
	outchar r1, r2
	loadn r1, #2365
	loadn r2, #782
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #783
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #815
	outchar r1, r2
	loadn r1, #2312
	loadn r2, #820
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #821
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #855
	outchar r1, r2
	loadn r1, #2363
	loadn r2, #857
	outchar r1, r2
	loadn r1, #2362
	loadn r2, #860
	outchar r1, r2
	loadn r1, #2428
	loadn r2, #861
	outchar r1, r2
	loadn r1, #2399
	loadn r2, #886
	outchar r1, r2
	loadn r1, #2399
	loadn r2, #887
	outchar r1, r2
	loadn r1, #2399
	loadn r2, #888
	outchar r1, r2
	loadn r1, #2399
	loadn r2, #889
	outchar r1, r2
	loadn r1, #2399
	loadn r2, #890
	outchar r1, r2
	loadn r1, #2350
	loadn r2, #891
	outchar r1, r2
	loadn r1, #2348
	loadn r2, #892
	outchar r1, r2
	loadn r1, #2349
	loadn r2, #893
	outchar r1, r2
	loadn r1, #2339
	loadn r2, #894
	outchar r1, r2
	loadn r1, #2341
	loadn r2, #895
	outchar r1, r2
	loadn r1, #2342
	loadn r2, #896
	outchar r1, r2
	loadn r1, #2340
	loadn r2, #897
	outchar r1, r2
	loadn r1, #2368
	loadn r2, #898
	outchar r1, r2
	loadn r1, #2341
	loadn r2, #899
	outchar r1, r2
	loadn r1, #2339
	loadn r2, #900
	outchar r1, r2
	loadn r1, #2342
	loadn r2, #901
	outchar r1, r2
	loadn r1, #2339
	loadn r2, #902
	outchar r1, r2
	loadn r1, #2430
	loadn r2, #903
	outchar r1, r2
	loadn r1, #2348
	loadn r2, #904
	outchar r1, r2
	loadn r1, #2350
	loadn r2, #905
	outchar r1, r2
	loadn r1, #2399
	loadn r2, #906
	outchar r1, r2
	loadn r1, #2399
	loadn r2, #907
	outchar r1, r2
	loadn r1, #2399
	loadn r2, #908
	outchar r1, r2
	loadn r1, #2399
	loadn r2, #909
	outchar r1, r2
	loadn r1, #2399
	loadn r2, #910
	outchar r1, r2
	loadn r1, #2319
	loadn r2, #969
	outchar r1, r2
	loadn r1, #2319
	loadn r2, #970
	outchar r1, r2
	loadn r1, #2319
	loadn r2, #971
	outchar r1, r2
	loadn r1, #2319
	loadn r2, #972
	outchar r1, r2
	loadn r1, #2319
	loadn r2, #974
	outchar r1, r2
	loadn r1, #2319
	loadn r2, #975
	outchar r1, r2
	loadn r1, #2319
	loadn r2, #976
	outchar r1, r2
	loadn r1, #2319
	loadn r2, #977
	outchar r1, r2
	loadn r1, #2319
	loadn r2, #979
	outchar r1, r2
	loadn r1, #16
	loadn r2, #1046
	outchar r1, r2
	loadn r1, #25
	loadn r2, #1047
	outchar r1, r2
	loadn r1, #25
	loadn r2, #1048
	outchar r1, r2
	loadn r1, #25
	loadn r2, #1049
	outchar r1, r2
	loadn r1, #25
	loadn r2, #1050
	outchar r1, r2
	loadn r1, #25
	loadn r2, #1051
	outchar r1, r2
	loadn r1, #25
	loadn r2, #1052
	outchar r1, r2
	loadn r1, #25
	loadn r2, #1053
	outchar r1, r2
	loadn r1, #25
	loadn r2, #1054
	outchar r1, r2
	loadn r1, #25
	loadn r2, #1055
	outchar r1, r2
	loadn r1, #25
	loadn r2, #1056
	outchar r1, r2
	loadn r1, #25
	loadn r2, #1057
	outchar r1, r2
	loadn r1, #16
	loadn r2, #1058
	outchar r1, r2
	loadn r1, #526
	loadn r2, #1059
	outchar r1, r2
	loadn r1, #25
	loadn r2, #1060
	outchar r1, r2
	loadn r1, #25
	loadn r2, #1061
	outchar r1, r2
	loadn r1, #25
	loadn r2, #1062
	outchar r1, r2
	loadn r1, #25
	loadn r2, #1063
	outchar r1, r2
	loadn r1, #2327
	loadn r2, #1064
	outchar r1, r2
	loadn r1, #11
	loadn r2, #1065
	outchar r1, r2
	loadn r1, #11
	loadn r2, #1066
	outchar r1, r2
	loadn r1, #11
	loadn r2, #1067
	outchar r1, r2
	loadn r1, #11
	loadn r2, #1068
	outchar r1, r2
	loadn r1, #11
	loadn r2, #1069
	outchar r1, r2
	loadn r1, #11
	loadn r2, #1070
	outchar r1, r2
	loadn r1, #521
	loadn r2, #1087
	outchar r1, r2
	loadn r1, #521
	loadn r2, #1088
	outchar r1, r2
	loadn r1, #521
	loadn r2, #1089
	outchar r1, r2
	loadn r1, #592
	loadn r2, #1090
	outchar r1, r2
	loadn r1, #594
	loadn r2, #1091
	outchar r1, r2
	loadn r1, #581
	loadn r2, #1092
	outchar r1, r2
	loadn r1, #595
	loadn r2, #1093
	outchar r1, r2
	loadn r1, #595
	loadn r2, #1094
	outchar r1, r2
	loadn r1, #585
	loadn r2, #1095
	outchar r1, r2
	loadn r1, #591
	loadn r2, #1096
	outchar r1, r2
	loadn r1, #590
	loadn r2, #1097
	outchar r1, r2
	loadn r1, #581
	loadn r2, #1098
	outchar r1, r2
	loadn r1, #526
	loadn r2, #1099
	outchar r1, r2
	loadn r1, #526
	loadn r2, #1100
	outchar r1, r2
	loadn r1, #526
	loadn r2, #1101
	outchar r1, r2
	loadn r1, #526
	loadn r2, #1102
	outchar r1, r2
	loadn r1, #2319
	loadn r2, #1129
	outchar r1, r2
	loadn r1, #2319
	loadn r2, #1130
	outchar r1, r2
	loadn r1, #581
	loadn r2, #1131
	outchar r1, r2
	loadn r1, #595
	loadn r2, #1132
	outchar r1, r2
	loadn r1, #592
	loadn r2, #1133
	outchar r1, r2
	loadn r1, #577
	loadn r2, #1134
	outchar r1, r2
	loadn r1, #579
	loadn r2, #1135
	outchar r1, r2
	loadn r1, #591
	loadn r2, #1136
	outchar r1, r2
	loadn r1, #2319
	loadn r2, #1137
	outchar r1, r2
	loadn r1, #2319
	loadn r2, #1175
	outchar r1, r2
	loadn r1, #0
	mov r7, r1
	jmp Lend16
Lend16:
	rts
main:
	push r0
	mov r0, sp
	loadn r7, #8
	sub r7, r0, r7
	mov sp, r7
	loadn r1, #42
	loadn r2, #7
	sub r2, r0, r2
	storei r2, r1
L76:
	loadn r1, #1
	loadn r2, #1
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L77
	call menu
	mov r1, r7
	loadn r1, #7
	sub r1, r0, r1
	loadi r1, r1
	call make_tabuleiro
	mov r2, r7
	call printar_tabuleiro
	mov r1, r7
	loadn r1, #10
	loadn r2, #1
	sub r2, r0, r2
	storei r2, r1
	loadn r1, #8
	loadn r2, #2
	sub r2, r0, r2
	storei r2, r1
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	call printar_selecao
	mov r3, r7
	loadn r1, #str13
	loadn r2, #0
	call print_str
	mov r3, r7
	loadn r1, #total_bombas
	loadi r1, r1
	loadn r2, #8
	call printNum2
	mov r3, r7
	loadn r1, #0
	loadn r2, #5
	sub r2, r0, r2
	storei r2, r1
	loadn r1, #255
	loadn r2, #4
	sub r2, r0, r2
	storei r2, r1
L79:
	loadn r1, #5
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #0
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L80
	inchar r1
	loadn r2, #3
	sub r2, r0, r2
	storei r2, r1
	loadn r1, #3
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #255
	cmp r1, r2
	push fr
	pop r1
	not r1, r1
	loadn r7, #4
	and r1, r1, r7
	jz L82
	loadn r1, #3
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #4
	sub r2, r0, r2
	loadi r2, r2
	cmp r1, r2
	push fr
	pop r1
	not r1, r1
	loadn r7, #4
	and r1, r1, r7
	jz L83
	loadn r1, #3
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #39
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L87
	loadn r1, #1
	jmp L88
L87:
	loadn r2, #3
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #100
	cmp r2, r3
	push fr
	pop r2
	loadn r7, #4
	and r2, r2, r7
	mov r1, r2
	jz L88
	loadn r1, #1
L88:
	jz L85
	loadn r1, #1
	jmp L86
L85:
	loadn r2, #3
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #68
	cmp r2, r3
	push fr
	pop r2
	loadn r7, #4
	and r2, r2, r7
	mov r1, r2
	jz L86
	loadn r1, #1
L86:
	jz L84
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #29
	loadn r3, #1
	sub r2, r2, r3
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #2
	and r1, r1, r7
	jz L89
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	call apagar_selecao
	mov r3, r7
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #1
	add r1, r1, r2
	loadn r2, #1
	sub r2, r0, r2
	storei r2, r1
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	call printar_selecao
	mov r3, r7
L89:
L84:
	loadn r1, #3
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #37
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L93
	loadn r1, #1
	jmp L94
L93:
	loadn r2, #3
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #97
	cmp r2, r3
	push fr
	pop r2
	loadn r7, #4
	and r2, r2, r7
	mov r1, r2
	jz L94
	loadn r1, #1
L94:
	jz L91
	loadn r1, #1
	jmp L92
L91:
	loadn r2, #3
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #65
	cmp r2, r3
	push fr
	pop r2
	loadn r7, #4
	and r2, r2, r7
	mov r1, r2
	jz L92
	loadn r1, #1
L92:
	jz L90
	loadn r1, #10
	loadn r2, #1
	sub r2, r0, r2
	loadi r2, r2
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #2
	and r1, r1, r7
	jz L95
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	call apagar_selecao
	mov r3, r7
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #1
	sub r1, r1, r2
	loadn r2, #1
	sub r2, r0, r2
	storei r2, r1
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	call printar_selecao
	mov r3, r7
L95:
L90:
	loadn r1, #3
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #38
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L99
	loadn r1, #1
	jmp L100
L99:
	loadn r2, #3
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #119
	cmp r2, r3
	push fr
	pop r2
	loadn r7, #4
	and r2, r2, r7
	mov r1, r2
	jz L100
	loadn r1, #1
L100:
	jz L97
	loadn r1, #1
	jmp L98
L97:
	loadn r2, #3
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #87
	cmp r2, r3
	push fr
	pop r2
	loadn r7, #4
	and r2, r2, r7
	mov r1, r2
	jz L98
	loadn r1, #1
L98:
	jz L96
	loadn r1, #8
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #2
	and r1, r1, r7
	jz L101
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	call apagar_selecao
	mov r3, r7
	loadn r1, #2
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #1
	sub r1, r1, r2
	loadn r2, #2
	sub r2, r0, r2
	storei r2, r1
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	call printar_selecao
	mov r3, r7
L101:
L96:
	loadn r1, #3
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #40
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L105
	loadn r1, #1
	jmp L106
L105:
	loadn r2, #3
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #115
	cmp r2, r3
	push fr
	pop r2
	loadn r7, #4
	and r2, r2, r7
	mov r1, r2
	jz L106
	loadn r1, #1
L106:
	jz L103
	loadn r1, #1
	jmp L104
L103:
	loadn r2, #3
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #83
	cmp r2, r3
	push fr
	pop r2
	loadn r7, #4
	and r2, r2, r7
	mov r1, r2
	jz L104
	loadn r1, #1
L104:
	jz L102
	loadn r1, #2
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #22
	loadn r3, #1
	sub r2, r2, r3
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #2
	and r1, r1, r7
	jz L107
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	call apagar_selecao
	mov r3, r7
	loadn r1, #2
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #1
	add r1, r1, r2
	loadn r2, #2
	sub r2, r0, r2
	storei r2, r1
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	call printar_selecao
	mov r3, r7
L107:
L102:
	loadn r1, #3
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #13
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L108
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	call pos_para_idx
	mov r3, r7
	loadn r1, #6
	sub r1, r0, r1
	storei r1, r3
	loadn r1, #revelado_jogo
	loadn r2, #6
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #1
	mul r2, r2, r3
	add r1, r1, r2
	loadi r1, r1
	loadn r2, #48
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L109
	loadn r1, #mapa_jogo
	loadn r2, #6
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #1
	mul r2, r2, r3
	add r1, r1, r2
	loadi r1, r1
	loadn r2, #57
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L110
	loadn r1, #49
	loadn r2, #revelado_jogo
	loadn r3, #6
	sub r3, r0, r3
	loadi r3, r3
	loadn r4, #1
	mul r3, r3, r4
	add r2, r2, r3
	storei r2, r1
	loadn r1, #57
	loadn r2, #7936
	add r1, r1, r2
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #40
	mul r2, r2, r3
	loadn r3, #1
	sub r3, r0, r3
	loadi r3, r3
	add r2, r2, r3
	outchar r1, r2
	loadn r1, #2
	loadn r2, #5
	sub r2, r0, r2
	storei r2, r1
	jmp L111
L110:
	loadn r1, #6
	sub r1, r0, r1
	loadi r1, r1
	call revelar_recursivo
	mov r2, r7
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	call printar_selecao
	mov r3, r7
	loadn r1, #celulas_reveladas
	loadi r1, r1
	loadn r2, #266
	loadn r3, #total_bombas
	loadi r3, r3
	sub r2, r2, r3
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L112
	loadn r1, #1
	loadn r2, #5
	sub r2, r0, r2
	storei r2, r1
L112:
L111:
L109:
L108:
	loadn r1, #3
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #102
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L114
	loadn r1, #1
	jmp L115
L114:
	loadn r2, #3
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #70
	cmp r2, r3
	push fr
	pop r2
	loadn r7, #4
	and r2, r2, r7
	mov r1, r2
	jz L115
	loadn r1, #1
L115:
	jz L113
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	call pos_para_idx
	mov r3, r7
	loadn r1, #6
	sub r1, r0, r1
	storei r1, r3
	loadn r1, #6
	sub r1, r0, r1
	loadi r1, r1
	call alternar_bandeira
	mov r2, r7
	loadn r1, #1
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #2
	sub r2, r0, r2
	loadi r2, r2
	call printar_selecao
	mov r3, r7
L113:
	loadn r1, #3
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #113
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L117
	loadn r1, #1
	jmp L118
L117:
	loadn r2, #3
	sub r2, r0, r2
	loadi r2, r2
	loadn r3, #81
	cmp r2, r3
	push fr
	pop r2
	loadn r7, #4
	and r2, r2, r7
	mov r1, r2
	jz L118
	loadn r1, #1
L118:
	jz L116
	loadn r1, #3
	loadn r2, #5
	sub r2, r0, r2
	storei r2, r1
L116:
L83:
L82:
	loadn r1, #3
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #4
	sub r2, r0, r2
	storei r2, r1
	jmp L79
L80:
L81:
	loadn r1, #5
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #1
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L119
	loadn r1, #str14
	loadn r2, #29
	loadn r3, #40
	mul r2, r2, r3
	loadn r3, #8
	add r2, r2, r3
	call print_str
	mov r3, r7
	jmp L120
L119:
	loadn r1, #5
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #2
	cmp r1, r2
	push fr
	pop r1
	loadn r7, #4
	and r1, r1, r7
	jz L121
	call printYoulostScreen
	mov r1, r7
	jmp L122
L121:
	loadn r1, #str15
	loadn r2, #29
	loadn r3, #40
	mul r2, r2, r3
	loadn r3, #8
	add r2, r2, r3
	call print_str
	mov r3, r7
L122:
L120:
	loadn r1, #7
	sub r1, r0, r1
	loadi r1, r1
	loadn r2, #5
	add r1, r1, r2
	loadn r2, #7
	sub r2, r0, r2
	storei r2, r1
	call espera_espaco
	mov r1, r7
	jmp L76
L77:
L78:
	loadn r1, #0
	mov r7, r1
	jmp Lend17
Lend17:
	mov sp, r0
	pop r0
	rts
mapa_jogo : var #266
revelado_jogo : var #266
semente_rand : var #1
dir_x : var #8
dir_y : var #8
total_bombas : var #1
bandeiras_restantes : var #1
celulas_reveladas : var #1
str0 : string "_ -^^---....,,--"
str1 : string " --               --"
str2 : string "<                   >)"
str3 : string "|                   |"
str4 : string " \\_               _/"
str5 : string "   ```-- . , ; .--'''"
str6 : string "        | |  |"
str7 : string "      .-=||  ||=-."
str8 : string "      `-=#$%&%$#=-'"
str9 : string "        | ;  :|"
str10 : string "  __.,-#%&$@%#&#~,.__"
str11 : string "CAMPO MINADO"
str12 : string "PRESSIONE ESPACO PARA JOGAR"
str13 : string "BOMBAS: "
str14 : string "VOCE VENCEU!  ESPACO"
str15 : string "DESISTIU.     ESPACO"
