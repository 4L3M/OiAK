#include <iostream>
#include "NehAlgorithm.h"
#include "DataGenerator.h"
#include <vector>

int main() {
    // Przykładowa tablica dwuwymiarowa zawierająca czasy na różnych maszynach
//    std::vector<std::pair<int, int>> tasksArr = {{2, 3}, {1, 5}, {4, 2}, {7, 4}};

    std::vector<std::pair<int,int>> tasksArr = generateData(20);
    NehAlgorithm nehAlgorithm1;
    // Wywołanie funkcji NEH
    auto optimizedSeq = nehAlgorithm1.neh(tasksArr);

    std::cout << "Optymalna kolejnosc:";
    for (const auto& task : optimizedSeq) {
        std::cout << " (" << task.first << ", " << task.second << ")";
    }
    std::cout << std::endl;

    std::cout << "Całkowity czas wykonania: " << nehAlgorithm1.totalTime(optimizedSeq) << std::endl;
    return 0;
}
