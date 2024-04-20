//
// Created by Amelia on 20.04.2024.
//

#ifndef OIAK_MATRIXLOADER_H
#define OIAK_MATRIXLOADER_H


#include <fstream>
#include <iostream>
#include <iomanip>
#include <string>

class Matrixloader {
public:
    int** tab;
    int size;
    Matrixloader() {
        this->size = 0;
        tab = NULL;
    }
    int** loadFromFile(std::string path) {
        std::ifstream file(path);
        if (!file.good()) {
            std::cout << "Blednie podana nazwa pliku\n";
            return NULL;
        }
        int N = 0;
        file >> N;
        int word;
        alocate(N);
        for (int i = 0; i < size; i++) {
            for (int j = 0; j < size; j++) {
                file >> word;
                tab[i][j] = word;
            }
        }
        return tab;
    }

    void alocate(int N) {
        this->size = N;
        tab = new int* [N];
        for (int i = 0; i < N; ++i) {
            tab[i] = new int[N];
        }
    }



    void showTab() {
        if (tab != NULL) {
            for (int i = 0; i < size; i++) {
                for (int j = 0; j < size; j++) {
                    if (tab[i][j] != -1)
                        std::cout << std::setw(3) << tab[i][j] << " ";
                    else std::cout << " -1" << " ";
                }
                std::cout << std::endl;
            }
        }
    }

    int** loadRandomData(int N, int sand) {

        int* source = new int[N * N - N];
        ordertable(source, N * N - N);
        randomshuttle(source, N * N - N, 1, sand);
        alocate(N);
        int k = 0;
        for (int i = 0; i < size; i++) {
            for (int j = 0; j < size; j++) {
                if (i == j) {
                    tab[i][j] = -1;
                    continue;
                }
                tab[i][j] = source[k];
                k++;
            }
        }
        return tab;
    }

    void ordertable(int randtab[], int number) {
        for (int i = 0; i < number; i++) {
            randtab[i] = i + 1;
        }
    }

    void randomshuttle(int randtab[], int number, int testnumber, int lpoj) {
        if (number == 0)return;
        srand((lpoj * 100 + testnumber) * 845);
        srand(time(NULL) + (lpoj * 51));

        for (int i = 0; i < number; i++) {
            int randomplace1 = rand() % number;
            randomplace1 = randomplace1 * rand() % number;
            int randomplace2 = rand() % number;
            randomplace2 = randomplace2 * rand() % number;
            int swap = randtab[randomplace1];
            randtab[randomplace1] = randtab[randomplace2];
            randtab[randomplace2] = swap;
        }
    }
};


#endif //OIAK_MATRIXLOADER_H
