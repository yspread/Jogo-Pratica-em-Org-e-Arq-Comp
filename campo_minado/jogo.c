/*
 * CAMPO MINADO - Processador ICMC (proc.giroto.dev / icmc-cc)
 * -------------------------------------------------------------
 * REGRAS DO COMPILADOR DESCOBERTAS NA MARRA (ver comentarios do
 * codigo original) - respeitadas em TODO este arquivo:
 *   1) NUNCA usar / ou % -> quebram o compilador. Toda divisao e
 *      modulo aqui embaixo sao feitos "na mao" com while + subtracao.
 *   2) NUNCA usar "return;" sem valor, mesmo em funcao void.
 *      Sempre "return 0;".
 *   3) Usar "while" em vez de "for", e evitar "continue".
 *   4) "||" funciona normalmente.
 *
 * Controles: WASD ou setas = mover | ESPACO = revelar
 *            F = marcar/desmarcar bandeira | Q = desistir da partida
 */

/* Dimensoes da tela */
#define LARGURA 40
#define ALTURA 30

/* Dimensoes do tabuleiro */
#define BOARDLARGURA 19
#define BOARDALTURA 14
#define TOTAL_CELULAS 266

/* Posicao do tabuleiro na tela (calculada a mao para nao usar '/'):
   INICIO_X = (LARGURA - BOARDLARGURA)/2 = (40-19)/2 = 10
   INICIO_Y = (ALTURA - BOARDALTURA)/2   = (30-14)/2 = 8   */
#define INICIO_X 10
#define INICIO_Y 8
#define FIM_X 29
#define FIM_Y 22

/* Cores */
#define VERMELHO 7936
#define AMARELO  768
#define VERDE    58112
#define AZUL     64512

/* Valores dos chars de movimento (setas do teclado) */
#define UP 38
#define RIGHT 39
#define DOWN 40
#define LEFT 37

/* VARIAVEIS GLOBAIS */
char mapa_jogo[266];
char revelado_jogo[266];   /* '0' = escondida, '1' = revelada, '2' = marcada */

int dir_x[8];
int dir_y[8];

int total_bombas;
int bandeiras_restantes;
int celulas_reveladas;

/* ---------------------------------------------------------------- */

void print_str(char *texto, int pos) {
    int i;
    i = 0;
    while (texto[i] != 0) {
        _outchar(texto[i], pos + i);
        i = i + 1;
    }
    return 0;
}

void clearScreen() {
    int i;
    i = 0;
    while (i < 1200) {
        _outchar(' ', i);
        i = i + 1;
    }
    return 0;
}

/* imprime um numero de 0 a 99 com 2 digitos, sem usar / nem % */
void printNum2(int n, int pos) {
    int dezena;
    int unidade;
    dezena = 0;
    unidade = n;
    while (unidade >= 10) {
        unidade = unidade - 10;
        dezena = dezena + 1;
    }
    _outchar('0' + dezena, pos);
    _outchar('0' + unidade, pos + 1);
    return 0;
}

void espera_espaco() {
    int tecla;
    tecla = 0;
    while (tecla != ' ') {
        tecla = _inchar();
    }
    return 0;
}

/* converte indice linear do tabuleiro (0..265) para posicao de tela,
   sem usar / nem % (subtracao repetida) */
int idx_para_tela(int pos) {
    int rx;
    int ry;
    rx = pos;
    ry = 0;
    while (rx >= BOARDLARGURA) {
        rx = rx - BOARDLARGURA;
        ry = ry + 1;
    }
    return (ry + INICIO_Y) * LARGURA + rx + INICIO_X;
}

/* converte posicao de tela (sx,sy) do cursor para indice linear
   do tabuleiro. so usa subtracao e multiplicacao, nada de / ou % */
int pos_para_idx(int sx, int sy) {
    int bx;
    int by;
    bx = sx - INICIO_X;
    by = sy - INICIO_Y;
    return by * BOARDLARGURA + bx;
}

void make_tabuleiro() {
    int i;
    char *ref = "13939101111110000001994220191191111011232292121111119102991011292121101110291100011293920001121111000122393111291019100019112911921101121101110122212110001921100002931291011112910000294932209200111111012922910930122119211233321092019911291192991001101221011111222100";

    total_bombas = 0;
    celulas_reveladas = 0;

    i = 0;
    while (i < TOTAL_CELULAS) {
        mapa_jogo[i] = ref[i];
        revelado_jogo[i] = '0';
        if (ref[i] == '9') {
            total_bombas = total_bombas + 1;
        }
        i = i + 1;
    }
    bandeiras_restantes = total_bombas;

    /* vetores de direcao globais, para nao estourar memoria na recursao */
    dir_x[0] = 0;  dir_x[1] = 1;  dir_x[2] = 0;  dir_x[3] = -1;
    dir_x[4] = 1;  dir_x[5] = 1;  dir_x[6] = -1; dir_x[7] = -1;
    dir_y[0] = 1;  dir_y[1] = 0;  dir_y[2] = -1; dir_y[3] = 0;
    dir_y[4] = -1; dir_y[5] = 1;  dir_y[6] = -1; dir_y[7] = 1;

    return 0;
}

void revelar_recursivo(int pos) {
    int rx;
    int ry;
    int j;
    int vizPos;

    if (revelado_jogo[pos] == '1') return 0;
    if (revelado_jogo[pos] == '2') return 0;  /* celula marcada nao revela */

    revelado_jogo[pos] = '1';
    celulas_reveladas = celulas_reveladas + 1;

    /* pos -> (rx,ry) sem usar / nem % */
    rx = pos;
    ry = 0;
    while (rx >= BOARDLARGURA) {
        rx = rx - BOARDLARGURA;
        ry = ry + 1;
    }

    /* posicao de tela corrigida: precisa bater com printar_tabuleiro() */
    if (mapa_jogo[pos] == '0') {
        _outchar(' ', (ry + INICIO_Y) * LARGURA + rx + INICIO_X);
    } else {
        _outchar(mapa_jogo[pos], (ry + INICIO_Y) * LARGURA + rx + INICIO_X);
    }

    if (mapa_jogo[pos] != '0') return 0;

    j = 0;
    while (j < 8) {
        if (rx + dir_x[j] >= 0) {
            if (BOARDLARGURA > rx + dir_x[j]) {
                if (ry + dir_y[j] >= 0) {
                    if (BOARDALTURA > ry + dir_y[j]) {
                        vizPos = (ry + dir_y[j]) * BOARDLARGURA + rx + dir_x[j];
                        revelar_recursivo(vizPos);
                    }
                }
            }
        }
        j = j + 1;
    }
    return 0;
}

void alternar_bandeira(int idx) {
    int tela_pos;
    tela_pos = idx_para_tela(idx);

    if (revelado_jogo[idx] == '0') {
        if (bandeiras_restantes > 0) {
            revelado_jogo[idx] = '2';
            bandeiras_restantes = bandeiras_restantes - 1;
            _outchar('F' + AMARELO, tela_pos);
        }
    } else if (revelado_jogo[idx] == '2') {
        revelado_jogo[idx] = '0';
        bandeiras_restantes = bandeiras_restantes + 1;
        _outchar('*', tela_pos);
    }
    return 0;
}

void printar_selecao(int cx, int cy) {
    _outchar('*' + VERMELHO, cy * LARGURA + cx);
    return 0;
}

void apagar_selecao(int cx, int cy) {
    int idx;
    idx = pos_para_idx(cx, cy);
    if (revelado_jogo[idx] == '2') {
        _outchar('F' + AMARELO, cy * LARGURA + cx);
    } else if (revelado_jogo[idx] == '1') {
        if (mapa_jogo[idx] == '0') {
            _outchar(' ', cy * LARGURA + cx);
        } else {
            _outchar(mapa_jogo[idx], cy * LARGURA + cx);
        }
    } else {
        _outchar('*', cy * LARGURA + cx);
    }
    return 0;
}

void menu() {
    clearScreen();
    print_str("CAMPO MINADO", 3 * LARGURA + 14);
    print_str("PRESSIONE ESPACO PARA JOGAR", 6 * LARGURA + 6);
    espera_espaco();
    clearScreen();
    return 0;
}

void printar_tabuleiro() {
    int cx;
    int cy;
    int pos;

    cy = INICIO_Y;
    while (cy < FIM_Y) {
        cx = INICIO_X;
        while (cx < FIM_X) {
            pos = (cy * LARGURA) + cx;
            if (pos >= 0) {
                if (pos < 1200) {
                    _outchar('*', pos);
                }
            }
            cx = cx + 1;
        }
        cy = cy + 1;
    }
    return 0;
}

int main() {
    int sx;
    int sy;
    int tecla_atual;
    int tecla_anterior;
    int estado_jogo;   /* 0 = jogando, 1 = venceu, 2 = perdeu, 3 = desistiu */
    int idx;

    while (1 == 1) {
        menu();

        make_tabuleiro();
        printar_tabuleiro();

        sx = INICIO_X;
        sy = INICIO_Y;
        printar_selecao(sx, sy);

        print_str("BOMBAS: ", 0);
        printNum2(total_bombas, 8);

        estado_jogo = 0;
        tecla_anterior = 255;

        while (estado_jogo == 0) {
            tecla_atual = _inchar();

            if (tecla_atual != 255) {
                if (tecla_atual != tecla_anterior) {

                    if (tecla_atual == RIGHT || tecla_atual == 'd' || tecla_atual == 'D') {
                        if (sx < FIM_X - 1) {
                            apagar_selecao(sx, sy);
                            sx = sx + 1;
                            printar_selecao(sx, sy);
                        }
                    }

                    if (tecla_atual == LEFT || tecla_atual == 'a' || tecla_atual == 'A') {
                        if (sx > INICIO_X) {
                            apagar_selecao(sx, sy);
                            sx = sx - 1;
                            printar_selecao(sx, sy);
                        }
                    }

                    if (tecla_atual == UP || tecla_atual == 'w' || tecla_atual == 'W') {
                        if (sy > INICIO_Y) {
                            apagar_selecao(sx, sy);
                            sy = sy - 1;
                            printar_selecao(sx, sy);
                        }
                    }

                    if (tecla_atual == DOWN || tecla_atual == 's' || tecla_atual == 'S') {
                        if (sy < FIM_Y - 1) {
                            apagar_selecao(sx, sy);
                            sy = sy + 1;
                            printar_selecao(sx, sy);
                        }
                    }

                    if (tecla_atual == 13) {
                        idx = pos_para_idx(sx, sy);
                        if (revelado_jogo[idx] == '0') {
                            if (mapa_jogo[idx] == '9') {
                                revelado_jogo[idx] = '1';
                                _outchar('9' + VERMELHO, sy * LARGURA + sx);
                                estado_jogo = 2;
                            } else {
                                revelar_recursivo(idx);
                                printar_selecao(sx, sy);
                                if (celulas_reveladas == TOTAL_CELULAS - total_bombas) {
                                    estado_jogo = 1;
                                }
                            }
                        }
                    }

                    if (tecla_atual == 'f' || tecla_atual == 'F') {
                        idx = pos_para_idx(sx, sy);
                        alternar_bandeira(idx);
                        printar_selecao(sx, sy);
                    }

                    if (tecla_atual == 'q' || tecla_atual == 'Q') {
                        estado_jogo = 3;
                    }
                }
            }
            tecla_anterior = tecla_atual;
        }

        if (estado_jogo == 1) {
            print_str("VOCE VENCEU!  ESPACO", 29 * LARGURA + 8);
        } else if (estado_jogo == 2) {
            print_str("VOCE PERDEU!  ESPACO", 29 * LARGURA + 8);
        } else {
            print_str("DESISTIU.     ESPACO", 29 * LARGURA + 8);
        }

        espera_espaco();
        
    }

    return 0;
}