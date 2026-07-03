//Dimensões da tela
#define LARGURA 40
#define ALTURA 30
//Dimensões do tabuleiro
#define BOARDLARGURA 19
#define BOARDALTURA 14
#define NBOMBAS 40

/* Cores */
#define VERMELHO 7936
#define AMARELO  768
#define VERDE    58112
#define AZUL     64512

//Valores dos chars de movimento
#define UP 38
#define RIGHT 39
#define DOWN 40
#define LEFT 37

/* VARIÁVEIS GLOBAIS */
char mapa_jogo[266]; 
char revelado_jogo[266];

/* Renomeado para não conflitar com nenhum outro dx ou dy */
int dir_x[8];
int dir_y[8];

void print_str(char *texto, int pos) {
    int i;
    i = 0;
    while (texto[i] != 0) {
        _outchar(texto[i], pos + i);
        i = i + 1;
    }
}

void clearScreen() {
    int i;
    i = 0;
    while (i < 1200) {
        _outchar(' ', i);
        i = i + 1;
    }
}

void espera_espaco() {
    int tecla;
    tecla = 0;
    while (tecla != ' ') {
        tecla = _inchar();
    }
}

void make_tabuleiro() {
    int i;
    char *ref = "13939101111110000001994220191191111011232292121111119102991011292121101110291100011293920001121111000122393111291019100019112911921101121101110122212110001921100002931291011112910000294932209200111111012922910930122119211233321092019911291192991001101221011111222100";
    
    i = 0;
    while(i < 266) {
        mapa_jogo[i] = ref[i];
        revelado_jogo[i] = '0';
        i = i + 1;
    }

    /* Inicializa vetores de direcao globais para nao estourar a memoria na recursao */
    dir_x[0] = 0; dir_x[1] = 1; dir_x[2] = 0; dir_x[3] = -1; dir_x[4] = 1; dir_x[5] = 1; dir_x[6] = -1; dir_x[7] = -1;
    dir_y[0] = 1; dir_y[1] = 0; dir_y[2] = -1; dir_y[3] = 0; dir_y[4] = -1; dir_y[5] = 1; dir_y[6] = -1; dir_y[7] = 1;
}

void revelar_recursivo(int pos) {
    int rx;
    int ry;
    int j;
    int vizPos;
    
    if(revelado_jogo[pos] == '1') return;
    revelado_jogo[pos] = '1';
    
    /* SUBSTITUIMOS O MÓDULO E DIVISÃO AQUI PARA NÃO CRASHAR O COMPILADOR */
    rx = pos;
    ry = 0;
    while (rx >= BOARDLARGURA) {
        rx = rx - BOARDLARGURA;
        ry = ry + 1;
    }
    
    _outchar(mapa_jogo[pos], 2 * (BOARDLARGURA + 1) * (ry + 1) + 2 * rx);

    if(mapa_jogo[pos] != '0') return;

    /* SUBSTITUIMOS O 'FOR' POR 'WHILE' E TIRAMOS O 'CONTINUE' PARA MAIOR SEGURANCA */
    j = 0;
    while(j < 8) {
        if(rx + dir_x[j] >= 0) {
            if(BOARDLARGURA > rx + dir_x[j]) {
                if(ry + dir_y[j] >= 0) {
                    if(BOARDALTURA > ry + dir_y[j]) {
                        vizPos = (ry + dir_y[j])*BOARDLARGURA + rx + dir_x[j];
                        revelar_recursivo(vizPos);
                    }
                }
            }
        }
        j = j + 1;
    }
}

/* Nomes de parametros alterados para cx e cy para evitar conflito com os vetores globais */
void printar_selecao(int cx, int cy) {
    _outchar('*' + VERMELHO, cy * LARGURA + cx);
}

void apagar_selecao(int cx, int cy) {
    _outchar(' ', cy * LARGURA + cx);
}

void menu(){
    print_str("CAMPO MINADO", 3 * LARGURA + 14);
    print_str("PRESSIONE ESPACO PARA JOGAR", 6 * LARGURA + 6);
    espera_espaco();
    clearScreen();
}

void printar_tabuleiro() {
    int i;
    i = 0;
    while(i < 266) { 
        _outchar(mapa_jogo[i], i);
        i = i + 1;
    }
}

int main() {
    int qtd_bombas;
    int sx; 
    int sy;
    int tecla_atual;
    int tecla_anterior;

    sx = 0;
    sy = 2;
    tecla_anterior = 255;
    
    menu();

    qtd_bombas = 10;       
    print_str("BOMBAS: 10", 0);
    
    make_tabuleiro();
    
    printar_selecao(sx, sy);

    while (1) {
        tecla_atual = _inchar();

        if (tecla_atual != 255) {
            if (tecla_atual != tecla_anterior) {
                
                if (tecla_atual == RIGHT || tecla_atual == 'd' || tecla_atual == 'D') {
                    if (sx < LARGURA - 1) { 
                        apagar_selecao(sx, sy);
                        sx = sx + 1;
                        printar_selecao(sx, sy);
                    }
                }
                
                if (tecla_atual == LEFT || tecla_atual == 'a' || tecla_atual == 'A') {
                    if (sx > 0) { 
                        apagar_selecao(sx, sy);
                        sx = sx - 1;
                        printar_selecao(sx, sy);
                    }
                }
                
                if (tecla_atual == UP || tecla_atual == 'w' || tecla_atual == 'W') {
                    if (sy > 1) { 
                        apagar_selecao(sx, sy);
                        sy = sy - 1;
                        printar_selecao(sx, sy);
                    }
                }
                
                if (tecla_atual == DOWN || tecla_atual == 's' || tecla_atual == 'S') {
                    if (sy < ALTURA - 1) { 
                        apagar_selecao(sx, sy);
                        sy = sy + 1;
                        printar_selecao(sx, sy);
                    }
                }
            }
        }
        tecla_anterior = tecla_atual;
    }

    return 0;
}