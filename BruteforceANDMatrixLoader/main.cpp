#include <iostream>
#include <vector>
#include "Matrixloader.h"

const int N = 4;

void swap(int& a, int& b) {
    int temp = a;
    a = b;
    b = temp;
}

int calculateDistance(int distances[N][N], int path[N], int n) {

    int distance = 0;

    for (int s = 0; s < n-1; s++) {               // s - source
        distance += distances[path[s]][path[s + 1]];
    }
    distance += distances[path[n-1]][path[0]];
    return distance;
}


int bruteForce(int permutation[N], int n, int distances[N][N]) {
    bool finished = false;
    int min_dist = 99999999999;

    while (!finished) {
//        for (int i = 0; i < n; i++) {
//            std::cout << permutation[i]<<" ";
//        }
//        std::cout << "\n";
        int distance = calculateDistance(distances, permutation, n);
        if (min_dist > distance) {
            min_dist = distance;
        }

        int k = -1;
        for (int i = 1; i < n - 1; ++i) {
            if (permutation[i] < permutation[i + 1]) {
                k = i;
            }
        }

        if (k == -1) {
            finished = true;
        }



        else {
            int l = k + 1;
            for (int i = k + 1; i < n; ++i) {
                if (permutation[k] < permutation[i]) {
                    l = i;
                }
            }
            swap(permutation[k], permutation[l]);
            int start = k + 1;
            int end = n - 1;
            while (start < end) {
                swap(permutation[start], permutation[end]);
                ++start;
                --end;
            }
        }
    }
    return min_dist;
}

int main() {
    int distances[N][N] = {
            {-1, 5, 2, 2},
            {8, -1, 8, 1},
            {1, 4, -1, 3},
            {7, 6, 3, -1}
    };
    int permutation[] = {0,1,2,3};
    for (int i = 0; i < N; ++i) {
        permutation[i] = i;
    }

    std::cout<<bruteForce(permutation, N, distances);
    Matrixloader fl;
    std::cout<<std::endl;
    int ** sources = fl.loadRandomData(5, 12414);
    fl.showTab();
    return 0;
}
