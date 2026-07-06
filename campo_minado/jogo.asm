;--------------------------- DADOS ------------------------------------

; tabuleiro
mapa:     var #266
; estado de cada celula ('0' escondida, '1' revelada, '2' bandeira)
revelado: var #266

; textos
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
    loadn r2, #2361        ; '9'(57) + vermelho(9*256)
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
    call printYoulostScreen  ; tela de derrota
fp_fim:
    load r0, seed_atual    ; muda o mapa da proxima partida
    loadn r1, #5
    add r0, r0, r1
    store seed_atual, r0
    call espera_espaco
    jmp main_reinicio



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
    outchar r3, r1
    inc r1
    add r4, r4, r5
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
    loadn r5, #42          ; '*'
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
    loadn r2, #2346        ; '*'(42) + vermelho(9*256)
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
    loadn r3, #2991        ; bandeira: char 175 do charmap + amarelo(11*256)
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
    outchar r2, r4         ; imprime o digito do mapa
    jmp as_fim
as_escondida:
    loadn r3, #42          ; '*'
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
    loadn r3, #2991        ; bandeira: char 175 do charmap + amarelo(11*256)
    outchar r3, r4
    jmp ab_fim
ab_desmarcar:
    load r3, bandeiras
    inc r3
    store bandeiras, r3
    loadn r3, #48
    storei r1, r3
    loadn r3, #42          ; volta a mostrar '*'
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

; TELA DE DERROTA 
Youlost : var #1200 

  static Youlost + #0, #127
  static Youlost + #1, #127
  static Youlost + #2, #2310
  static Youlost + #3, #127
  static Youlost + #4, #127
  static Youlost + #5, #127
  static Youlost + #6, #2310
  static Youlost + #7, #127
  static Youlost + #8, #127
  static Youlost + #9, #127
  static Youlost + #10, #2310
  static Youlost + #11, #2310
  static Youlost + #12, #2310
  static Youlost + #13, #127
  static Youlost + #14, #127
  static Youlost + #15, #127
  static Youlost + #16, #127
  static Youlost + #17, #127
  static Youlost + #18, #127
  static Youlost + #19, #127
  static Youlost + #20, #127
  static Youlost + #21, #127
  static Youlost + #22, #127
  static Youlost + #23, #127
  static Youlost + #24, #127
  static Youlost + #25, #127
  static Youlost + #26, #127
  static Youlost + #27, #127
  static Youlost + #28, #127
  static Youlost + #29, #127
  static Youlost + #30, #127
  static Youlost + #31, #127
  static Youlost + #32, #127
  static Youlost + #33, #127
  static Youlost + #34, #127
  static Youlost + #35, #127
  static Youlost + #36, #127
  static Youlost + #37, #127
  static Youlost + #38, #127
  static Youlost + #39, #127
 
  static Youlost + #40, #127
  static Youlost + #41, #2310
  static Youlost + #42, #2310
  static Youlost + #43, #127
  static Youlost + #44, #127
  static Youlost + #45, #2310
  static Youlost + #46, #2310
  static Youlost + #47, #2310
  static Youlost + #48, #2310
  static Youlost + #49, #2310
  static Youlost + #50, #2310
  static Youlost + #51, #127
  static Youlost + #52, #127
  static Youlost + #53, #127
  static Youlost + #54, #127
  static Youlost + #55, #127
  static Youlost + #56, #127
  static Youlost + #57, #127
  static Youlost + #58, #127
  static Youlost + #59, #127
  static Youlost + #60, #127
  static Youlost + #61, #127
  static Youlost + #62, #127
  static Youlost + #63, #127
  static Youlost + #64, #127
  static Youlost + #65, #127
  static Youlost + #66, #127
  static Youlost + #67, #127
  static Youlost + #68, #127
  static Youlost + #69, #127
  static Youlost + #70, #127
  static Youlost + #71, #127
  static Youlost + #72, #127
  static Youlost + #73, #127
  static Youlost + #74, #127
  static Youlost + #75, #127
  static Youlost + #76, #127
  static Youlost + #77, #127
  static Youlost + #78, #127
  static Youlost + #79, #127
 
  static Youlost + #80, #2310
  static Youlost + #81, #2310
  static Youlost + #82, #2310
  static Youlost + #83, #2310
  static Youlost + #84, #127
  static Youlost + #85, #2310
  static Youlost + #86, #2310
  static Youlost + #87, #2310
  static Youlost + #88, #127
  static Youlost + #89, #127
  static Youlost + #90, #127
  static Youlost + #91, #127
  static Youlost + #92, #127
  static Youlost + #93, #127
  static Youlost + #94, #127
  static Youlost + #95, #127
  static Youlost + #96, #127
  static Youlost + #97, #127
  static Youlost + #98, #127
  static Youlost + #99, #127
  static Youlost + #100, #127
  static Youlost + #101, #127
  static Youlost + #102, #127
  static Youlost + #103, #127
  static Youlost + #104, #127
  static Youlost + #105, #127
  static Youlost + #106, #127
  static Youlost + #107, #127
  static Youlost + #108, #127
  static Youlost + #109, #127
  static Youlost + #110, #127
  static Youlost + #111, #127
  static Youlost + #112, #127
  static Youlost + #113, #127
  static Youlost + #114, #127
  static Youlost + #115, #127
  static Youlost + #116, #127
  static Youlost + #117, #127
  static Youlost + #118, #127
  static Youlost + #119, #127
 
  static Youlost + #120, #127
  static Youlost + #121, #2310
  static Youlost + #122, #2310
  static Youlost + #123, #2310
  static Youlost + #124, #2310
  static Youlost + #125, #127
  static Youlost + #126, #127
  static Youlost + #127, #127
  static Youlost + #128, #127
  static Youlost + #129, #127
  static Youlost + #130, #2314
  static Youlost + #131, #2350
  static Youlost + #132, #2347
  static Youlost + #133, #2349
  static Youlost + #134, #2349
  static Youlost + #135, #2349
  static Youlost + #136, #2350
  static Youlost + #137, #2350
  static Youlost + #138, #2350
  static Youlost + #139, #2350
  static Youlost + #140, #2348
  static Youlost + #141, #2348
  static Youlost + #142, #2349
  static Youlost + #143, #2349
  static Youlost + #144, #2347
  static Youlost + #145, #2350
  static Youlost + #146, #127
  static Youlost + #147, #127
  static Youlost + #148, #127
  static Youlost + #149, #127
  static Youlost + #150, #127
  static Youlost + #151, #127
  static Youlost + #152, #127
  static Youlost + #153, #127
  static Youlost + #154, #127
  static Youlost + #155, #127
  static Youlost + #156, #127
  static Youlost + #157, #127
  static Youlost + #158, #127
  static Youlost + #159, #127
 
  static Youlost + #160, #2310
  static Youlost + #161, #2310
  static Youlost + #162, #2310
  static Youlost + #163, #127
  static Youlost + #164, #127
  static Youlost + #165, #127
  static Youlost + #166, #127
  static Youlost + #167, #127
  static Youlost + #168, #127
  static Youlost + #169, #2350
  static Youlost + #170, #2349
  static Youlost + #171, #2343
  static Youlost + #172, #2343
  static Youlost + #173, #2343
  static Youlost + #174, #2343
  static Youlost + #175, #2343
  static Youlost + #176, #2343
  static Youlost + #177, #2343
  static Youlost + #178, #2343
  static Youlost + #179, #2343
  static Youlost + #180, #127
  static Youlost + #181, #127
  static Youlost + #182, #127
  static Youlost + #183, #127
  static Youlost + #184, #127
  static Youlost + #185, #2319
  static Youlost + #186, #2398
  static Youlost + #187, #2398
  static Youlost + #188, #2350
  static Youlost + #189, #127
  static Youlost + #190, #127
  static Youlost + #191, #127
  static Youlost + #192, #127
  static Youlost + #193, #127
  static Youlost + #194, #127
  static Youlost + #195, #127
  static Youlost + #196, #127
  static Youlost + #197, #127
  static Youlost + #198, #127
  static Youlost + #199, #127
 
  static Youlost + #200, #2310
  static Youlost + #201, #2310
  static Youlost + #202, #127
  static Youlost + #203, #127
  static Youlost + #204, #127
  static Youlost + #205, #127
  static Youlost + #206, #127
  static Youlost + #207, #2349
  static Youlost + #208, #2349
  static Youlost + #209, #2343
  static Youlost + #210, #2343
  static Youlost + #211, #2343
  static Youlost + #212, #2343
  static Youlost + #213, #2343
  static Youlost + #214, #2343
  static Youlost + #215, #2343
  static Youlost + #216, #2343
  static Youlost + #217, #127
  static Youlost + #218, #127
  static Youlost + #219, #127
  static Youlost + #220, #127
  static Youlost + #221, #127
  static Youlost + #222, #127
  static Youlost + #223, #127
  static Youlost + #224, #127
  static Youlost + #225, #127
  static Youlost + #226, #127
  static Youlost + #227, #127
  static Youlost + #228, #2320
  static Youlost + #229, #2349
  static Youlost + #230, #2349
  static Youlost + #231, #127
  static Youlost + #232, #127
  static Youlost + #233, #127
  static Youlost + #234, #127
  static Youlost + #235, #127
  static Youlost + #236, #127
  static Youlost + #237, #127
  static Youlost + #238, #127
  static Youlost + #239, #127
 
  static Youlost + #240, #127
  static Youlost + #241, #2310
  static Youlost + #242, #127
  static Youlost + #243, #127
  static Youlost + #244, #127
  static Youlost + #245, #2323
  static Youlost + #246, #2399
  static Youlost + #247, #2343
  static Youlost + #248, #2343
  static Youlost + #249, #2343
  static Youlost + #250, #2343
  static Youlost + #251, #2343
  static Youlost + #252, #127
  static Youlost + #253, #127
  static Youlost + #254, #2319
  static Youlost + #255, #127
  static Youlost + #256, #127
  static Youlost + #257, #127
  static Youlost + #258, #127
  static Youlost + #259, #127
  static Youlost + #260, #127
  static Youlost + #261, #127
  static Youlost + #262, #127
  static Youlost + #263, #127
  static Youlost + #264, #127
  static Youlost + #265, #127
  static Youlost + #266, #127
  static Youlost + #267, #127
  static Youlost + #268, #127
  static Youlost + #269, #127
  static Youlost + #270, #127
  static Youlost + #271, #2399
  static Youlost + #272, #127
  static Youlost + #273, #127
  static Youlost + #274, #127
  static Youlost + #275, #127
  static Youlost + #276, #127
  static Youlost + #277, #127
  static Youlost + #278, #127
  static Youlost + #279, #127
 
  static Youlost + #280, #127
  static Youlost + #281, #127
  static Youlost + #282, #127
  static Youlost + #283, #127
  static Youlost + #284, #127
  static Youlost + #285, #2427
  static Youlost + #286, #2343
  static Youlost + #287, #2343
  static Youlost + #288, #2343
  static Youlost + #289, #127
  static Youlost + #290, #127
  static Youlost + #291, #127
  static Youlost + #292, #127
  static Youlost + #293, #127
  static Youlost + #294, #2319
  static Youlost + #295, #127
  static Youlost + #296, #127
  static Youlost + #297, #127
  static Youlost + #298, #127
  static Youlost + #299, #127
  static Youlost + #300, #2319
  static Youlost + #301, #127
  static Youlost + #302, #127
  static Youlost + #303, #127
  static Youlost + #304, #127
  static Youlost + #305, #127
  static Youlost + #306, #127
  static Youlost + #307, #127
  static Youlost + #308, #127
  static Youlost + #309, #127
  static Youlost + #310, #127
  static Youlost + #311, #127
  static Youlost + #312, #2429
  static Youlost + #313, #127
  static Youlost + #314, #127
  static Youlost + #315, #127
  static Youlost + #316, #127
  static Youlost + #317, #127
  static Youlost + #318, #127
  static Youlost + #319, #127
 
  static Youlost + #320, #127
  static Youlost + #321, #2314
  static Youlost + #322, #127
  static Youlost + #323, #127
  static Youlost + #324, #127
  static Youlost + #325, #2428
  static Youlost + #326, #2343
  static Youlost + #327, #2343
  static Youlost + #328, #127
  static Youlost + #329, #127
  static Youlost + #330, #127
  static Youlost + #331, #127
  static Youlost + #332, #127
  static Youlost + #333, #2390
  static Youlost + #334, #2383
  static Youlost + #335, #2371
  static Youlost + #336, #2373
  static Youlost + #337, #127
  static Youlost + #338, #2384
  static Youlost + #339, #2373
  static Youlost + #340, #2386
  static Youlost + #341, #2372
  static Youlost + #342, #2373
  static Youlost + #343, #2389
  static Youlost + #344, #2337
  static Youlost + #345, #127
  static Youlost + #346, #127
  static Youlost + #347, #127
  static Youlost + #348, #127
  static Youlost + #349, #127
  static Youlost + #350, #127
  static Youlost + #351, #127
  static Youlost + #352, #2428
  static Youlost + #353, #127
  static Youlost + #354, #127
  static Youlost + #355, #127
  static Youlost + #356, #127
  static Youlost + #357, #127
  static Youlost + #358, #127
  static Youlost + #359, #127
 
  static Youlost + #360, #127
  static Youlost + #361, #2314
  static Youlost + #362, #127
  static Youlost + #363, #127
  static Youlost + #364, #127
  static Youlost + #365, #2428
  static Youlost + #366, #2343
  static Youlost + #367, #127
  static Youlost + #368, #127
  static Youlost + #369, #127
  static Youlost + #370, #127
  static Youlost + #371, #127
  static Youlost + #372, #127
  static Youlost + #373, #127
  static Youlost + #374, #127
  static Youlost + #375, #127
  static Youlost + #376, #127
  static Youlost + #377, #127
  static Youlost + #378, #127
  static Youlost + #379, #127
  static Youlost + #380, #127
  static Youlost + #381, #127
  static Youlost + #382, #127
  static Youlost + #383, #127
  static Youlost + #384, #127
  static Youlost + #385, #127
  static Youlost + #386, #127
  static Youlost + #387, #127
  static Youlost + #388, #127
  static Youlost + #389, #127
  static Youlost + #390, #127
  static Youlost + #391, #127
  static Youlost + #392, #2428
  static Youlost + #393, #127
  static Youlost + #394, #127
  static Youlost + #395, #127
  static Youlost + #396, #127
  static Youlost + #397, #127
  static Youlost + #398, #127
  static Youlost + #399, #127
 
  static Youlost + #400, #2314
  static Youlost + #401, #127
  static Youlost + #402, #127
  static Youlost + #403, #127
  static Youlost + #404, #127
  static Youlost + #405, #127
  static Youlost + #406, #2396
  static Youlost + #407, #127
  static Youlost + #408, #127
  static Youlost + #409, #127
  static Youlost + #410, #127
  static Youlost + #411, #127
  static Youlost + #412, #127
  static Youlost + #413, #127
  static Youlost + #414, #127
  static Youlost + #415, #127
  static Youlost + #416, #127
  static Youlost + #417, #127
  static Youlost + #418, #127
  static Youlost + #419, #127
  static Youlost + #420, #127
  static Youlost + #421, #127
  static Youlost + #422, #127
  static Youlost + #423, #127
  static Youlost + #424, #127
  static Youlost + #425, #127
  static Youlost + #426, #127
  static Youlost + #427, #127
  static Youlost + #428, #127
  static Youlost + #429, #127
  static Youlost + #430, #127
  static Youlost + #431, #2351
  static Youlost + #432, #127
  static Youlost + #433, #127
  static Youlost + #434, #127
  static Youlost + #435, #127
  static Youlost + #436, #127
  static Youlost + #437, #127
  static Youlost + #438, #127
  static Youlost + #439, #127
 
  static Youlost + #440, #2314
  static Youlost + #441, #127
  static Youlost + #442, #127
  static Youlost + #443, #127
  static Youlost + #444, #127
  static Youlost + #445, #127
  static Youlost + #446, #2396
  static Youlost + #447, #127
  static Youlost + #448, #127
  static Youlost + #449, #127
  static Youlost + #450, #127
  static Youlost + #451, #127
  static Youlost + #452, #127
  static Youlost + #453, #127
  static Youlost + #454, #127
  static Youlost + #455, #127
  static Youlost + #456, #127
  static Youlost + #457, #127
  static Youlost + #458, #127
  static Youlost + #459, #127
  static Youlost + #460, #127
  static Youlost + #461, #127
  static Youlost + #462, #127
  static Youlost + #463, #127
  static Youlost + #464, #127
  static Youlost + #465, #127
  static Youlost + #466, #127
  static Youlost + #467, #127
  static Youlost + #468, #127
  static Youlost + #469, #127
  static Youlost + #470, #2350
  static Youlost + #471, #2351
  static Youlost + #472, #127
  static Youlost + #473, #127
  static Youlost + #474, #127
  static Youlost + #475, #127
  static Youlost + #476, #127
  static Youlost + #477, #127
  static Youlost + #478, #127
  static Youlost + #479, #127
 
  static Youlost + #480, #127
  static Youlost + #481, #127
  static Youlost + #482, #127
  static Youlost + #483, #127
  static Youlost + #484, #127
  static Youlost + #485, #127
  static Youlost + #486, #127
  static Youlost + #487, #2349
  static Youlost + #488, #2349
  static Youlost + #489, #127
  static Youlost + #490, #127
  static Youlost + #491, #127
  static Youlost + #492, #127
  static Youlost + #493, #127
  static Youlost + #494, #127
  static Youlost + #495, #127
  static Youlost + #496, #127
  static Youlost + #497, #127
  static Youlost + #498, #127
  static Youlost + #499, #127
  static Youlost + #500, #127
  static Youlost + #501, #127
  static Youlost + #502, #127
  static Youlost + #503, #127
  static Youlost + #504, #127
  static Youlost + #505, #127
  static Youlost + #506, #127
  static Youlost + #507, #127
  static Youlost + #508, #2349
  static Youlost + #509, #2349
  static Youlost + #510, #127
  static Youlost + #511, #127
  static Youlost + #512, #127
  static Youlost + #513, #127
  static Youlost + #514, #127
  static Youlost + #515, #127
  static Youlost + #516, #127
  static Youlost + #517, #127
  static Youlost + #518, #127
  static Youlost + #519, #127
 
  static Youlost + #520, #127
  static Youlost + #521, #127
  static Youlost + #522, #127
  static Youlost + #523, #127
  static Youlost + #524, #127
  static Youlost + #525, #127
  static Youlost + #526, #127
  static Youlost + #527, #127
  static Youlost + #528, #127
  static Youlost + #529, #2400
  static Youlost + #530, #2400
  static Youlost + #531, #2400
  static Youlost + #532, #127
  static Youlost + #533, #2310
  static Youlost + #534, #127
  static Youlost + #535, #127
  static Youlost + #536, #127
  static Youlost + #537, #127
  static Youlost + #538, #2350
  static Youlost + #539, #127
  static Youlost + #540, #2350
  static Youlost + #541, #127
  static Youlost + #542, #127
  static Youlost + #543, #127
  static Youlost + #544, #127
  static Youlost + #545, #2343
  static Youlost + #546, #2343
  static Youlost + #547, #2343
  static Youlost + #548, #127
  static Youlost + #549, #127
  static Youlost + #550, #127
  static Youlost + #551, #127
  static Youlost + #552, #127
  static Youlost + #553, #127
  static Youlost + #554, #127
  static Youlost + #555, #127
  static Youlost + #556, #127
  static Youlost + #557, #127
  static Youlost + #558, #127
  static Youlost + #559, #127

  static Youlost + #560, #127
  static Youlost + #561, #127
  static Youlost + #562, #127
  static Youlost + #563, #127
  static Youlost + #564, #127
  static Youlost + #565, #127
  static Youlost + #566, #127
  static Youlost + #567, #127
  static Youlost + #568, #127
  static Youlost + #569, #127
  static Youlost + #570, #127
  static Youlost + #571, #127
  static Youlost + #572, #2349
  static Youlost + #573, #2349
  static Youlost + #574, #2350
  static Youlost + #575, #127
  static Youlost + #576, #2350
  static Youlost + #577, #127
  static Youlost + #578, #2348
  static Youlost + #579, #127
  static Youlost + #580, #2428
  static Youlost + #581, #2324
  static Youlost + #582, #2350
  static Youlost + #583, #2349
  static Youlost + #584, #2349
  static Youlost + #585, #127
  static Youlost + #586, #127
  static Youlost + #587, #127
  static Youlost + #588, #127
  static Youlost + #589, #127
  static Youlost + #590, #127
  static Youlost + #591, #127
  static Youlost + #592, #127
  static Youlost + #593, #127
  static Youlost + #594, #127
  static Youlost + #595, #127
  static Youlost + #596, #127
  static Youlost + #597, #127
  static Youlost + #598, #127
  static Youlost + #599, #127
 
  static Youlost + #600, #127
  static Youlost + #601, #127
  static Youlost + #602, #127
  static Youlost + #603, #127
  static Youlost + #604, #127
  static Youlost + #605, #127
  static Youlost + #606, #127
  static Youlost + #607, #127
  static Youlost + #608, #127
  static Youlost + #609, #127
  static Youlost + #610, #127
  static Youlost + #611, #127
  static Youlost + #612, #127
  static Youlost + #613, #127
  static Youlost + #614, #127
  static Youlost + #615, #2428
  static Youlost + #616, #127
  static Youlost + #617, #2428
  static Youlost + #618, #127
  static Youlost + #619, #127
  static Youlost + #620, #127
  static Youlost + #621, #2428
  static Youlost + #622, #127
  static Youlost + #623, #127
  static Youlost + #624, #127
  static Youlost + #625, #127
  static Youlost + #626, #127
  static Youlost + #627, #127
  static Youlost + #628, #127
  static Youlost + #629, #127
  static Youlost + #630, #127
  static Youlost + #631, #127
  static Youlost + #632, #127
  static Youlost + #633, #127
  static Youlost + #634, #127
  static Youlost + #635, #127
  static Youlost + #636, #127
  static Youlost + #637, #127
  static Youlost + #638, #127
  static Youlost + #639, #127
 
  static Youlost + #640, #127
  static Youlost + #641, #127
  static Youlost + #642, #127
  static Youlost + #643, #127
  static Youlost + #644, #127
  static Youlost + #645, #127
  static Youlost + #646, #127
  static Youlost + #647, #127
  static Youlost + #648, #127
  static Youlost + #649, #127
  static Youlost + #650, #127
  static Youlost + #651, #127
  static Youlost + #652, #127
  static Youlost + #653, #127
  static Youlost + #654, #127
  static Youlost + #655, #2428
  static Youlost + #656, #127
  static Youlost + #657, #2428
  static Youlost + #658, #127
  static Youlost + #659, #2318
  static Youlost + #660, #127
  static Youlost + #661, #2428
  static Youlost + #662, #127
  static Youlost + #663, #127
  static Youlost + #664, #127
  static Youlost + #665, #127
  static Youlost + #666, #127
  static Youlost + #667, #127
  static Youlost + #668, #127
  static Youlost + #669, #127
  static Youlost + #670, #127
  static Youlost + #671, #127
  static Youlost + #672, #127
  static Youlost + #673, #127
  static Youlost + #674, #127
  static Youlost + #675, #127
  static Youlost + #676, #127
  static Youlost + #677, #127
  static Youlost + #678, #127
  static Youlost + #679, #127
 
  static Youlost + #680, #127
  static Youlost + #681, #127
  static Youlost + #682, #127
  static Youlost + #683, #127
  static Youlost + #684, #127
  static Youlost + #685, #127
  static Youlost + #686, #127
  static Youlost + #687, #127
  static Youlost + #688, #127
  static Youlost + #689, #127
  static Youlost + #690, #127
  static Youlost + #691, #127
  static Youlost + #692, #2350
  static Youlost + #693, #2349
  static Youlost + #694, #2365
  static Youlost + #695, #2428
  static Youlost + #696, #2428
  static Youlost + #697, #127
  static Youlost + #698, #127
  static Youlost + #699, #2428
  static Youlost + #700, #127
  static Youlost + #701, #2428
  static Youlost + #702, #2365
  static Youlost + #703, #2349
  static Youlost + #704, #2350
  static Youlost + #705, #127
  static Youlost + #706, #127
  static Youlost + #707, #127
  static Youlost + #708, #127
  static Youlost + #709, #127
  static Youlost + #710, #127
  static Youlost + #711, #127
  static Youlost + #712, #127
  static Youlost + #713, #127
  static Youlost + #714, #127
  static Youlost + #715, #127
  static Youlost + #716, #127
  static Youlost + #717, #127
  static Youlost + #718, #127
  static Youlost + #719, #127
 
  static Youlost + #720, #127
  static Youlost + #721, #127
  static Youlost + #722, #127
  static Youlost + #723, #127
  static Youlost + #724, #127
  static Youlost + #725, #127
  static Youlost + #726, #127
  static Youlost + #727, #127
  static Youlost + #728, #127
  static Youlost + #729, #127
  static Youlost + #730, #127
  static Youlost + #731, #2400
  static Youlost + #732, #2314
  static Youlost + #733, #127
  static Youlost + #734, #127
  static Youlost + #735, #2428
  static Youlost + #736, #2428
  static Youlost + #737, #127
  static Youlost + #738, #127
  static Youlost + #739, #2428
  static Youlost + #740, #127
  static Youlost + #741, #2428
  static Youlost + #742, #127
  static Youlost + #743, #127
  static Youlost + #744, #2428
  static Youlost + #745, #127
  static Youlost + #746, #127
  static Youlost + #747, #127
  static Youlost + #748, #127
  static Youlost + #749, #127
  static Youlost + #750, #127
  static Youlost + #751, #127
  static Youlost + #752, #127
  static Youlost + #753, #127
  static Youlost + #754, #127
  static Youlost + #755, #127
  static Youlost + #756, #127
  static Youlost + #757, #127
  static Youlost + #758, #127
  static Youlost + #759, #127
 
  static Youlost + #760, #127
  static Youlost + #761, #127
  static Youlost + #762, #127
  static Youlost + #763, #127
  static Youlost + #764, #127
  static Youlost + #765, #127
  static Youlost + #766, #127
  static Youlost + #767, #127
  static Youlost + #768, #127
  static Youlost + #769, #127
  static Youlost + #770, #127
  static Youlost + #771, #127
  static Youlost + #772, #2400
  static Youlost + #773, #2349
  static Youlost + #774, #2365
  static Youlost + #775, #2339
  static Youlost + #776, #2340
  static Youlost + #777, #2341
  static Youlost + #778, #2342
  static Youlost + #779, #2341
  static Youlost + #780, #2340
  static Youlost + #781, #2339
  static Youlost + #782, #2365
  static Youlost + #783, #2349
  static Youlost + #784, #127
  static Youlost + #785, #127
  static Youlost + #786, #127
  static Youlost + #787, #127
  static Youlost + #788, #127
  static Youlost + #789, #127
  static Youlost + #790, #127
  static Youlost + #791, #127
  static Youlost + #792, #127
  static Youlost + #793, #127
  static Youlost + #794, #127
  static Youlost + #795, #127
  static Youlost + #796, #127
  static Youlost + #797, #127
  static Youlost + #798, #127
  static Youlost + #799, #127
 
  static Youlost + #800, #127
  static Youlost + #801, #127
  static Youlost + #802, #127
  static Youlost + #803, #127
  static Youlost + #804, #127
  static Youlost + #805, #127
  static Youlost + #806, #127
  static Youlost + #807, #127
  static Youlost + #808, #127
  static Youlost + #809, #127
  static Youlost + #810, #127
  static Youlost + #811, #127
  static Youlost + #812, #127
  static Youlost + #813, #127
  static Youlost + #814, #127
  static Youlost + #815, #2428
  static Youlost + #816, #127
  static Youlost + #817, #127
  static Youlost + #818, #127
  static Youlost + #819, #127
  static Youlost + #820, #2312
  static Youlost + #821, #2428
  static Youlost + #822, #127
  static Youlost + #823, #127
  static Youlost + #824, #127
  static Youlost + #825, #127
  static Youlost + #826, #127
  static Youlost + #827, #127
  static Youlost + #828, #127
  static Youlost + #829, #127
  static Youlost + #830, #127
  static Youlost + #831, #127
  static Youlost + #832, #127
  static Youlost + #833, #127
  static Youlost + #834, #127
  static Youlost + #835, #127
  static Youlost + #836, #127
  static Youlost + #837, #127
  static Youlost + #838, #127
  static Youlost + #839, #127
 
  static Youlost + #840, #127
  static Youlost + #841, #127
  static Youlost + #842, #127
  static Youlost + #843, #127
  static Youlost + #844, #127
  static Youlost + #845, #127
  static Youlost + #846, #127
  static Youlost + #847, #127
  static Youlost + #848, #127
  static Youlost + #849, #127
  static Youlost + #850, #127
  static Youlost + #851, #127
  static Youlost + #852, #127
  static Youlost + #853, #127
  static Youlost + #854, #127
  static Youlost + #855, #2428
  static Youlost + #856, #127
  static Youlost + #857, #2363
  static Youlost + #858, #127
  static Youlost + #859, #127
  static Youlost + #860, #2362
  static Youlost + #861, #2428
  static Youlost + #862, #127
  static Youlost + #863, #127
  static Youlost + #864, #127
  static Youlost + #865, #127
  static Youlost + #866, #127
  static Youlost + #867, #127
  static Youlost + #868, #127
  static Youlost + #869, #127
  static Youlost + #870, #127
  static Youlost + #871, #127
  static Youlost + #872, #127
  static Youlost + #873, #127
  static Youlost + #874, #127
  static Youlost + #875, #127
  static Youlost + #876, #127
  static Youlost + #877, #127
  static Youlost + #878, #127
  static Youlost + #879, #127
 
  static Youlost + #880, #127
  static Youlost + #881, #127
  static Youlost + #882, #127
  static Youlost + #883, #127
  static Youlost + #884, #127
  static Youlost + #885, #127
  static Youlost + #886, #2399
  static Youlost + #887, #2399
  static Youlost + #888, #2399
  static Youlost + #889, #2399
  static Youlost + #890, #2399
  static Youlost + #891, #2350
  static Youlost + #892, #2348
  static Youlost + #893, #2349
  static Youlost + #894, #2339
  static Youlost + #895, #2341
  static Youlost + #896, #2342
  static Youlost + #897, #2340
  static Youlost + #898, #2368
  static Youlost + #899, #2341
  static Youlost + #900, #2339
  static Youlost + #901, #2342
  static Youlost + #902, #2339
  static Youlost + #903, #2430
  static Youlost + #904, #2348
  static Youlost + #905, #2350
  static Youlost + #906, #2399
  static Youlost + #907, #2399
  static Youlost + #908, #2399
  static Youlost + #909, #2399
  static Youlost + #910, #2399
  static Youlost + #911, #127
  static Youlost + #912, #127
  static Youlost + #913, #127
  static Youlost + #914, #127
  static Youlost + #915, #127
  static Youlost + #916, #127
  static Youlost + #917, #127
  static Youlost + #918, #127
  static Youlost + #919, #127
 
  static Youlost + #920, #127
  static Youlost + #921, #127
  static Youlost + #922, #127
  static Youlost + #923, #127
  static Youlost + #924, #127
  static Youlost + #925, #127
  static Youlost + #926, #127
  static Youlost + #927, #127
  static Youlost + #928, #127
  static Youlost + #929, #127
  static Youlost + #930, #127
  static Youlost + #931, #127
  static Youlost + #932, #127
  static Youlost + #933, #127
  static Youlost + #934, #127
  static Youlost + #935, #127
  static Youlost + #936, #127
  static Youlost + #937, #127
  static Youlost + #938, #127
  static Youlost + #939, #127
  static Youlost + #940, #127
  static Youlost + #941, #127
  static Youlost + #942, #127
  static Youlost + #943, #127
  static Youlost + #944, #127
  static Youlost + #945, #127
  static Youlost + #946, #127
  static Youlost + #947, #127
  static Youlost + #948, #127
  static Youlost + #949, #127
  static Youlost + #950, #127
  static Youlost + #951, #127
  static Youlost + #952, #127
  static Youlost + #953, #127
  static Youlost + #954, #127
  static Youlost + #955, #127
  static Youlost + #956, #127
  static Youlost + #957, #127
  static Youlost + #958, #127
  static Youlost + #959, #127
 
  static Youlost + #960, #127
  static Youlost + #961, #127
  static Youlost + #962, #127
  static Youlost + #963, #127
  static Youlost + #964, #127
  static Youlost + #965, #127
  static Youlost + #966, #127
  static Youlost + #967, #127
  static Youlost + #968, #127
  static Youlost + #969, #2319
  static Youlost + #970, #2319
  static Youlost + #971, #2319
  static Youlost + #972, #2319
  static Youlost + #973, #127
  static Youlost + #974, #2319
  static Youlost + #975, #2319
  static Youlost + #976, #2319
  static Youlost + #977, #2319
  static Youlost + #978, #127
  static Youlost + #979, #2319
  static Youlost + #980, #127
  static Youlost + #981, #127
  static Youlost + #982, #127
  static Youlost + #983, #127
  static Youlost + #984, #127
  static Youlost + #985, #127
  static Youlost + #986, #127
  static Youlost + #987, #127
  static Youlost + #988, #127
  static Youlost + #989, #127
  static Youlost + #990, #127
  static Youlost + #991, #127
  static Youlost + #992, #127
  static Youlost + #993, #127
  static Youlost + #994, #127
  static Youlost + #995, #127
  static Youlost + #996, #127
  static Youlost + #997, #127
  static Youlost + #998, #127
  static Youlost + #999, #127
 
  static Youlost + #1000, #127
  static Youlost + #1001, #127
  static Youlost + #1002, #127
  static Youlost + #1003, #127
  static Youlost + #1004, #127
  static Youlost + #1005, #127
  static Youlost + #1006, #84
  static Youlost + #1007, #69
  static Youlost + #1008, #78
  static Youlost + #1009, #84
  static Youlost + #1010, #65
  static Youlost + #1011, #82
  static Youlost + #1012, #25
  static Youlost + #1013, #78
  static Youlost + #1014, #79
  static Youlost + #1015, #86
  static Youlost + #1016, #65
  static Youlost + #1017, #77
  static Youlost + #1018, #69
  static Youlost + #1019, #78
  static Youlost + #1020, #84
  static Youlost + #1021, #69
  static Youlost + #1022, #127
  static Youlost + #1023, #127
  static Youlost + #1024, #127
  static Youlost + #1025, #127
  static Youlost + #1026, #16
  static Youlost + #1027, #83
  static Youlost + #1028, #65
  static Youlost + #1029, #73
  static Youlost + #1030, #82
  static Youlost + #1031, #127
  static Youlost + #1032, #127
  static Youlost + #1033, #127
  static Youlost + #1034, #127
  static Youlost + #1035, #127
  static Youlost + #1036, #127
  static Youlost + #1037, #127
  static Youlost + #1038, #127
  static Youlost + #1039, #127
 
  static Youlost + #1040, #127
  static Youlost + #1041, #127
  static Youlost + #1042, #127
  static Youlost + #1043, #127
  static Youlost + #1044, #127
  static Youlost + #1045, #127
  static Youlost + #1046, #16
  static Youlost + #1047, #25
  static Youlost + #1048, #25
  static Youlost + #1049, #25
  static Youlost + #1050, #25
  static Youlost + #1051, #25
  static Youlost + #1052, #25
  static Youlost + #1053, #25
  static Youlost + #1054, #25
  static Youlost + #1055, #25
  static Youlost + #1056, #25
  static Youlost + #1057, #25
  static Youlost + #1058, #16
  static Youlost + #1059, #526
  static Youlost + #1060, #25
  static Youlost + #1061, #25
  static Youlost + #1062, #25
  static Youlost + #1063, #25
  static Youlost + #1064, #2327
  static Youlost + #1065, #11
  static Youlost + #1066, #11
  static Youlost + #1067, #11
  static Youlost + #1068, #11
  static Youlost + #1069, #11
  static Youlost + #1070, #11
  static Youlost + #1071, #127
  static Youlost + #1072, #127
  static Youlost + #1073, #127
  static Youlost + #1074, #127
  static Youlost + #1075, #127
  static Youlost + #1076, #127
  static Youlost + #1077, #127
  static Youlost + #1078, #127
  static Youlost + #1079, #127
 
  static Youlost + #1080, #127
  static Youlost + #1081, #127
  static Youlost + #1082, #127
  static Youlost + #1083, #127
  static Youlost + #1084, #127
  static Youlost + #1085, #127
  static Youlost + #1086, #127
  static Youlost + #1087, #521
  static Youlost + #1088, #521
  static Youlost + #1089, #521
  static Youlost + #1090, #592
  static Youlost + #1091, #594
  static Youlost + #1092, #581
  static Youlost + #1093, #595
  static Youlost + #1094, #595
  static Youlost + #1095, #585
  static Youlost + #1096, #591
  static Youlost + #1097, #590
  static Youlost + #1098, #581
  static Youlost + #1099, #526
  static Youlost + #1100, #526
  static Youlost + #1101, #526
  static Youlost + #1102, #526
  static Youlost + #1103, #127
  static Youlost + #1104, #127
  static Youlost + #1105, #3152
  static Youlost + #1106, #3154
  static Youlost + #1107, #3141
  static Youlost + #1108, #3155
  static Youlost + #1109, #3155
  static Youlost + #1110, #3145
  static Youlost + #1111, #3151
  static Youlost + #1112, #3150
  static Youlost + #1113, #3141
  static Youlost + #1114, #127
  static Youlost + #1115, #127
  static Youlost + #1116, #127
  static Youlost + #1117, #127
  static Youlost + #1118, #127
  static Youlost + #1119, #127
  
  static Youlost + #1120, #127
  static Youlost + #1121, #127
  static Youlost + #1122, #127
  static Youlost + #1123, #127
  static Youlost + #1124, #127
  static Youlost + #1125, #127
  static Youlost + #1126, #127
  static Youlost + #1127, #127
  static Youlost + #1128, #127
  static Youlost + #1129, #2319
  static Youlost + #1130, #2319
  static Youlost + #1131, #127
  static Youlost + #1132, #581
  static Youlost + #1133, #590
  static Youlost + #1134, #596
  static Youlost + #1135, #581
  static Youlost + #1136, #594
  static Youlost + #1137, #2319
  static Youlost + #1138, #127
  static Youlost + #1139, #127
  static Youlost + #1140, #127
  static Youlost + #1141, #127
  static Youlost + #1142, #127
  static Youlost + #1143, #127
  static Youlost + #1144, #127
  static Youlost + #1145, #3138
  static Youlost + #1146, #3137
  static Youlost + #1147, #3139
  static Youlost + #1148, #3147
  static Youlost + #1149, #3155
  static Youlost + #1150, #3152
  static Youlost + #1151, #3137
  static Youlost + #1152, #3139
  static Youlost + #1153, #3141
  static Youlost + #1154, #127
  static Youlost + #1155, #127
  static Youlost + #1156, #127
  static Youlost + #1157, #127
  static Youlost + #1158, #127
  static Youlost + #1159, #127
 
  static Youlost + #1160, #127
  static Youlost + #1161, #127
  static Youlost + #1162, #127
  static Youlost + #1163, #127
  static Youlost + #1164, #127
  static Youlost + #1165, #127
  static Youlost + #1166, #127
  static Youlost + #1167, #127
  static Youlost + #1168, #127
  static Youlost + #1169, #127
  static Youlost + #1170, #127
  static Youlost + #1171, #127
  static Youlost + #1172, #127
  static Youlost + #1173, #127
  static Youlost + #1174, #127
  static Youlost + #1175, #2319
  static Youlost + #1176, #127
  static Youlost + #1177, #127
  static Youlost + #1178, #127
  static Youlost + #1179, #127
  static Youlost + #1180, #127
  static Youlost + #1181, #127
  static Youlost + #1182, #127
  static Youlost + #1183, #127
  static Youlost + #1184, #127
  static Youlost + #1185, #127
  static Youlost + #1186, #127
  static Youlost + #1187, #127
  static Youlost + #1188, #127
  static Youlost + #1189, #127
  static Youlost + #1190, #127
  static Youlost + #1191, #127
  static Youlost + #1192, #127
  static Youlost + #1193, #127
  static Youlost + #1194, #127
  static Youlost + #1195, #127
  static Youlost + #1196, #127
  static Youlost + #1197, #127
  static Youlost + #1198, #127
  static Youlost + #1199, #127

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
