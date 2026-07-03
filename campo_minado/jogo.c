#define LARGURA 40
    #define ALTURA 30


    #define BOARDLARGURA 19
    #define BOARDALTURA 14
    #define TOTAL_CELULAS 266

 
    #define INICIO_X 10
    #define INICIO_Y 8
    #define FIM_X 29
    #define FIM_Y 22

    #define NBOMBAS 38;
    
    #define VERMELHO 7936
    #define AMARELO  768
    #define VERDE    58112
    #define AZUL     64512

  
    #define UP 38
    #define RIGHT 39
    #define DOWN 40
    #define LEFT 37

    char mapa_jogo[266];
    char revelado_jogo[266];   

    int semente_rand;
 
    int dir_x[8];
    int dir_y[8];

    int total_bombas;
    int bandeiras_restantes;
    int celulas_reveladas;


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

   
    int pos_para_idx(int sx, int sy) {
        int bx;
        int by;
        bx = sx - INICIO_X;
        by = sy - INICIO_Y;
        return by * BOARDLARGURA + bx;
    }
    void printar_bomba() {
        int ix;
        int iy;

        /* Coordenadas X e Y para centralizar a arte de 22x11 */
        ix = 9; 
        iy = 9; 

        /* Chamamos o print_str somando a linha (0 a 10) no multiplicador da LARGURA */
        print_str("_ -^^---....,,--", (iy + 0) * LARGURA + ix);
        print_str(" --               --", (iy + 1) * LARGURA + ix);
        print_str("<                   >)", (iy + 2) * LARGURA + ix);
        print_str("|                   |", (iy + 3) * LARGURA + ix);
        
        /* ATENÇÃO: O caractere '\' precisa ser duplicado '\\' em C para não quebrar a string */
        print_str(" \\_               _/", (iy + 4) * LARGURA + ix);
        
        print_str("   ```-- . , ; .--'''", (iy + 5) * LARGURA + ix);
        print_str("        | |  |", (iy + 6) * LARGURA + ix);
        print_str("      .-=||  ||=-.", (iy + 7) * LARGURA + ix);
        print_str("      `-=#$%&%$#=-'", (iy + 8) * LARGURA + ix);
        print_str("        | ;  :|", (iy + 9) * LARGURA + ix);
        print_str("  __.,-#%&$@%#&#~,.__", (iy + 10) * LARGURA + ix);

        return 0;
    }

    void make_tabuleiro(int seed) {
        int i;
        int bombas_colocadas;
        int pos;
        int rx;
        int ry;
        int j;
        int nx;
        int ny;
        int idViz;
        int bombas_vizinhas;

        total_bombas = 0;
        celulas_reveladas = 0;
        semente_rand = seed; /* Mude esse número para gerar mapas diferentes! */

        /* PASSO 1: Preencher tudo com '0' */
        i = 0;
        while (i < TOTAL_CELULAS) {
            mapa_jogo[i] = '0';
            revelado_jogo[i] = '0';
            i = i + 1;
        }

        /* PASSO 2: Espalhar as bombas aleatoriamente */
        bombas_colocadas = 0;
        while (bombas_colocadas < 38) { /* Até bater as 38 bombas */
            pos = rand_pos();
            /* Só coloca se a célula já não tiver uma bomba */
            if (mapa_jogo[pos] != '9') {
                mapa_jogo[pos] = '9';
                bombas_colocadas = bombas_colocadas + 1;
                total_bombas = total_bombas + 1;
            }
        }
        bandeiras_restantes = total_bombas;

        /* Configurar os vetores de direção ANTES de calcular os números */
        dir_x[0] = 0;  dir_x[1] = 1;  dir_x[2] = 0;  dir_x[3] = -1;
        dir_x[4] = 1;  dir_x[5] = 1;  dir_x[6] = -1; dir_x[7] = -1;
        dir_y[0] = 1;  dir_y[1] = 0;  dir_y[2] = -1; dir_y[3] = 0;
        dir_y[4] = -1; dir_y[5] = 1;  dir_y[6] = -1; dir_y[7] = 1;

        /* PASSO 3: Calcular os números (0 a 8) varrendo o tabuleiro */
        i = 0;
        rx = 0; /* Controle de X manual para evitar divisão e módulo */
        ry = 0; /* Controle de Y manual */
        
        while (i < TOTAL_CELULAS) {
            if (mapa_jogo[i] != '9') {
                bombas_vizinhas = 0;
                j = 0;
                while (j < 8) {
                    nx = rx + dir_x[j];
                    ny = ry + dir_y[j];
                    
                    /* Verifica se o vizinho não vazou das bordas */
                    if (nx >= 0) {
                        if (nx < BOARDLARGURA) {
                            if (ny >= 0) {
                                if (ny < BOARDALTURA) {
                                    idViz = (ny * BOARDLARGURA) + nx;
                                    if (mapa_jogo[idViz] == '9') {
                                        bombas_vizinhas = bombas_vizinhas + 1;
                                    }
                                }
                            }
                        }
                    }
                    j = j + 1;
                }
                /* Converte o número de vizinhas de inteiro para o char correspondente ('0', '1', '2'...) */
                mapa_jogo[i] = '0' + bombas_vizinhas; 
            }
            
            /* Avança a coordenada (rx, ry) do tabuleiro */
            rx = rx + 1;
            if (rx >= BOARDLARGURA) {
                rx = 0;
                ry = ry + 1;
            }
            
            i = i + 1;
        }

        return 0;
    }

    int rand() {
        /* Multiplicador e incremento simples que cabem em 16-bits */
        semente_rand = (semente_rand * 13) + 7;
        
        /* Se a variável estourar o limite e ficar negativa, consertamos */
        if (semente_rand < 0) {
            semente_rand = semente_rand * -1;
        }
        return semente_rand;
    }
    
    int rand_pos() {
        int val;
        val = rand();
        
        /* Fazemos a subtração em blocos grandes primeiro para poupar a CPU */
        while (val >= 2660) {
            val = val - 2660;
        }
        /* Depois subtraímos o exato tamanho do tabuleiro (266) */
        while (val >= TOTAL_CELULAS) {
            val = val - TOTAL_CELULAS;
        }
        return val;
    }
    // char* make_ref() {
    //     //Cria uma tabela de indices para a lógica do fisher yates
    //     short indices[BOARDLARGURA*BOARDALTURA];
    //     char* mapa = malloc(sizeof(char) * BOARDLARGURA*BOARDALTURA);

    //     for(short i = 0; i < BOARDLARGURA*BOARDALTURA; i++)indices[i] = i;
        
    //     srand(10);
    //     for(short i = 0; i < NBOMBAS; i++){
    //         unsigned short r = rand();
    //         r %= BOARDLARGURA*BOARDALTURA - 1;
    //         mapa[r + 1] = '9';
    //         short troca = indices[i];
    //         indices[i] = indices[r];
    //         indices[r] = troca;
    //     }
    //     for(short i = 0; i < BOARDLARGURA*BOARDALTURA; i++){
    //         if(mapa[i] == '9')continue;
    //         mapa[i] = '0';
    //         short dx[8] = {0, 1, 0, -1, 1, 1, -1, -1};
    //         short dy[8] = {1, 0, -1, 0, -1, 1, -1, 1};
    //         short x = i%BOARDLARGURA;
    //         short y = i/BOARDLARGURA;
    //         for(short j = 0; j < 8; j++){
    //             if(x + dx[j] < 0 || BOARDLARGURA <= x + dx[j])continue;
    //             if(y + dy[j] < 0 || BOARDALTURA <= y + dy[j])continue;
    //             short idViz = (y + dy[j])*BOARDLARGURA + x + dx[j];
    //             if(mapa[idViz] == '9')mapa[i]++;
    //         }
    //     }
    //     return mapa;
    // }
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
                _outchar('F'+ AMARELO, tela_pos);
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

/* tela de derrota, convertida de tela.asm (Youlost) para C puro */
/* tela de derrota, convertida de tela.asm (Youlost) para C puro. */
/* a maioria das celulas e fundo (127), entao so desenhamos as que importam */
void printYoulostScreen() {
    clearScreen();
    _outchar(2310, 2);
    _outchar(2310, 6);
    _outchar(2310, 10);
    _outchar(2310, 11);
    _outchar(2310, 12);
    _outchar(2310, 41);
    _outchar(2310, 42);
    _outchar(2310, 45);
    _outchar(2310, 46);
    _outchar(2310, 47);
    _outchar(2310, 48);
    _outchar(2310, 49);
    _outchar(2310, 50);
    _outchar(2310, 80);
    _outchar(2310, 81);
    _outchar(2310, 82);
    _outchar(2310, 83);
    _outchar(2310, 85);
    _outchar(2310, 86);
    _outchar(2310, 87);
    _outchar(2310, 121);
    _outchar(2310, 122);
    _outchar(2310, 123);
    _outchar(2310, 124);
    _outchar(2314, 130);
    _outchar(2350, 131);
    _outchar(2347, 132);
    _outchar(2349, 133);
    _outchar(2349, 134);
    _outchar(2349, 135);
    _outchar(2350, 136);
    _outchar(2350, 137);
    _outchar(2350, 138);
    _outchar(2350, 139);
    _outchar(2348, 140);
    _outchar(2348, 141);
    _outchar(2349, 142);
    _outchar(2349, 143);
    _outchar(2347, 144);
    _outchar(2350, 145);
    _outchar(2310, 160);
    _outchar(2310, 161);
    _outchar(2310, 162);
    _outchar(2350, 169);
    _outchar(2349, 170);
    _outchar(2343, 171);
    _outchar(2343, 172);
    _outchar(2343, 173);
    _outchar(2343, 174);
    _outchar(2343, 175);
    _outchar(2343, 176);
    _outchar(2343, 177);
    _outchar(2343, 178);
    _outchar(2343, 179);
    _outchar(2319, 185);
    _outchar(2398, 186);
    _outchar(2398, 187);
    _outchar(2350, 188);
    _outchar(2310, 200);
    _outchar(2310, 201);
    _outchar(2349, 207);
    _outchar(2349, 208);
    _outchar(2343, 209);
    _outchar(2343, 210);
    _outchar(2343, 211);
    _outchar(2343, 212);
    _outchar(2343, 213);
    _outchar(2343, 214);
    _outchar(2343, 215);
    _outchar(2343, 216);
    _outchar(2320, 228);
    _outchar(2349, 229);
    _outchar(2349, 230);
    _outchar(2310, 241);
    _outchar(2323, 245);
    _outchar(2399, 246);
    _outchar(2343, 247);
    _outchar(2343, 248);
    _outchar(2343, 249);
    _outchar(2343, 250);
    _outchar(2343, 251);
    _outchar(2319, 254);
    _outchar(2399, 271);
    _outchar(2427, 285);
    _outchar(2343, 286);
    _outchar(2343, 287);
    _outchar(2343, 288);
    _outchar(2319, 294);
    _outchar(2319, 300);
    _outchar(2429, 312);
    _outchar(2314, 321);
    _outchar(2428, 325);
    _outchar(2343, 326);
    _outchar(2343, 327);
    _outchar(2390, 333);
    _outchar(2383, 334);
    _outchar(2371, 335);
    _outchar(2373, 336);
    _outchar(2384, 338);
    _outchar(2373, 339);
    _outchar(2386, 340);
    _outchar(2372, 341);
    _outchar(2373, 342);
    _outchar(2389, 343);
    _outchar(2337, 344);
    _outchar(2428, 352);
    _outchar(2314, 361);
    _outchar(2428, 365);
    _outchar(2343, 366);
    _outchar(2428, 392);
    _outchar(2314, 400);
    _outchar(2396, 406);
    _outchar(2351, 431);
    _outchar(2314, 440);
    _outchar(2396, 446);
    _outchar(2350, 470);
    _outchar(2351, 471);
    _outchar(2349, 487);
    _outchar(2349, 488);
    _outchar(2349, 508);
    _outchar(2349, 509);
    _outchar(2400, 529);
    _outchar(2400, 530);
    _outchar(2400, 531);
    _outchar(2310, 533);
    _outchar(2350, 538);
    _outchar(2350, 540);
    _outchar(2343, 545);
    _outchar(2343, 546);
    _outchar(2343, 547);
    _outchar(2349, 572);
    _outchar(2349, 573);
    _outchar(2350, 574);
    _outchar(2350, 576);
    _outchar(2348, 578);
    _outchar(2428, 580);
    _outchar(2324, 581);
    _outchar(2350, 582);
    _outchar(2349, 583);
    _outchar(2349, 584);
    _outchar(2428, 615);
    _outchar(2428, 617);
    _outchar(2428, 621);
    _outchar(2428, 655);
    _outchar(2428, 657);
    _outchar(2318, 659);
    _outchar(2428, 661);
    _outchar(2350, 692);
    _outchar(2349, 693);
    _outchar(2365, 694);
    _outchar(2428, 695);
    _outchar(2428, 696);
    _outchar(2428, 699);
    _outchar(2428, 701);
    _outchar(2365, 702);
    _outchar(2349, 703);
    _outchar(2350, 704);
    _outchar(2400, 731);
    _outchar(2314, 732);
    _outchar(2428, 735);
    _outchar(2428, 736);
    _outchar(2428, 739);
    _outchar(2428, 741);
    _outchar(2428, 744);
    _outchar(2400, 772);
    _outchar(2349, 773);
    _outchar(2365, 774);
    _outchar(2339, 775);
    _outchar(2340, 776);
    _outchar(2341, 777);
    _outchar(2342, 778);
    _outchar(2341, 779);
    _outchar(2340, 780);
    _outchar(2339, 781);
    _outchar(2365, 782);
    _outchar(2349, 783);
    _outchar(2428, 815);
    _outchar(2312, 820);
    _outchar(2428, 821);
    _outchar(2428, 855);
    _outchar(2363, 857);
    _outchar(2362, 860);
    _outchar(2428, 861);
    _outchar(2399, 886);
    _outchar(2399, 887);
    _outchar(2399, 888);
    _outchar(2399, 889);
    _outchar(2399, 890);
    _outchar(2350, 891);
    _outchar(2348, 892);
    _outchar(2349, 893);
    _outchar(2339, 894);
    _outchar(2341, 895);
    _outchar(2342, 896);
    _outchar(2340, 897);
    _outchar(2368, 898);
    _outchar(2341, 899);
    _outchar(2339, 900);
    _outchar(2342, 901);
    _outchar(2339, 902);
    _outchar(2430, 903);
    _outchar(2348, 904);
    _outchar(2350, 905);
    _outchar(2399, 906);
    _outchar(2399, 907);
    _outchar(2399, 908);
    _outchar(2399, 909);
    _outchar(2399, 910);
    _outchar(2319, 969);
    _outchar(2319, 970);
    _outchar(2319, 971);
    _outchar(2319, 972);
    _outchar(2319, 974);
    _outchar(2319, 975);
    _outchar(2319, 976);
    _outchar(2319, 977);
    _outchar(2319, 979);
    /* "TENTAR NOVAMENTE" e "SAIR" removidos, so fica PRESSIONE ESPACO */
    _outchar(16, 1046);
    _outchar(25, 1047);
    _outchar(25, 1048);
    _outchar(25, 1049);
    _outchar(25, 1050);
    _outchar(25, 1051);
    _outchar(25, 1052);
    _outchar(25, 1053);
    _outchar(25, 1054);
    _outchar(25, 1055);
    _outchar(25, 1056);
    _outchar(25, 1057);
    _outchar(16, 1058);
    _outchar(526, 1059);
    _outchar(25, 1060);
    _outchar(25, 1061);
    _outchar(25, 1062);
    _outchar(25, 1063);
    _outchar(2327, 1064);
    _outchar(11, 1065);
    _outchar(11, 1066);
    _outchar(11, 1067);
    _outchar(11, 1068);
    _outchar(11, 1069);
    _outchar(11, 1070);
    _outchar(521, 1087);
    _outchar(521, 1088);
    _outchar(521, 1089);
    _outchar(592, 1090);
    _outchar(594, 1091);
    _outchar(581, 1092);
    _outchar(595, 1093);
    _outchar(595, 1094);
    _outchar(585, 1095);
    _outchar(591, 1096);
    _outchar(590, 1097);
    _outchar(581, 1098);
    _outchar(526, 1099);
    _outchar(526, 1100);
    _outchar(526, 1101);
    _outchar(526, 1102);
    /* PRESSIONE (lado direito, ficava em cima de BACKSPACE) removido */
    _outchar(2319, 1129);
    _outchar(2319, 1130);
    _outchar(581, 1131);
    _outchar(595, 1132);
    _outchar(592, 1133);
    _outchar(577, 1134);
    _outchar(579, 1135);
    _outchar(591, 1136);
    _outchar(2319, 1137);
    /* BACKSPACE removido */
    _outchar(2319, 1175);
    return 0;
}


    int main() {
        int sx;
        int sy;
        int tecla_atual;
        int tecla_anterior;
        int estado_jogo;   /* 0 = jogando, 1 = venceu, 2 = perdeu, 3 = desistiu */
        int idx;
        int seed;
        seed = 42;
        while (1 == 1) {
            menu();

            make_tabuleiro(seed);
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
                printYoulostScreen();
            } else {
                print_str("DESISTIU.     ESPACO", 29 * LARGURA + 8);
            }

            seed = seed + 5;
            espera_espaco();
            
            
        }

        return 0;
    }