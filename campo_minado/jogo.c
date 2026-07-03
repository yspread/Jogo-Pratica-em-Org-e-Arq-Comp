//Dimensões da tela
#define LARGURA 40
#define ALTURA 30
//Dimensões do tabuleiro
#define BOARDLARGURA 19
#define BOARDALTURA 14
#define NBOMBAS 40
//Valores dos chars de movimento
#define CIMA 70
#define BAIXO 72
#define DIR 71
#define ESQ 69


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
    char tecla;

    char tecla = 0;
    while (tecla != ' ') {
        tecla = _inchar();
    }
}

/*
// Função retorna um tabuleiro novo
char* make_tabuleiro() {
    //Cria uma tabela de indices para a lógica do fisher yates
    short indices[BOARDLARGURA*BOARDALTURA];
    char* mapa = malloc(sizeof(char) * BOARDLARGURA*BOARDALTURA);

    for(short i = 0; i < BOARDLARGURA*BOARDALTURA; i++)indices[i] = i;
    
    srand(10);
    for(short i = 0; i < NBOMBAS; i++){
        unsigned short r = rand();
        r %= BOARDLARGURA*BOARDALTURA - 1;
        mapa[r + 1] = '9';
        short troca = indices[i];
        indices[i] = indices[r];
        indices[r] = troca;
    }
    for(short i = 0; i < BOARDLARGURA*BOARDALTURA; i++){
        if(mapa[i] == '9')continue;
        mapa[i] = '0';
        short dx[8] = {0, 1, 0, -1, 1, 1, -1, -1};
        short dy[8] = {1, 0, -1, 0, -1, 1, -1, 1};
        short x = i%BOARDLARGURA;
        short y = i/BOARDLARGURA;
        for(short j = 0; j < 8; j++){
            if(x + dx[j] < 0 || BOARDLARGURA <= x + dx[j])continue;
            if(y + dy[j] < 0 || BOARDALTURA <= y + dy[j])continue;
            short idViz = (y + dy[j])*BOARDLARGURA + x + dx[j];
            if(mapa[idViz] == '9')mapa[i]++;
        }
    }
    return mapa;
}
*/
char* make_tabuleiro() {
    char* mapa = malloc(sizeof(char) * BOARDLARGURA*BOARDALTURA);
    char ref[BOARDALTURA*BOARDLARGURA] = {'1', '3', '9', '3', '9', '1', '0', '1', '1', '1', '1', '1', '1', '0', '0', '0', '0', '0', '0', '1', '9', '9', '4', '2', '2', '0', '1', '9', '1', '1', '9', '1', '1', '1', '1', '0', '1', '1', '2', '3', '2', '2', '9', '2', '1', '2', '1', '1', '1', '1', '1', '1', '9', '1', '0', '2', '9', '9', '1', '0', '1', '1', '2', '9', '2', '1', '2', '1', '1', '0', '1', '1', '1', '0', '2', '9', '1', '1', '0', '0', '0', '1', '1', '2', '9', '3', '9', '2', '0', '0', '0', '1', '1', '2', '1', '1', '1', '1', '0', '0', '0', '1', '2', '2', '3', '9', '3', '1', '1', '1', '2', '9', '1', '0', '1', '9', '1', '0', '0', '0', '1', '9', '1', '1', '2', '9', '1', '1', '9', '2', '1', '1', '0', '1', '1', '2', '1', '1', '0', '1', '1', '1', '0', '1', '2', '2', '2', '1', '2', '1', '1', '0', '0', '0', '1', '9', '2', '1', '1', '0', '0', '0', '0', '2', '9', '3', '1', '2', '9', '1', '0', '1', '1', '1', '1', '2', '9', '1', '0', '0', '0', '0', '2', '9', '4', '9', '3', '2', '2', '0', '9', '2', '0', '0', '1', '1', '1', '1', '1', '1', '0', '1', '2', '9', '2', '2', '9', '1', '0', '9', '3', '0', '1', '2', '2', '1', '1', '9', '2', '1', '1', '2', '3', '3', '3', '2', '1', '0', '9', '2', '0', '1', '9', '9', '1', '1', '2', '9', '1', '1', '9', '2', '9', '9', '1', '0', '0', '1', '1', '0', '1', '2', '2', '1', '0', '1', '1', '1', '1', '1', '2', '2', '2', '1', '0', '0'};
    for(int i = 0; i < BOARDALTURA*BOARDLARGURA; i++){
        mapa[i] = ref[i];
    }
    return mapa;
}

//Função para recursivamente revelar todas as casas nulas e suas vizinhas a partir de um ponto
void revelar_recursivo(short pos, char* revelado, char* mapa) {
    //Paramos caso a casa já havia sido revelada
    if(revelado[pos] == '1')return;
    revelado[pos] = '1';
    short x = pos%BOARDLARGURA;
    short y = pos/BOARDLARGURA;
    _outchar(mapa[pos], 2 * (BOARDLARGURA + 1) * (y + 1) + 2 * x);

    //Não revelamos os vizinhos de casas não nulas
    if(mapa[pos] != '0')return;

    //Itera pelos vizinhos
    short dx[8] = {0, 1, 0, -1, 1, 1, -1, -1};
    short dy[8] = {1, 0, -1, 0, -1, 1, -1, 1};
    for(short j = 0; j < 8; j++){
        if(x + dx[j] < 0 || BOARDLARGURA <= x + dx[j])continue;
        if(y + dy[j] < 0 || BOARDALTURA <= y + dy[j])continue;
        short vizPos = (y + dy[j])*BOARDLARGURA + x + dx[j];
        revelar_recursivo(vizPos, revelado, mapa);
    }
}
void start_game(){
    char* tabuleiro = make_tabuleiro();
    print_str("BOMBAS: 40", 0);

    short tab_pos;

    while(1){
        char tecla = _inchar();
        switch(tecla){
        case CIMA:
            
            break;
        
        default:
            break;
        }
    }
}
void menu(){
    print_str("CAMPO MINADO", 3 * LARGURA + 14);
    print_str("PRESSIONE ESPACO PARA JOGAR", 6 * LARGURA + 6);

    espera_espaco();
    clearScreen();
}

int main() {
    menu();

    

    while (1) {

    }

    return 0;
}