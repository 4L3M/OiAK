//
// Created by grons on 15.05.2024.
//

#include "NehAlgorithm.h"

std::vector<std::pair<int, int>> NehAlgorithm::neh(std::vector<std::pair<int, int>> &tasksArr) {
    std::vector<std::pair<int, int>> sortedArr = tasksArr;

    //sortowanie taskArr według sumy czasów
    sort(sortedArr.begin(), sortedArr.end(), [](const auto& a, const auto& b) {
        return (a.first + a.second) < (b.first + b.second);
    });
    // Lista, która będzie przechowywać optymalną kolejność zadań (narazie przechowuje tylko pierwsze zadanie z posortowanej listy zadań)
    std::vector<std::pair<int, int>> sList = {sortedArr[0]};

    for (size_t i = 1; i < sortedArr.size(); ++i) {
        int minTime = INT_MAX ; // Inicjalizacja minimalnego czasu na nieskończoność
        int bestIndex = -1;
        auto task = sortedArr[i];

        // Iteracja po wszystkich możliwych pozycjach, gdzie zadanie może być wstawione
        for (size_t j = 0; j <= sList.size(); ++j) {
            // Wstawienie zadania na pozycję j w kopii listy sList.
            auto sList_copy = sList;
            sList_copy.insert(sList_copy.begin() + j, task);
            // Obliczenie całkowitego czasu wykonania dla tego ustawienia.
            int time = totalTime(sList_copy);

            // Jeśli obliczony czas jest mniejszy niż dotychczasowy minimalny czas,
            // zapisanie go jako nowy minimalny czas i indeksu, gdzie zadanie powinno być wstawione.
            if (time < minTime) {
                minTime = time;
                bestIndex = j;
            }
        }

        // Wstawienie zadania na najlepszą pozycję
        sList.insert(sList.begin() + bestIndex, task);
    }

    return sList;
}

int NehAlgorithm::totalTime(std::vector<std::pair<int, int>> &seq) {
    int totalTime = 0;
    std::vector<int> leadTimes(seq.size(), 0);

    // Iteracja po wszystkich zadaniach w sekwencji.
    for (size_t i = 0; i < seq.size(); ++i) {
        // Obliczenie czasu oczekiwania (lead time) dla każdego zadania.
        leadTimes[i] = (i > 0 ? leadTimes[i-1] : 0) + seq[i].first;
        // Dodanie do całkowitego czasu wykonania iloczynu czasu oczekiwania i czasu trwania zadania.
        totalTime += leadTimes[i] * seq[i].second;
    }

    return totalTime;
}