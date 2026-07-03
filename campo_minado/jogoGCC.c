#define LARGURA 40
#define ESPACO 32

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
    while (tecla != ESPACO) {
        tecla = _inchar();
    }
}

int main() {
    int qtd_bombas;

 
    print_str("CAMPO MINADO", 3 * LARGURA + 14);
    print_str("PRESSIONE ESPACO PARA JOGAR", 6 * LARGURA + 6);

    espera_espaco();
    clearScreen();

    qtd_bombas = 10;       
    print_str("BOMBAS: 10", 0);

    while (1) {

    }

    return 0;
}