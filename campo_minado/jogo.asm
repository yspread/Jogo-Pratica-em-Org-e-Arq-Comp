
jmp main

;--------------------------- DADOS ------------------------------------

; tabuleiro gerado em tempo de execucao por make_tabuleiro
mapa:     var #266
; estado de cada celula ('0' escondida, '1' revelada, '2' bandeira)
revelado: var #266

; textos (string ja termina em 0)
msg_titulo:  string "CAMPO MINADO"
msg_menu:    string "PRESSIONE ESPACO PARA JOGAR"
msg_bombas:  string "BOMBAS: "
msg_vitoria: string "VOCE VENCEU!  ESPACO"
msg_desisto: string "DESISTIU.     ESPACO"

; variaveis globais
sx:           var #1   ; coluna do cursor na tela (10..28)
sy:           var #1   ; linha do cursor na tela (8..21)
estado:       var #1   ; 0 jogando, 1 venceu, 2 perdeu, 3 desistiu
tecla_ant:    var #1   ; anti-repeticao de tecla
total_bombas: var #1
bandeiras:    var #1
reveladas:    var #1
semente:      var #1   ; estado atual do gerador pseudo-aleatorio
seed_atual:   var #1   ; seed da proxima partida (42, 47, 52, ...)

;--------------------------- MAIN -------------------------------------

main:
    loadn r0, #42          ; seed da primeira partida
    store seed_atual, r0

main_reinicio:
    call menu
    load r0, seed_atual
    call make_tabuleiro
    call printar_tabuleiro

    ; cursor no canto superior esquerdo do tabuleiro
    loadn r0, #10
    store sx, r0
    loadn r0, #8
    store sy, r0
    call printar_selecao

    ; placar "BOMBAS: NN" no canto da tela
    loadn r0, #msg_bombas
    loadn r1, #0
    call print_str
    load r0, total_bombas
    loadn r1, #8
    call print_num2

    loadn r0, #0
    store estado, r0
    loadn r0, #255
    store tecla_ant, r0

laco_jogo:
    load r0, estado
    loadn r1, #0
    cmp r0, r1
    jne fim_partida

    inchar r0              ; 255 = nenhuma tecla
    loadn r1, #255
    cmp r0, r1
    jeq lj_grava
    load r1, tecla_ant     ; ignora tecla segurada
    cmp r0, r1
    jeq lj_grava
    store tecla_ant, r0

    ; ---------- dispatch de teclas ----------
    loadn r1, #100         ; 'd'
    cmp r0, r1
    jeq mov_direita
    loadn r1, #68          ; 'D'
    cmp r0, r1
    jeq mov_direita
    loadn r1, #97          ; 'a'
    cmp r0, r1
    jeq mov_esquerda
    loadn r1, #65          ; 'A'
    cmp r0, r1
    jeq mov_esquerda
    loadn r1, #119         ; 'w'
    cmp r0, r1
    jeq mov_cima
    loadn r1, #87          ; 'W'
    cmp r0, r1
    jeq mov_cima
    loadn r1, #115         ; 's'
    cmp r0, r1
    jeq mov_baixo
    loadn r1, #83          ; 'S'
    cmp r0, r1
    jeq mov_baixo
    loadn r1, #32          ; ESPACO
    cmp r0, r1
    jeq acao_revelar
    loadn r1, #13          ; ENTER
    cmp r0, r1
    jeq acao_revelar
    loadn r1, #102         ; 'f'
    cmp r0, r1
    jeq acao_bandeira
    loadn r1, #70          ; 'F'
    cmp r0, r1
    jeq acao_bandeira
    loadn r1, #113         ; 'q'
    cmp r0, r1
    jeq acao_desistir
    loadn r1, #81          ; 'Q'
    cmp r0, r1
    jeq acao_desistir
    jmp laco_jogo

lj_grava:
    store tecla_ant, r0
    jmp laco_jogo

; ---------- movimentacao do cursor ----------
mov_direita:
    load r1, sx
    loadn r2, #28          ; ultima coluna do tabuleiro
    cmp r1, r2
    jeq laco_jogo
    call apagar_selecao
    load r1, sx
    inc r1
    store sx, r1
    call printar_selecao
    jmp laco_jogo

mov_esquerda:
    load r1, sx
    loadn r2, #10
    cmp r1, r2
    jeq laco_jogo
    call apagar_selecao
    load r1, sx
    dec r1
    store sx, r1
    call printar_selecao
    jmp laco_jogo

mov_cima:
    load r1, sy
    loadn r2, #8
    cmp r1, r2
    jeq laco_jogo
    call apagar_selecao
    load r1, sy
    dec r1
    store sy, r1
    call printar_selecao
    jmp laco_jogo

mov_baixo:
    load r1, sy
    loadn r2, #21          ; ultima linha do tabuleiro
    cmp r1, r2
    jeq laco_jogo
    call apagar_selecao
    load r1, sy
    inc r1
    store sy, r1
    call printar_selecao
    jmp laco_jogo

; ---------- revelar celula ----------
acao_revelar:
    call cursor_para_idx   ; r0 = indice no tabuleiro
    loadn r1, #revelado
    add r1, r1, r0
    loadi r2, r1           ; r2 = revelado[idx]
    loadn r3, #48          ; so revela celula escondida ('0')
    cmp r2, r3
    jne laco_jogo
    loadn r3, #mapa
    add r3, r3, r0
    loadi r2, r3           ; r2 = mapa[idx]
    loadn r3, #57          ; '9' = bomba
    cmp r2, r3
    jeq ar_bomba
    call revelar_recursivo
    call printar_selecao
    ; vitoria: reveladas == 266 - total_bombas
    load r1, reveladas
    loadn r2, #266
    load r3, total_bombas
    sub r2, r2, r3
    cmp r1, r2
    jne laco_jogo
    loadn r1, #1
    store estado, r1
    jmp laco_jogo

ar_bomba:
    loadn r2, #49          ; revelado[idx] = '1'
    storei r1, r2
    load r1, sy            ; imprime '9' vermelho no cursor
    loadn r2, #40
    mul r1, r1, r2
    load r2, sx
    add r1, r1, r2
    loadn r2, #57401        ; '9'(57) + vermelho
    outchar r2, r1
    loadn r1, #2
    store estado, r1
    jmp laco_jogo

; ---------- bandeira ----------
acao_bandeira:
    call cursor_para_idx
    call alternar_bandeira
    call printar_selecao
    jmp laco_jogo

; ---------- desistir ----------
acao_desistir:
    loadn r1, #3
    store estado, r1
    jmp laco_jogo

; ---------- fim de partida ----------
fim_partida:
    load r0, estado
    loadn r1, #2
    cmp r0, r1
    jeq fp_perdeu
    loadn r1, #1
    cmp r0, r1
    jeq fp_venceu
    loadn r0, #msg_desisto
    jmp fp_mostra
fp_venceu:
    loadn r0, #msg_vitoria
fp_mostra:
    loadn r1, #1168        ; linha 29: 29*40 + 8
    call print_str
    jmp fp_fim
fp_perdeu:
    call printYoulostScreen  ; tela de derrota (vinda de tela.asm)
fp_fim:
    load r0, seed_atual    ; muda o mapa da proxima partida
    loadn r1, #5
    add r0, r0, r1
    store seed_atual, r0
    call espera_espaco
    jmp main_reinicio

;--------------------------- ROTINAS ----------------------------------

; menu inicial
menu:
    push r0
    push r1
    call clear_screen
    loadn r0, #msg_titulo
    loadn r1, #134         ; 3*40 + 14
    call print_str
    loadn r0, #msg_menu
    loadn r1, #246         ; 6*40 + 6
    call print_str
    call espera_espaco
    call clear_screen
    pop r1
    pop r0
    rts

; imprime string terminada em 0 (r0 = endereco, r1 = posicao de tela)
print_str:
    push r0
    push r1
    push r2
    push r3
ps_loop:
    loadi r2, r0
    loadn r3, #0
    cmp r2, r3
    jeq ps_fim
    loadn r3, #65280        ; branco
    add r2, r2, r3
    outchar r2, r1
    inc r0
    inc r1
    jmp ps_loop
ps_fim:
    pop r3
    pop r2
    pop r1
    pop r0
    rts

; limpa a tela inteira (1200 posicoes)
clear_screen:
    push r0
    push r1
    push r2
    loadn r0, #32          ; espaco
    loadn r1, #0
    loadn r2, #1200
cs_loop:
    cmp r1, r2
    jeq cs_fim
    outchar r0, r1
    inc r1
    jmp cs_loop
cs_fim:
    pop r2
    pop r1
    pop r0
    rts

; imprime numero 0..99 com 2 digitos (r0 = numero, r1 = posicao)
print_num2:
    push r0
    push r1
    push r2
    push r3
    push r4
    push r5
    loadn r2, #10
    div r3, r0, r2         ; dezena
    mul r4, r3, r2
    sub r4, r0, r4         ; unidade
    loadn r5, #48          ; '0'
    add r3, r3, r5
    loadn r2, #65280        ; branco
    add r3, r3, r2
    outchar r3, r1
    inc r1
    add r4, r4, r5
    add r4, r4, r2
    outchar r4, r1
    pop r5
    pop r4
    pop r3
    pop r2
    pop r1
    pop r0
    rts

; espera o usuario apertar ESPACO
espera_espaco:
    push r0
    push r1
    loadn r1, #32
ee_loop:
    inchar r0
    cmp r0, r1
    jne ee_loop
    pop r1
    pop r0
    rts

; converte indice do tabuleiro em posicao de tela
; entrada: r0 = idx (0..265) / saida: r0 = posicao (0..1199)
idx_para_tela:
    push r1
    push r2
    push r3
    loadn r1, #19
    div r2, r0, r1         ; r2 = ry
    mul r3, r2, r1
    sub r3, r0, r3         ; r3 = rx
    loadn r1, #8           ; INICIO_Y
    add r2, r2, r1
    loadn r1, #40          ; LARGURA da tela
    mul r2, r2, r1
    add r2, r2, r3
    loadn r1, #10          ; INICIO_X
    add r0, r2, r1
    pop r3
    pop r2
    pop r1
    rts

; converte posicao do cursor (globais sx,sy) em indice do tabuleiro
; saida: r0 = idx
cursor_para_idx:
    push r1
    push r2
    load r0, sy
    loadn r1, #8
    sub r0, r0, r1         ; by
    loadn r1, #19
    mul r0, r0, r1
    load r1, sx
    loadn r2, #10
    sub r1, r1, r2         ; bx
    add r0, r0, r1
    pop r2
    pop r1
    rts

; gerador pseudo-aleatorio: semente = semente*13 + 7
; se "ficar negativo" (bit 15 setado), nega para voltar ao positivo
; saida: r0 = novo valor da semente
rand:
    push r1
    load r0, semente
    loadn r1, #13
    mul r0, r0, r1
    loadn r1, #7
    add r0, r0, r1
    loadn r1, #32767
    cmp r0, r1             ; r0 > 32767 <=> bit 15 setado
    jgr rand_nega
    jmp rand_fim
rand_nega:
    loadn r1, #0
    sub r0, r1, r0         ; r0 = -r0 (complemento de dois)
rand_fim:
    store semente, r0
    pop r1
    rts

; sorteia posicao valida do tabuleiro: r0 = rand() mod 266
rand_pos:
    push r1
    push r2
    call rand
    loadn r1, #266
    div r2, r0, r1
    mul r2, r2, r1
    sub r0, r0, r2
    pop r2
    pop r1
    rts

; gera o tabuleiro aleatorio (r0 = seed da partida)
; passo 1: zera mapa e revelado / passo 2: sorteia 38 bombas /
; passo 3: calcula o numero de cada celula pelos 8 vizinhos
make_tabuleiro:
    push r0
    push r1
    push r2
    push r3
    push r4
    push r5
    store semente, r0      ; inicializa o gerador com a seed
    loadn r0, #0
    store reveladas, r0

    ; ----- passo 1: tudo '0' -----
    loadn r0, #0
    loadn r1, #266
    loadn r2, #mapa
    loadn r3, #revelado
mt_zera:
    cmp r0, r1
    jeq mt_bombas
    loadn r4, #48
    storei r2, r4
    storei r3, r4
    inc r0
    inc r2
    inc r3
    jmp mt_zera

    ; ----- passo 2: espalha as 38 bombas -----
mt_bombas:
    loadn r1, #0           ; bombas colocadas
    loadn r2, #38
mt_b_loop:
    cmp r1, r2
    jeq mt_prepara
    call rand_pos          ; r0 = posicao sorteada (0..265)
    loadn r3, #mapa
    add r3, r3, r0
    loadi r4, r3
    loadn r5, #57          ; '9'
    cmp r4, r5
    jeq mt_b_loop          ; ja tem bomba aqui: sorteia outra
    storei r3, r5          ; mapa[pos] = '9'
    inc r1
    jmp mt_b_loop

mt_prepara:
    loadn r0, #38
    store total_bombas, r0
    store bandeiras, r0

    ; ----- passo 3: numeros das celulas -----
    ; r1 = rx, r2 = ry, r4 = ponteiro no mapa, r5 = contador i
    loadn r1, #0
    loadn r2, #0
    loadn r4, #mapa
    loadn r5, #0
mt_n_loop:
    loadn r3, #266
    cmp r5, r3
    jeq mt_fim
    loadi r3, r4           ; r3 = mapa[i]
    loadn r0, #57
    cmp r3, r0
    jeq mt_n_prox          ; bomba: mantem o '9'
    call conta_vizinhas    ; r0 = bombas vizinhas (preserva r1..r5)
    loadn r3, #48
    add r0, r0, r3         ; converte para char
    storei r4, r0
mt_n_prox:
    inc r1                 ; avanca (rx, ry) manualmente
    loadn r3, #19
    cmp r1, r3
    jne mt_n_avanca
    loadn r1, #0
    inc r2
mt_n_avanca:
    inc r4
    inc r5
    jmp mt_n_loop

mt_fim:
    pop r5
    pop r4
    pop r3
    pop r2
    pop r1
    pop r0
    rts

; conta bombas nas 8 celulas vizinhas de (r1 = rx, r2 = ry)
; saida: r0 = contagem (0..8); preserva r1..r5
conta_vizinhas:
    push r1
    push r2
    push r3
    push r4
    push r5
    loadn r0, #0
cv_oeste:                  ; (rx-1, ry) se rx > 0
    loadn r3, #0
    cmp r1, r3
    jeq cv_leste
    loadn r3, #19
    mul r4, r2, r3
    add r4, r4, r1
    dec r4
    call cv_testa
cv_leste:                  ; (rx+1, ry) se rx < 18
    loadn r3, #18
    cmp r1, r3
    jeq cv_norte
    loadn r3, #19
    mul r4, r2, r3
    add r4, r4, r1
    inc r4
    call cv_testa
cv_norte:                  ; (rx, ry-1) se ry > 0
    loadn r3, #0
    cmp r2, r3
    jeq cv_sul
    loadn r3, #19
    mul r4, r2, r3
    add r4, r4, r1
    sub r4, r4, r3
    call cv_testa
cv_sul:                    ; (rx, ry+1) se ry < 13
    loadn r3, #13
    cmp r2, r3
    jeq cv_no
    loadn r3, #19
    mul r4, r2, r3
    add r4, r4, r1
    add r4, r4, r3
    call cv_testa
cv_no:                     ; (rx-1, ry-1) se rx > 0 e ry > 0
    loadn r3, #0
    cmp r1, r3
    jeq cv_ne
    cmp r2, r3
    jeq cv_ne
    loadn r3, #19
    mul r4, r2, r3
    add r4, r4, r1
    sub r4, r4, r3
    dec r4
    call cv_testa
cv_ne:                     ; (rx+1, ry-1) se rx < 18 e ry > 0
    loadn r3, #18
    cmp r1, r3
    jeq cv_so
    loadn r3, #0
    cmp r2, r3
    jeq cv_so
    loadn r3, #19
    mul r4, r2, r3
    add r4, r4, r1
    sub r4, r4, r3
    inc r4
    call cv_testa
cv_so:                     ; (rx-1, ry+1) se rx > 0 e ry < 13
    loadn r3, #0
    cmp r1, r3
    jeq cv_se
    loadn r3, #13
    cmp r2, r3
    jeq cv_se
    loadn r3, #19
    mul r4, r2, r3
    add r4, r4, r1
    add r4, r4, r3
    dec r4
    call cv_testa
cv_se:                     ; (rx+1, ry+1) se rx < 18 e ry < 13
    loadn r3, #18
    cmp r1, r3
    jeq cv_fim
    loadn r3, #13
    cmp r2, r3
    jeq cv_fim
    loadn r3, #19
    mul r4, r2, r3
    add r4, r4, r1
    add r4, r4, r3
    inc r4
    call cv_testa
cv_fim:
    pop r5
    pop r4
    pop r3
    pop r2
    pop r1
    rts

; auxiliar de conta_vizinhas: incrementa r0 se mapa[r4] == '9'
cv_testa:
    push r3
    push r4
    loadn r3, #mapa
    add r4, r4, r3
    loadi r4, r4
    loadn r3, #57
    cmp r4, r3
    jne cv_t_fim
    inc r0
cv_t_fim:
    pop r4
    pop r3
    rts

; desenha o tabuleiro todo escondido ('*')
printar_tabuleiro:
    push r0
    push r1
    push r2
    push r3
    push r4
    push r5
    loadn r0, #8           ; cy
    loadn r1, #22          ; FIM_Y
pt_linha:
    cmp r0, r1
    jeq pt_fim
    loadn r2, #10          ; cx
    loadn r3, #29          ; FIM_X
pt_coluna:
    cmp r2, r3
    jeq pt_prox_linha
    loadn r4, #40
    mul r4, r0, r4
    add r4, r4, r2
    loadn r5, #65322       ; '*' branco
    outchar r5, r4
    inc r2
    jmp pt_coluna
pt_prox_linha:
    inc r0
    jmp pt_linha
pt_fim:
    pop r5
    pop r4
    pop r3
    pop r2
    pop r1
    pop r0
    rts

; desenha o cursor (asterisco vermelho) na posicao sx,sy
printar_selecao:
    push r0
    push r1
    push r2
    load r0, sy
    loadn r1, #40
    mul r0, r0, r1
    load r1, sx
    add r0, r0, r1
    loadn r2, #57386        ; '*'(42) + vermelho
    outchar r2, r0
    pop r2
    pop r1
    pop r0
    rts

; redesenha o conteudo da celula sob o cursor ao sair dela
apagar_selecao:
    push r0
    push r1
    push r2
    push r3
    push r4
    call cursor_para_idx   ; r0 = idx
    loadn r3, #revelado
    add r3, r3, r0
    loadi r1, r3           ; r1 = revelado[idx]
    loadn r3, #mapa
    add r3, r3, r0
    loadi r2, r3           ; r2 = mapa[idx]
    load r3, sy            ; r4 = posicao de tela do cursor
    loadn r4, #40
    mul r4, r3, r4
    load r3, sx
    add r4, r4, r3
    loadn r3, #50          ; '2' = bandeira
    cmp r1, r3
    jne as_nao_bandeira
    loadn r3, #57519        ; bandeira: char 175 do charmap + vermelho
    outchar r3, r4
    jmp as_fim
as_nao_bandeira:
    loadn r3, #49          ; '1' = revelada
    cmp r1, r3
    jne as_escondida
    loadn r3, #48
    cmp r2, r3
    jne as_numero
    loadn r3, #32          ; celula vazia -> espaco
    outchar r3, r4
    jmp as_fim
as_numero:
    loadn r3, #65280        ; branco
    add r2, r2, r3
    outchar r2, r4         ; imprime o digito do mapa
    jmp as_fim
as_escondida:
    loadn r3, #65322       ; '*' branco
    outchar r3, r4
as_fim:
    pop r4
    pop r3
    pop r2
    pop r1
    pop r0
    rts

; alterna bandeira na celula (r0 = idx)
alternar_bandeira:
    push r0
    push r1
    push r2
    push r3
    push r4
    push r5
    loadn r1, #revelado
    add r1, r1, r0         ; r1 = &revelado[idx]
    loadi r2, r1           ; r2 = estado da celula
    call idx_para_tela
    mov r4, r0             ; r4 = posicao de tela
    loadn r3, #48
    cmp r2, r3
    jeq ab_marcar
    loadn r3, #50
    cmp r2, r3
    jeq ab_desmarcar
    jmp ab_fim             ; celula revelada: nada a fazer
ab_marcar:
    load r3, bandeiras     ; so marca se ainda ha bandeiras
    loadn r5, #0
    cmp r3, r5
    jeq ab_fim
    dec r3
    store bandeiras, r3
    loadn r3, #50
    storei r1, r3
    loadn r3, #57519        ; bandeira: char 175 do charmap + vermelho
    outchar r3, r4
    jmp ab_fim
ab_desmarcar:
    load r3, bandeiras
    inc r3
    store bandeiras, r3
    loadn r3, #48
    storei r1, r3
    loadn r3, #65322       ; volta a mostrar '*' branco
    outchar r3, r4
ab_fim:
    pop r5
    pop r4
    pop r3
    pop r2
    pop r1
    pop r0
    rts

; flood fill recursivo (r0 = idx)
; revela a celula; se for '0', expande para os 8 vizinhos.
; preserva todos os registradores, por isso a recursao e segura.
revelar_recursivo:
    push r0
    push r1
    push r2
    push r3
    push r4
    push r5

    loadn r1, #revelado    ; so processa celula escondida
    add r1, r1, r0
    loadi r2, r1
    loadn r3, #48
    cmp r2, r3
    jne rr_fim

    loadn r2, #49          ; revelado[idx] = '1'
    storei r1, r2
    load r2, reveladas
    inc r2
    store reveladas, r2

    loadn r3, #19          ; r1 = rx, r2 = ry
    div r2, r0, r3
    mul r1, r2, r3
    sub r1, r0, r1

    loadn r3, #8           ; r4 = posicao de tela
    add r4, r2, r3
    loadn r3, #40
    mul r4, r4, r3
    add r4, r4, r1
    loadn r3, #10
    add r4, r4, r3

    loadn r3, #mapa        ; r5 = mapa[idx]
    add r3, r3, r0
    loadi r5, r3

    loadn r3, #48
    cmp r5, r3
    jne rr_imprime_num
    loadn r3, #32          ; '0' vira espaco em branco
    outchar r3, r4
    jmp rr_vizinhos
rr_imprime_num:
    loadn r3, #65280        ; branco
    add r5, r5, r3
    outchar r5, r4         ; numero: imprime e nao expande
    jmp rr_fim

; expande para os 8 vizinhos com checagem de borda
; (r1 = rx 0..18, r2 = ry 0..13 sobrevivem as chamadas)
rr_vizinhos:
rr_v_oeste:                ; (rx-1, ry) se rx > 0
    loadn r3, #0
    cmp r1, r3
    jeq rr_v_leste
    loadn r3, #19
    mul r0, r2, r3
    add r0, r0, r1
    dec r0
    call revelar_recursivo
rr_v_leste:                ; (rx+1, ry) se rx < 18
    loadn r3, #18
    cmp r1, r3
    jeq rr_v_norte
    loadn r3, #19
    mul r0, r2, r3
    add r0, r0, r1
    inc r0
    call revelar_recursivo
rr_v_norte:                ; (rx, ry-1) se ry > 0
    loadn r3, #0
    cmp r2, r3
    jeq rr_v_sul
    loadn r3, #19
    mul r0, r2, r3
    add r0, r0, r1
    sub r0, r0, r3
    call revelar_recursivo
rr_v_sul:                  ; (rx, ry+1) se ry < 13
    loadn r3, #13
    cmp r2, r3
    jeq rr_v_no
    loadn r3, #19
    mul r0, r2, r3
    add r0, r0, r1
    add r0, r0, r3
    call revelar_recursivo
rr_v_no:                   ; (rx-1, ry-1) se rx > 0 e ry > 0
    loadn r3, #0
    cmp r1, r3
    jeq rr_v_ne
    cmp r2, r3
    jeq rr_v_ne
    loadn r3, #19
    mul r0, r2, r3
    add r0, r0, r1
    sub r0, r0, r3
    dec r0
    call revelar_recursivo
rr_v_ne:                   ; (rx+1, ry-1) se rx < 18 e ry > 0
    loadn r3, #18
    cmp r1, r3
    jeq rr_v_so
    loadn r3, #0
    cmp r2, r3
    jeq rr_v_so
    loadn r3, #19
    mul r0, r2, r3
    add r0, r0, r1
    sub r0, r0, r3
    inc r0
    call revelar_recursivo
rr_v_so:                   ; (rx-1, ry+1) se rx > 0 e ry < 13
    loadn r3, #0
    cmp r1, r3
    jeq rr_v_se
    loadn r3, #13
    cmp r2, r3
    jeq rr_v_se
    loadn r3, #19
    mul r0, r2, r3
    add r0, r0, r1
    add r0, r0, r3
    dec r0
    call revelar_recursivo
rr_v_se:                   ; (rx+1, ry+1) se rx < 18 e ry < 13
    loadn r3, #18
    cmp r1, r3
    jeq rr_fim
    loadn r3, #13
    cmp r2, r3
    jeq rr_fim
    loadn r3, #19
    mul r0, r2, r3
    add r0, r0, r1
    add r0, r0, r3
    inc r0
    call revelar_recursivo

rr_fim:
    pop r5
    pop r4
    pop r3
    pop r2
    pop r1
    pop r0
    rts

;----------------------------------------------------------------------
; TELA DE DERROTA (conteudo de tela.asm concatenado abaixo)
;----------------------------------------------------------------------
Youlost : var #1200
  ;Linha 0
  static Youlost + #0, #57471
  static Youlost + #1, #57471
  static Youlost + #2, #57350
  static Youlost + #3, #57471
  static Youlost + #4, #57471
  static Youlost + #5, #57471
  static Youlost + #6, #57350
  static Youlost + #7, #57471
  static Youlost + #8, #57471
  static Youlost + #9, #57471
  static Youlost + #10, #57350
  static Youlost + #11, #57350
  static Youlost + #12, #57350
  static Youlost + #13, #57471
  static Youlost + #14, #57471
  static Youlost + #15, #57471
  static Youlost + #16, #57471
  static Youlost + #17, #57471
  static Youlost + #18, #57471
  static Youlost + #19, #57471
  static Youlost + #20, #57471
  static Youlost + #21, #57471
  static Youlost + #22, #57471
  static Youlost + #23, #57471
  static Youlost + #24, #57471
  static Youlost + #25, #57471
  static Youlost + #26, #57471
  static Youlost + #27, #57471
  static Youlost + #28, #57471
  static Youlost + #29, #57471
  static Youlost + #30, #57471
  static Youlost + #31, #57471
  static Youlost + #32, #57471
  static Youlost + #33, #57471
  static Youlost + #34, #57471
  static Youlost + #35, #57471
  static Youlost + #36, #57471
  static Youlost + #37, #57471
  static Youlost + #38, #57471
  static Youlost + #39, #57471

  ;Linha 1
  static Youlost + #40, #57471
  static Youlost + #41, #57350
  static Youlost + #42, #57350
  static Youlost + #43, #57471
  static Youlost + #44, #57471
  static Youlost + #45, #57350
  static Youlost + #46, #57350
  static Youlost + #47, #57350
  static Youlost + #48, #57350
  static Youlost + #49, #57350
  static Youlost + #50, #57350
  static Youlost + #51, #57471
  static Youlost + #52, #57471
  static Youlost + #53, #57471
  static Youlost + #54, #57471
  static Youlost + #55, #57471
  static Youlost + #56, #57471
  static Youlost + #57, #57471
  static Youlost + #58, #57471
  static Youlost + #59, #57471
  static Youlost + #60, #57471
  static Youlost + #61, #57471
  static Youlost + #62, #57471
  static Youlost + #63, #57471
  static Youlost + #64, #57471
  static Youlost + #65, #57471
  static Youlost + #66, #57471
  static Youlost + #67, #57471
  static Youlost + #68, #57471
  static Youlost + #69, #57471
  static Youlost + #70, #57471
  static Youlost + #71, #57471
  static Youlost + #72, #57471
  static Youlost + #73, #57471
  static Youlost + #74, #57471
  static Youlost + #75, #57471
  static Youlost + #76, #57471
  static Youlost + #77, #57471
  static Youlost + #78, #57471
  static Youlost + #79, #57471

  ;Linha 2
  static Youlost + #80, #57350
  static Youlost + #81, #57350
  static Youlost + #82, #57350
  static Youlost + #83, #57350
  static Youlost + #84, #57471
  static Youlost + #85, #57350
  static Youlost + #86, #57350
  static Youlost + #87, #57350
  static Youlost + #88, #57471
  static Youlost + #89, #57471
  static Youlost + #90, #57471
  static Youlost + #91, #57471
  static Youlost + #92, #57471
  static Youlost + #93, #57471
  static Youlost + #94, #57471
  static Youlost + #95, #57471
  static Youlost + #96, #57471
  static Youlost + #97, #57471
  static Youlost + #98, #57471
  static Youlost + #99, #57471
  static Youlost + #100, #57471
  static Youlost + #101, #57471
  static Youlost + #102, #57471
  static Youlost + #103, #57471
  static Youlost + #104, #57471
  static Youlost + #105, #57471
  static Youlost + #106, #57471
  static Youlost + #107, #57471
  static Youlost + #108, #57471
  static Youlost + #109, #57471
  static Youlost + #110, #57471
  static Youlost + #111, #57471
  static Youlost + #112, #57471
  static Youlost + #113, #57471
  static Youlost + #114, #57471
  static Youlost + #115, #57471
  static Youlost + #116, #57471
  static Youlost + #117, #57471
  static Youlost + #118, #57471
  static Youlost + #119, #57471

  ;Linha 3
  static Youlost + #120, #57471
  static Youlost + #121, #57350
  static Youlost + #122, #57350
  static Youlost + #123, #57350
  static Youlost + #124, #57350
  static Youlost + #125, #57471
  static Youlost + #126, #57471
  static Youlost + #127, #57471
  static Youlost + #128, #57471
  static Youlost + #129, #57471
  static Youlost + #130, #57354
  static Youlost + #131, #57390
  static Youlost + #132, #57387
  static Youlost + #133, #57389
  static Youlost + #134, #57389
  static Youlost + #135, #57389
  static Youlost + #136, #57390
  static Youlost + #137, #57390
  static Youlost + #138, #57390
  static Youlost + #139, #57390
  static Youlost + #140, #57388
  static Youlost + #141, #57388
  static Youlost + #142, #57389
  static Youlost + #143, #57389
  static Youlost + #144, #57387
  static Youlost + #145, #57390
  static Youlost + #146, #57471
  static Youlost + #147, #57471
  static Youlost + #148, #57471
  static Youlost + #149, #57471
  static Youlost + #150, #57471
  static Youlost + #151, #57471
  static Youlost + #152, #57471
  static Youlost + #153, #57471
  static Youlost + #154, #57471
  static Youlost + #155, #57471
  static Youlost + #156, #57471
  static Youlost + #157, #57471
  static Youlost + #158, #57471
  static Youlost + #159, #57471

  ;Linha 4
  static Youlost + #160, #57350
  static Youlost + #161, #57350
  static Youlost + #162, #57350
  static Youlost + #163, #57471
  static Youlost + #164, #57471
  static Youlost + #165, #57471
  static Youlost + #166, #57471
  static Youlost + #167, #57471
  static Youlost + #168, #57471
  static Youlost + #169, #57390
  static Youlost + #170, #57389
  static Youlost + #171, #57383
  static Youlost + #172, #57383
  static Youlost + #173, #57383
  static Youlost + #174, #57383
  static Youlost + #175, #57383
  static Youlost + #176, #57383
  static Youlost + #177, #57383
  static Youlost + #178, #57383
  static Youlost + #179, #57383
  static Youlost + #180, #57471
  static Youlost + #181, #57471
  static Youlost + #182, #57471
  static Youlost + #183, #57471
  static Youlost + #184, #57471
  static Youlost + #185, #57359
  static Youlost + #186, #57438
  static Youlost + #187, #57438
  static Youlost + #188, #57390
  static Youlost + #189, #57471
  static Youlost + #190, #57471
  static Youlost + #191, #57471
  static Youlost + #192, #57471
  static Youlost + #193, #57471
  static Youlost + #194, #57471
  static Youlost + #195, #57471
  static Youlost + #196, #57471
  static Youlost + #197, #57471
  static Youlost + #198, #57471
  static Youlost + #199, #57471

  ;Linha 5
  static Youlost + #200, #57350
  static Youlost + #201, #57350
  static Youlost + #202, #57471
  static Youlost + #203, #57471
  static Youlost + #204, #57471
  static Youlost + #205, #57471
  static Youlost + #206, #57471
  static Youlost + #207, #57389
  static Youlost + #208, #57389
  static Youlost + #209, #57383
  static Youlost + #210, #57383
  static Youlost + #211, #57383
  static Youlost + #212, #57383
  static Youlost + #213, #57383
  static Youlost + #214, #57383
  static Youlost + #215, #57383
  static Youlost + #216, #57383
  static Youlost + #217, #57471
  static Youlost + #218, #57471
  static Youlost + #219, #57471
  static Youlost + #220, #57471
  static Youlost + #221, #57471
  static Youlost + #222, #57471
  static Youlost + #223, #57471
  static Youlost + #224, #57471
  static Youlost + #225, #57471
  static Youlost + #226, #57471
  static Youlost + #227, #57471
  static Youlost + #228, #57360
  static Youlost + #229, #57389
  static Youlost + #230, #57389
  static Youlost + #231, #57471
  static Youlost + #232, #57471
  static Youlost + #233, #57471
  static Youlost + #234, #57471
  static Youlost + #235, #57471
  static Youlost + #236, #57471
  static Youlost + #237, #57471
  static Youlost + #238, #57471
  static Youlost + #239, #57471

  ;Linha 6
  static Youlost + #240, #57471
  static Youlost + #241, #57350
  static Youlost + #242, #57471
  static Youlost + #243, #57471
  static Youlost + #244, #57471
  static Youlost + #245, #57363
  static Youlost + #246, #57439
  static Youlost + #247, #57383
  static Youlost + #248, #57383
  static Youlost + #249, #57383
  static Youlost + #250, #57383
  static Youlost + #251, #57383
  static Youlost + #252, #57471
  static Youlost + #253, #57471
  static Youlost + #254, #57359
  static Youlost + #255, #57471
  static Youlost + #256, #57471
  static Youlost + #257, #57471
  static Youlost + #258, #57471
  static Youlost + #259, #57471
  static Youlost + #260, #57471
  static Youlost + #261, #57471
  static Youlost + #262, #57471
  static Youlost + #263, #57471
  static Youlost + #264, #57471
  static Youlost + #265, #57471
  static Youlost + #266, #57471
  static Youlost + #267, #57471
  static Youlost + #268, #57471
  static Youlost + #269, #57471
  static Youlost + #270, #57471
  static Youlost + #271, #57439
  static Youlost + #272, #57471
  static Youlost + #273, #57471
  static Youlost + #274, #57471
  static Youlost + #275, #57471
  static Youlost + #276, #57471
  static Youlost + #277, #57471
  static Youlost + #278, #57471
  static Youlost + #279, #57471

  ;Linha 7
  static Youlost + #280, #57471
  static Youlost + #281, #57471
  static Youlost + #282, #57471
  static Youlost + #283, #57471
  static Youlost + #284, #57471
  static Youlost + #285, #57467
  static Youlost + #286, #57383
  static Youlost + #287, #57383
  static Youlost + #288, #57383
  static Youlost + #289, #57471
  static Youlost + #290, #57471
  static Youlost + #291, #57471
  static Youlost + #292, #57471
  static Youlost + #293, #57471
  static Youlost + #294, #57359
  static Youlost + #295, #57471
  static Youlost + #296, #57471
  static Youlost + #297, #57471
  static Youlost + #298, #57471
  static Youlost + #299, #57471
  static Youlost + #300, #57359
  static Youlost + #301, #57471
  static Youlost + #302, #57471
  static Youlost + #303, #57471
  static Youlost + #304, #57471
  static Youlost + #305, #57471
  static Youlost + #306, #57471
  static Youlost + #307, #57471
  static Youlost + #308, #57471
  static Youlost + #309, #57471
  static Youlost + #310, #57471
  static Youlost + #311, #57471
  static Youlost + #312, #57469
  static Youlost + #313, #57471
  static Youlost + #314, #57471
  static Youlost + #315, #57471
  static Youlost + #316, #57471
  static Youlost + #317, #57471
  static Youlost + #318, #57471
  static Youlost + #319, #57471

  ;Linha 8
  static Youlost + #320, #57471
  static Youlost + #321, #57354
  static Youlost + #322, #57471
  static Youlost + #323, #57471
  static Youlost + #324, #57471
  static Youlost + #325, #57468
  static Youlost + #326, #57383
  static Youlost + #327, #57383
  static Youlost + #328, #57471
  static Youlost + #329, #57471
  static Youlost + #330, #57471
  static Youlost + #331, #57471
  static Youlost + #332, #57471
  static Youlost + #333, #57430
  static Youlost + #334, #57423
  static Youlost + #335, #57411
  static Youlost + #336, #57413
  static Youlost + #337, #57471
  static Youlost + #338, #57424
  static Youlost + #339, #57413
  static Youlost + #340, #57426
  static Youlost + #341, #57412
  static Youlost + #342, #57413
  static Youlost + #343, #57429
  static Youlost + #344, #57377
  static Youlost + #345, #57471
  static Youlost + #346, #57471
  static Youlost + #347, #57471
  static Youlost + #348, #57471
  static Youlost + #349, #57471
  static Youlost + #350, #57471
  static Youlost + #351, #57471
  static Youlost + #352, #57468
  static Youlost + #353, #57471
  static Youlost + #354, #57471
  static Youlost + #355, #57471
  static Youlost + #356, #57471
  static Youlost + #357, #57471
  static Youlost + #358, #57471
  static Youlost + #359, #57471

  ;Linha 9
  static Youlost + #360, #57471
  static Youlost + #361, #57354
  static Youlost + #362, #57471
  static Youlost + #363, #57471
  static Youlost + #364, #57471
  static Youlost + #365, #57468
  static Youlost + #366, #57383
  static Youlost + #367, #57471
  static Youlost + #368, #57471
  static Youlost + #369, #57471
  static Youlost + #370, #57471
  static Youlost + #371, #57471
  static Youlost + #372, #57471
  static Youlost + #373, #57471
  static Youlost + #374, #57471
  static Youlost + #375, #57471
  static Youlost + #376, #57471
  static Youlost + #377, #57471
  static Youlost + #378, #57471
  static Youlost + #379, #57471
  static Youlost + #380, #57471
  static Youlost + #381, #57471
  static Youlost + #382, #57471
  static Youlost + #383, #57471
  static Youlost + #384, #57471
  static Youlost + #385, #57471
  static Youlost + #386, #57471
  static Youlost + #387, #57471
  static Youlost + #388, #57471
  static Youlost + #389, #57471
  static Youlost + #390, #57471
  static Youlost + #391, #57471
  static Youlost + #392, #57468
  static Youlost + #393, #57471
  static Youlost + #394, #57471
  static Youlost + #395, #57471
  static Youlost + #396, #57471
  static Youlost + #397, #57471
  static Youlost + #398, #57471
  static Youlost + #399, #57471

  ;Linha 10
  static Youlost + #400, #57354
  static Youlost + #401, #57471
  static Youlost + #402, #57471
  static Youlost + #403, #57471
  static Youlost + #404, #57471
  static Youlost + #405, #57471
  static Youlost + #406, #57436
  static Youlost + #407, #57471
  static Youlost + #408, #57471
  static Youlost + #409, #57471
  static Youlost + #410, #57471
  static Youlost + #411, #57471
  static Youlost + #412, #57471
  static Youlost + #413, #57471
  static Youlost + #414, #57471
  static Youlost + #415, #57471
  static Youlost + #416, #57471
  static Youlost + #417, #57471
  static Youlost + #418, #57471
  static Youlost + #419, #57471
  static Youlost + #420, #57471
  static Youlost + #421, #57471
  static Youlost + #422, #57471
  static Youlost + #423, #57471
  static Youlost + #424, #57471
  static Youlost + #425, #57471
  static Youlost + #426, #57471
  static Youlost + #427, #57471
  static Youlost + #428, #57471
  static Youlost + #429, #57471
  static Youlost + #430, #57471
  static Youlost + #431, #57391
  static Youlost + #432, #57471
  static Youlost + #433, #57471
  static Youlost + #434, #57471
  static Youlost + #435, #57471
  static Youlost + #436, #57471
  static Youlost + #437, #57471
  static Youlost + #438, #57471
  static Youlost + #439, #57471

  ;Linha 11
  static Youlost + #440, #57354
  static Youlost + #441, #57471
  static Youlost + #442, #57471
  static Youlost + #443, #57471
  static Youlost + #444, #57471
  static Youlost + #445, #57471
  static Youlost + #446, #57436
  static Youlost + #447, #57471
  static Youlost + #448, #57471
  static Youlost + #449, #57471
  static Youlost + #450, #57471
  static Youlost + #451, #57471
  static Youlost + #452, #57471
  static Youlost + #453, #57471
  static Youlost + #454, #57471
  static Youlost + #455, #57471
  static Youlost + #456, #57471
  static Youlost + #457, #57471
  static Youlost + #458, #57471
  static Youlost + #459, #57471
  static Youlost + #460, #57471
  static Youlost + #461, #57471
  static Youlost + #462, #57471
  static Youlost + #463, #57471
  static Youlost + #464, #57471
  static Youlost + #465, #57471
  static Youlost + #466, #57471
  static Youlost + #467, #57471
  static Youlost + #468, #57471
  static Youlost + #469, #57471
  static Youlost + #470, #57390
  static Youlost + #471, #57391
  static Youlost + #472, #57471
  static Youlost + #473, #57471
  static Youlost + #474, #57471
  static Youlost + #475, #57471
  static Youlost + #476, #57471
  static Youlost + #477, #57471
  static Youlost + #478, #57471
  static Youlost + #479, #57471

  ;Linha 12
  static Youlost + #480, #57471
  static Youlost + #481, #57471
  static Youlost + #482, #57471
  static Youlost + #483, #57471
  static Youlost + #484, #57471
  static Youlost + #485, #57471
  static Youlost + #486, #57471
  static Youlost + #487, #57389
  static Youlost + #488, #57389
  static Youlost + #489, #57471
  static Youlost + #490, #57471
  static Youlost + #491, #57471
  static Youlost + #492, #57471
  static Youlost + #493, #57471
  static Youlost + #494, #57471
  static Youlost + #495, #57471
  static Youlost + #496, #57471
  static Youlost + #497, #57471
  static Youlost + #498, #57471
  static Youlost + #499, #57471
  static Youlost + #500, #57471
  static Youlost + #501, #57471
  static Youlost + #502, #57471
  static Youlost + #503, #57471
  static Youlost + #504, #57471
  static Youlost + #505, #57471
  static Youlost + #506, #57471
  static Youlost + #507, #57471
  static Youlost + #508, #57389
  static Youlost + #509, #57389
  static Youlost + #510, #57471
  static Youlost + #511, #57471
  static Youlost + #512, #57471
  static Youlost + #513, #57471
  static Youlost + #514, #57471
  static Youlost + #515, #57471
  static Youlost + #516, #57471
  static Youlost + #517, #57471
  static Youlost + #518, #57471
  static Youlost + #519, #57471

  ;Linha 13
  static Youlost + #520, #57471
  static Youlost + #521, #57471
  static Youlost + #522, #57471
  static Youlost + #523, #57471
  static Youlost + #524, #57471
  static Youlost + #525, #57471
  static Youlost + #526, #57471
  static Youlost + #527, #57471
  static Youlost + #528, #57471
  static Youlost + #529, #57440
  static Youlost + #530, #57440
  static Youlost + #531, #57440
  static Youlost + #532, #57471
  static Youlost + #533, #57350
  static Youlost + #534, #57471
  static Youlost + #535, #57471
  static Youlost + #536, #57471
  static Youlost + #537, #57471
  static Youlost + #538, #57390
  static Youlost + #539, #57471
  static Youlost + #540, #57390
  static Youlost + #541, #57471
  static Youlost + #542, #57471
  static Youlost + #543, #57471
  static Youlost + #544, #57471
  static Youlost + #545, #57383
  static Youlost + #546, #57383
  static Youlost + #547, #57383
  static Youlost + #548, #57471
  static Youlost + #549, #57471
  static Youlost + #550, #57471
  static Youlost + #551, #57471
  static Youlost + #552, #57471
  static Youlost + #553, #57471
  static Youlost + #554, #57471
  static Youlost + #555, #57471
  static Youlost + #556, #57471
  static Youlost + #557, #57471
  static Youlost + #558, #57471
  static Youlost + #559, #57471

  ;Linha 14
  static Youlost + #560, #57471
  static Youlost + #561, #57471
  static Youlost + #562, #57471
  static Youlost + #563, #57471
  static Youlost + #564, #57471
  static Youlost + #565, #57471
  static Youlost + #566, #57471
  static Youlost + #567, #57471
  static Youlost + #568, #57471
  static Youlost + #569, #57471
  static Youlost + #570, #57471
  static Youlost + #571, #57471
  static Youlost + #572, #57389
  static Youlost + #573, #57389
  static Youlost + #574, #57390
  static Youlost + #575, #57471
  static Youlost + #576, #57390
  static Youlost + #577, #57471
  static Youlost + #578, #57388
  static Youlost + #579, #57471
  static Youlost + #580, #57468
  static Youlost + #581, #57364
  static Youlost + #582, #57390
  static Youlost + #583, #57389
  static Youlost + #584, #57389
  static Youlost + #585, #57471
  static Youlost + #586, #57471
  static Youlost + #587, #57471
  static Youlost + #588, #57471
  static Youlost + #589, #57471
  static Youlost + #590, #57471
  static Youlost + #591, #57471
  static Youlost + #592, #57471
  static Youlost + #593, #57471
  static Youlost + #594, #57471
  static Youlost + #595, #57471
  static Youlost + #596, #57471
  static Youlost + #597, #57471
  static Youlost + #598, #57471
  static Youlost + #599, #57471

  ;Linha 15
  static Youlost + #600, #57471
  static Youlost + #601, #57471
  static Youlost + #602, #57471
  static Youlost + #603, #57471
  static Youlost + #604, #57471
  static Youlost + #605, #57471
  static Youlost + #606, #57471
  static Youlost + #607, #57471
  static Youlost + #608, #57471
  static Youlost + #609, #57471
  static Youlost + #610, #57471
  static Youlost + #611, #57471
  static Youlost + #612, #57471
  static Youlost + #613, #57471
  static Youlost + #614, #57471
  static Youlost + #615, #57468
  static Youlost + #616, #57471
  static Youlost + #617, #57468
  static Youlost + #618, #57471
  static Youlost + #619, #57471
  static Youlost + #620, #57471
  static Youlost + #621, #57468
  static Youlost + #622, #57471
  static Youlost + #623, #57471
  static Youlost + #624, #57471
  static Youlost + #625, #57471
  static Youlost + #626, #57471
  static Youlost + #627, #57471
  static Youlost + #628, #57471
  static Youlost + #629, #57471
  static Youlost + #630, #57471
  static Youlost + #631, #57471
  static Youlost + #632, #57471
  static Youlost + #633, #57471
  static Youlost + #634, #57471
  static Youlost + #635, #57471
  static Youlost + #636, #57471
  static Youlost + #637, #57471
  static Youlost + #638, #57471
  static Youlost + #639, #57471

  ;Linha 16
  static Youlost + #640, #57471
  static Youlost + #641, #57471
  static Youlost + #642, #57471
  static Youlost + #643, #57471
  static Youlost + #644, #57471
  static Youlost + #645, #57471
  static Youlost + #646, #57471
  static Youlost + #647, #57471
  static Youlost + #648, #57471
  static Youlost + #649, #57471
  static Youlost + #650, #57471
  static Youlost + #651, #57471
  static Youlost + #652, #57471
  static Youlost + #653, #57471
  static Youlost + #654, #57471
  static Youlost + #655, #57468
  static Youlost + #656, #57471
  static Youlost + #657, #57468
  static Youlost + #658, #57471
  static Youlost + #659, #57358
  static Youlost + #660, #57471
  static Youlost + #661, #57468
  static Youlost + #662, #57471
  static Youlost + #663, #57471
  static Youlost + #664, #57471
  static Youlost + #665, #57471
  static Youlost + #666, #57471
  static Youlost + #667, #57471
  static Youlost + #668, #57471
  static Youlost + #669, #57471
  static Youlost + #670, #57471
  static Youlost + #671, #57471
  static Youlost + #672, #57471
  static Youlost + #673, #57471
  static Youlost + #674, #57471
  static Youlost + #675, #57471
  static Youlost + #676, #57471
  static Youlost + #677, #57471
  static Youlost + #678, #57471
  static Youlost + #679, #57471

  ;Linha 17
  static Youlost + #680, #57471
  static Youlost + #681, #57471
  static Youlost + #682, #57471
  static Youlost + #683, #57471
  static Youlost + #684, #57471
  static Youlost + #685, #57471
  static Youlost + #686, #57471
  static Youlost + #687, #57471
  static Youlost + #688, #57471
  static Youlost + #689, #57471
  static Youlost + #690, #57471
  static Youlost + #691, #57471
  static Youlost + #692, #57390
  static Youlost + #693, #57389
  static Youlost + #694, #57405
  static Youlost + #695, #57468
  static Youlost + #696, #57468
  static Youlost + #697, #57471
  static Youlost + #698, #57471
  static Youlost + #699, #57468
  static Youlost + #700, #57471
  static Youlost + #701, #57468
  static Youlost + #702, #57405
  static Youlost + #703, #57389
  static Youlost + #704, #57390
  static Youlost + #705, #57471
  static Youlost + #706, #57471
  static Youlost + #707, #57471
  static Youlost + #708, #57471
  static Youlost + #709, #57471
  static Youlost + #710, #57471
  static Youlost + #711, #57471
  static Youlost + #712, #57471
  static Youlost + #713, #57471
  static Youlost + #714, #57471
  static Youlost + #715, #57471
  static Youlost + #716, #57471
  static Youlost + #717, #57471
  static Youlost + #718, #57471
  static Youlost + #719, #57471

  ;Linha 18
  static Youlost + #720, #57471
  static Youlost + #721, #57471
  static Youlost + #722, #57471
  static Youlost + #723, #57471
  static Youlost + #724, #57471
  static Youlost + #725, #57471
  static Youlost + #726, #57471
  static Youlost + #727, #57471
  static Youlost + #728, #57471
  static Youlost + #729, #57471
  static Youlost + #730, #57471
  static Youlost + #731, #57440
  static Youlost + #732, #57354
  static Youlost + #733, #57471
  static Youlost + #734, #57471
  static Youlost + #735, #57468
  static Youlost + #736, #57468
  static Youlost + #737, #57471
  static Youlost + #738, #57471
  static Youlost + #739, #57468
  static Youlost + #740, #57471
  static Youlost + #741, #57468
  static Youlost + #742, #57471
  static Youlost + #743, #57471
  static Youlost + #744, #57468
  static Youlost + #745, #57471
  static Youlost + #746, #57471
  static Youlost + #747, #57471
  static Youlost + #748, #57471
  static Youlost + #749, #57471
  static Youlost + #750, #57471
  static Youlost + #751, #57471
  static Youlost + #752, #57471
  static Youlost + #753, #57471
  static Youlost + #754, #57471
  static Youlost + #755, #57471
  static Youlost + #756, #57471
  static Youlost + #757, #57471
  static Youlost + #758, #57471
  static Youlost + #759, #57471

  ;Linha 19
  static Youlost + #760, #57471
  static Youlost + #761, #57471
  static Youlost + #762, #57471
  static Youlost + #763, #57471
  static Youlost + #764, #57471
  static Youlost + #765, #57471
  static Youlost + #766, #57471
  static Youlost + #767, #57471
  static Youlost + #768, #57471
  static Youlost + #769, #57471
  static Youlost + #770, #57471
  static Youlost + #771, #57471
  static Youlost + #772, #57440
  static Youlost + #773, #57389
  static Youlost + #774, #57405
  static Youlost + #775, #57379
  static Youlost + #776, #57380
  static Youlost + #777, #57381
  static Youlost + #778, #57382
  static Youlost + #779, #57381
  static Youlost + #780, #57380
  static Youlost + #781, #57379
  static Youlost + #782, #57405
  static Youlost + #783, #57389
  static Youlost + #784, #57471
  static Youlost + #785, #57471
  static Youlost + #786, #57471
  static Youlost + #787, #57471
  static Youlost + #788, #57471
  static Youlost + #789, #57471
  static Youlost + #790, #57471
  static Youlost + #791, #57471
  static Youlost + #792, #57471
  static Youlost + #793, #57471
  static Youlost + #794, #57471
  static Youlost + #795, #57471
  static Youlost + #796, #57471
  static Youlost + #797, #57471
  static Youlost + #798, #57471
  static Youlost + #799, #57471

  ;Linha 20
  static Youlost + #800, #57471
  static Youlost + #801, #57471
  static Youlost + #802, #57471
  static Youlost + #803, #57471
  static Youlost + #804, #57471
  static Youlost + #805, #57471
  static Youlost + #806, #57471
  static Youlost + #807, #57471
  static Youlost + #808, #57471
  static Youlost + #809, #57471
  static Youlost + #810, #57471
  static Youlost + #811, #57471
  static Youlost + #812, #57471
  static Youlost + #813, #57471
  static Youlost + #814, #57471
  static Youlost + #815, #57468
  static Youlost + #816, #57471
  static Youlost + #817, #57471
  static Youlost + #818, #57471
  static Youlost + #819, #57471
  static Youlost + #820, #57352
  static Youlost + #821, #57468
  static Youlost + #822, #57471
  static Youlost + #823, #57471
  static Youlost + #824, #57471
  static Youlost + #825, #57471
  static Youlost + #826, #57471
  static Youlost + #827, #57471
  static Youlost + #828, #57471
  static Youlost + #829, #57471
  static Youlost + #830, #57471
  static Youlost + #831, #57471
  static Youlost + #832, #57471
  static Youlost + #833, #57471
  static Youlost + #834, #57471
  static Youlost + #835, #57471
  static Youlost + #836, #57471
  static Youlost + #837, #57471
  static Youlost + #838, #57471
  static Youlost + #839, #57471

  ;Linha 21
  static Youlost + #840, #57471
  static Youlost + #841, #57471
  static Youlost + #842, #57471
  static Youlost + #843, #57471
  static Youlost + #844, #57471
  static Youlost + #845, #57471
  static Youlost + #846, #57471
  static Youlost + #847, #57471
  static Youlost + #848, #57471
  static Youlost + #849, #57471
  static Youlost + #850, #57471
  static Youlost + #851, #57471
  static Youlost + #852, #57471
  static Youlost + #853, #57471
  static Youlost + #854, #57471
  static Youlost + #855, #57468
  static Youlost + #856, #57471
  static Youlost + #857, #57403
  static Youlost + #858, #57471
  static Youlost + #859, #57471
  static Youlost + #860, #57402
  static Youlost + #861, #57468
  static Youlost + #862, #57471
  static Youlost + #863, #57471
  static Youlost + #864, #57471
  static Youlost + #865, #57471
  static Youlost + #866, #57471
  static Youlost + #867, #57471
  static Youlost + #868, #57471
  static Youlost + #869, #57471
  static Youlost + #870, #57471
  static Youlost + #871, #57471
  static Youlost + #872, #57471
  static Youlost + #873, #57471
  static Youlost + #874, #57471
  static Youlost + #875, #57471
  static Youlost + #876, #57471
  static Youlost + #877, #57471
  static Youlost + #878, #57471
  static Youlost + #879, #57471

  ;Linha 22
  static Youlost + #880, #57471
  static Youlost + #881, #57471
  static Youlost + #882, #57471
  static Youlost + #883, #57471
  static Youlost + #884, #57471
  static Youlost + #885, #57471
  static Youlost + #886, #57439
  static Youlost + #887, #57439
  static Youlost + #888, #57439
  static Youlost + #889, #57439
  static Youlost + #890, #57439
  static Youlost + #891, #57390
  static Youlost + #892, #57388
  static Youlost + #893, #57389
  static Youlost + #894, #57379
  static Youlost + #895, #57381
  static Youlost + #896, #57382
  static Youlost + #897, #57380
  static Youlost + #898, #57408
  static Youlost + #899, #57381
  static Youlost + #900, #57379
  static Youlost + #901, #57382
  static Youlost + #902, #57379
  static Youlost + #903, #57470
  static Youlost + #904, #57388
  static Youlost + #905, #57390
  static Youlost + #906, #57439
  static Youlost + #907, #57439
  static Youlost + #908, #57439
  static Youlost + #909, #57439
  static Youlost + #910, #57439
  static Youlost + #911, #57471
  static Youlost + #912, #57471
  static Youlost + #913, #57471
  static Youlost + #914, #57471
  static Youlost + #915, #57471
  static Youlost + #916, #57471
  static Youlost + #917, #57471
  static Youlost + #918, #57471
  static Youlost + #919, #57471

  ;Linha 23
  static Youlost + #920, #57471
  static Youlost + #921, #57471
  static Youlost + #922, #57471
  static Youlost + #923, #57471
  static Youlost + #924, #57471
  static Youlost + #925, #57471
  static Youlost + #926, #57471
  static Youlost + #927, #57471
  static Youlost + #928, #57471
  static Youlost + #929, #57471
  static Youlost + #930, #57471
  static Youlost + #931, #57471
  static Youlost + #932, #57471
  static Youlost + #933, #57471
  static Youlost + #934, #57471
  static Youlost + #935, #57471
  static Youlost + #936, #57471
  static Youlost + #937, #57471
  static Youlost + #938, #57471
  static Youlost + #939, #57471
  static Youlost + #940, #57471
  static Youlost + #941, #57471
  static Youlost + #942, #57471
  static Youlost + #943, #57471
  static Youlost + #944, #57471
  static Youlost + #945, #57471
  static Youlost + #946, #57471
  static Youlost + #947, #57471
  static Youlost + #948, #57471
  static Youlost + #949, #57471
  static Youlost + #950, #57471
  static Youlost + #951, #57471
  static Youlost + #952, #57471
  static Youlost + #953, #57471
  static Youlost + #954, #57471
  static Youlost + #955, #57471
  static Youlost + #956, #57471
  static Youlost + #957, #57471
  static Youlost + #958, #57471
  static Youlost + #959, #57471

  ;Linha 24
  static Youlost + #960, #57471
  static Youlost + #961, #57471
  static Youlost + #962, #57471
  static Youlost + #963, #57471
  static Youlost + #964, #57471
  static Youlost + #965, #57471
  static Youlost + #966, #57471
  static Youlost + #967, #57471
  static Youlost + #968, #57471
  static Youlost + #969, #57359
  static Youlost + #970, #57359
  static Youlost + #971, #57359
  static Youlost + #972, #57359
  static Youlost + #973, #57471
  static Youlost + #974, #57359
  static Youlost + #975, #57359
  static Youlost + #976, #57359
  static Youlost + #977, #57359
  static Youlost + #978, #57471
  static Youlost + #979, #57359
  static Youlost + #980, #57471
  static Youlost + #981, #57471
  static Youlost + #982, #57471
  static Youlost + #983, #57471
  static Youlost + #984, #57471
  static Youlost + #985, #57471
  static Youlost + #986, #57471
  static Youlost + #987, #57471
  static Youlost + #988, #57471
  static Youlost + #989, #57471
  static Youlost + #990, #57471
  static Youlost + #991, #57471
  static Youlost + #992, #57471
  static Youlost + #993, #57471
  static Youlost + #994, #57471
  static Youlost + #995, #57471
  static Youlost + #996, #57471
  static Youlost + #997, #57471
  static Youlost + #998, #57471
  static Youlost + #999, #57471

  ;Linha 25
  static Youlost + #1000, #57471
  static Youlost + #1001, #57471
  static Youlost + #1002, #57471
  static Youlost + #1003, #57471
  static Youlost + #1004, #57471
  static Youlost + #1005, #57471
  static Youlost + #1006, #57428
  static Youlost + #1007, #57413
  static Youlost + #1008, #57422
  static Youlost + #1009, #57428
  static Youlost + #1010, #57409
  static Youlost + #1011, #57426
  static Youlost + #1012, #57369
  static Youlost + #1013, #57422
  static Youlost + #1014, #57423
  static Youlost + #1015, #57430
  static Youlost + #1016, #57409
  static Youlost + #1017, #57421
  static Youlost + #1018, #57413
  static Youlost + #1019, #57422
  static Youlost + #1020, #57428
  static Youlost + #1021, #57413
  static Youlost + #1022, #57471
  static Youlost + #1023, #57471
  static Youlost + #1024, #57471
  static Youlost + #1025, #57471
  static Youlost + #1026, #57360
  static Youlost + #1027, #57427
  static Youlost + #1028, #57409
  static Youlost + #1029, #57417
  static Youlost + #1030, #57426
  static Youlost + #1031, #57471
  static Youlost + #1032, #57471
  static Youlost + #1033, #57471
  static Youlost + #1034, #57471
  static Youlost + #1035, #57471
  static Youlost + #1036, #57471
  static Youlost + #1037, #57471
  static Youlost + #1038, #57471
  static Youlost + #1039, #57471

  ;Linha 26
  static Youlost + #1040, #57471
  static Youlost + #1041, #57471
  static Youlost + #1042, #57471
  static Youlost + #1043, #57471
  static Youlost + #1044, #57471
  static Youlost + #1045, #57471
  static Youlost + #1046, #57360
  static Youlost + #1047, #57369
  static Youlost + #1048, #57369
  static Youlost + #1049, #57369
  static Youlost + #1050, #57369
  static Youlost + #1051, #57369
  static Youlost + #1052, #57369
  static Youlost + #1053, #57369
  static Youlost + #1054, #57369
  static Youlost + #1055, #57369
  static Youlost + #1056, #57369
  static Youlost + #1057, #57369
  static Youlost + #1058, #57360
  static Youlost + #1059, #64526
  static Youlost + #1060, #57369
  static Youlost + #1061, #57369
  static Youlost + #1062, #57369
  static Youlost + #1063, #57369
  static Youlost + #1064, #57367
  static Youlost + #1065, #57355
  static Youlost + #1066, #57355
  static Youlost + #1067, #57355
  static Youlost + #1068, #57355
  static Youlost + #1069, #57355
  static Youlost + #1070, #57355
  static Youlost + #1071, #57471
  static Youlost + #1072, #57471
  static Youlost + #1073, #57471
  static Youlost + #1074, #57471
  static Youlost + #1075, #57471
  static Youlost + #1076, #57471
  static Youlost + #1077, #57471
  static Youlost + #1078, #57471
  static Youlost + #1079, #57471

  ;Linha 27
  static Youlost + #1080, #57471
  static Youlost + #1081, #57471
  static Youlost + #1082, #57471
  static Youlost + #1083, #57471
  static Youlost + #1084, #57471
  static Youlost + #1085, #57471
  static Youlost + #1086, #57471
  static Youlost + #1087, #64521
  static Youlost + #1088, #64521
  static Youlost + #1089, #64521
  static Youlost + #1090, #64592
  static Youlost + #1091, #64594
  static Youlost + #1092, #64581
  static Youlost + #1093, #64595
  static Youlost + #1094, #64595
  static Youlost + #1095, #64585
  static Youlost + #1096, #64591
  static Youlost + #1097, #64590
  static Youlost + #1098, #64581
  static Youlost + #1099, #64526
  static Youlost + #1100, #64526
  static Youlost + #1101, #64526
  static Youlost + #1102, #64526
  static Youlost + #1103, #57471
  static Youlost + #1104, #57471
  static Youlost + #1105, #63056
  static Youlost + #1106, #63058
  static Youlost + #1107, #63045
  static Youlost + #1108, #63059
  static Youlost + #1109, #63059
  static Youlost + #1110, #63049
  static Youlost + #1111, #63055
  static Youlost + #1112, #63054
  static Youlost + #1113, #63045
  static Youlost + #1114, #57471
  static Youlost + #1115, #57471
  static Youlost + #1116, #57471
  static Youlost + #1117, #57471
  static Youlost + #1118, #57471
  static Youlost + #1119, #57471

  ;Linha 28
  static Youlost + #1120, #57471
  static Youlost + #1121, #57471
  static Youlost + #1122, #57471
  static Youlost + #1123, #57471
  static Youlost + #1124, #57471
  static Youlost + #1125, #57471
  static Youlost + #1126, #57471
  static Youlost + #1127, #57471
  static Youlost + #1128, #57471
  static Youlost + #1129, #57359
  static Youlost + #1130, #57359
  static Youlost + #1131, #57471
  static Youlost + #1132, #64581
  static Youlost + #1133, #64590
  static Youlost + #1134, #64596
  static Youlost + #1135, #64581
  static Youlost + #1136, #64594
  static Youlost + #1137, #57359
  static Youlost + #1138, #57471
  static Youlost + #1139, #57471
  static Youlost + #1140, #57471
  static Youlost + #1141, #57471
  static Youlost + #1142, #57471
  static Youlost + #1143, #57471
  static Youlost + #1144, #57471
  static Youlost + #1145, #63042
  static Youlost + #1146, #63041
  static Youlost + #1147, #63043
  static Youlost + #1148, #63051
  static Youlost + #1149, #63059
  static Youlost + #1150, #63056
  static Youlost + #1151, #63041
  static Youlost + #1152, #63043
  static Youlost + #1153, #63045
  static Youlost + #1154, #57471
  static Youlost + #1155, #57471
  static Youlost + #1156, #57471
  static Youlost + #1157, #57471
  static Youlost + #1158, #57471
  static Youlost + #1159, #57471

  ;Linha 29
  static Youlost + #1160, #57471
  static Youlost + #1161, #57471
  static Youlost + #1162, #57471
  static Youlost + #1163, #57471
  static Youlost + #1164, #57471
  static Youlost + #1165, #57471
  static Youlost + #1166, #57471
  static Youlost + #1167, #57471
  static Youlost + #1168, #57471
  static Youlost + #1169, #57471
  static Youlost + #1170, #57471
  static Youlost + #1171, #57471
  static Youlost + #1172, #57471
  static Youlost + #1173, #57471
  static Youlost + #1174, #57471
  static Youlost + #1175, #57359
  static Youlost + #1176, #57471
  static Youlost + #1177, #57471
  static Youlost + #1178, #57471
  static Youlost + #1179, #57471
  static Youlost + #1180, #57471
  static Youlost + #1181, #57471
  static Youlost + #1182, #57471
  static Youlost + #1183, #57471
  static Youlost + #1184, #57471
  static Youlost + #1185, #57471
  static Youlost + #1186, #57471
  static Youlost + #1187, #57471
  static Youlost + #1188, #57471
  static Youlost + #1189, #57471
  static Youlost + #1190, #57471
  static Youlost + #1191, #57471
  static Youlost + #1192, #57471
  static Youlost + #1193, #57471
  static Youlost + #1194, #57471
  static Youlost + #1195, #57471
  static Youlost + #1196, #57471
  static Youlost + #1197, #57471
  static Youlost + #1198, #57471
  static Youlost + #1199, #57471

printYoulostScreen:
  push R0
  push R1
  push R2
  push R3

  loadn R0, #Youlost
  loadn R1, #0
  loadn R2, #1200

  printYoulostScreenLoop:

    add R3,R0,R1
    loadi R3, R3
    outchar R3, R1
    inc R1
    cmp R1, R2

    jne printYoulostScreenLoop

  pop R3
  pop R2
  pop R1
  pop R0
  rts