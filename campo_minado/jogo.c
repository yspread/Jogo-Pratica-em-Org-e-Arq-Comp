#define LARGURA 40
#define ESPACO 32
#define BOARDLENGTH 19
#define BOARDHEIGHT 14
#define NBOMBAS 32

void print_str(char *texto, short pos) {
    short i;

    i = 0;
    while (texto[i] != 0) {
        _outchar(texto[i], pos + i);
        i = i + 1;
    }
}

void clearScreen() {
    short i;
    i = 0;
    while (i < 1200) {
        _outchar(' ', i);
        i = i + 1;
    }
}

void espera_espaco() {
    short tecla;

    tecla = 0;
    while (tecla != ESPACO) {
        tecla = _inchar();
    }
}

// Função retorna um tabuleiro novo
short* make_tabuleiro() {
    //Cria uma tabela de indices para a lógica do fisher yates
    short indices[BOARDLENGTH*BOARDHEIGHT];
    char mapa[BOARDLENGTH*BOARDHEIGHT];

    for(short i = 0; i < BOARDLENGTH*BOARDHEIGHT; i++)indices[i] = i;

    for(short i = 0; i < NBOMBAS; i++){
        short r = rand();
        r %= BOARDLENGTH*BOARDHEIGHT;
        mapa[r] = '-1';
        short troca = indices[i];
        indices[i] = indices[r];
        indices[r] = troca;
    }
    short dx[8] = {0, 1, 0, -1, 1, 1, -1, -1};
    short dy[8] = {1, 0, -1, 0, -1, 1, -1, 1};
    for(short i = 0; i < BOARDLENGTH*BOARDHEIGHT; i++){
        if(mapa[i] == -1)continue;
        mapa[i] = '0';
        short x = i%BOARDLENGTH;
        short y = i/BOARDLENGTH;
        for(short j = 0; j < 8; j++){
            if(x + dx[j] < 0 || BOARDLENGTH <= x + dx[j])continue;
            if(y + dy[j] < 0 || BOARDHEIGHT <= y + dy[j])continue;
            short id_viz = (y + dy[j])*BOARDLENGTH + x + dx[j];
            if(mapa[id_viz] == -1)mapa[i]++;
        }
    }
    return mapa;
}

int main() {
    print_str("CAMPO MINADO", 3 * LARGURA + 14);
    print_str("PRESSIONE ESPACO PARA JOGAR", 6 * LARGURA + 6);

    espera_espaco();
    clearScreen();

    print_str("BOMBAS: 10", 0);

    while (1) {

    }

    return 0;
}