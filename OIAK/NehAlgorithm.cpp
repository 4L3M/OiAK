#include <iostream>
#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

class NehAlgorithm {
public:
    vector<int> neh(vector<vector<int>> &processingTimes);
    int totalTime(vector<vector<int>> &processingTimes, vector<int> &seq);
};
vector<int> NehAlgorithm::neh(vector<vector<int>> &processingTimes) {
    int numJobs = processingTimes.size();
    int numMachines = processingTimes[0].size();

    // Tworzenie listy zadań z sumami czasów na wszystkich maszynach
    vector<pair<int, int>> tasks(numJobs);
    for (int i = 0; i < numJobs; ++i) {
        int sum = 0;
        for (int j = 0; j < numMachines; ++j) {
            sum += processingTimes[i][j];
        }
        tasks[i] = {sum, i};
    }

    // Sortowanie zadań według sumy czasów w odwrotnej kolejności (od największej do najmniejszej sumy)
    sort(tasks.begin(), tasks.end(), [](const auto& a, const auto& b) {
        return a.first > b.first;
    });

    // Lista, która będzie przechowywać optymalną kolejność zadań (na razie przechowuje tylko pierwsze zadanie z posortowanej listy zadań)
    vector<int> sList = {tasks[0].second};

    for (size_t i = 1; i < tasks.size(); ++i) {
        int minTime = INT_MAX; // Inicjalizacja minimalnego czasu na nieskończoność
        int bestIndex = -1;
        int taskIndex = tasks[i].second;

        // Iteracja po wszystkich możliwych pozycjach, gdzie zadanie może być wstawione
        for (size_t j = 0; j <= sList.size(); ++j) {
            // Wstawienie zadania na pozycję j w kopii listy sList
            auto sList_copy = sList;
            sList_copy.insert(sList_copy.begin() + j, taskIndex);
            // Obliczenie całkowitego czasu wykonania dla tego ustawienia
            int time = totalTime(processingTimes, sList_copy);

            // Jeśli obliczony czas jest mniejszy niż dotychczasowy minimalny czas,
            // zapisanie go jako nowy minimalny czas i indeksu, gdzie zadanie powinno być wstawione
            if (time < minTime) {
                minTime = time;
                bestIndex = j;
            }
        }

        // Wstawienie zadania na najlepszą pozycję
        sList.insert(sList.begin() + bestIndex, taskIndex);
    }

    return sList;
}

int NehAlgorithm::totalTime(vector<vector<int>> &processingTimes, vector<int> &seq) {
    int numJobs = seq.size();
    int numMachines = processingTimes[0].size();

    // Tablica czasów zakończenia dla każdej maszyny
    vector<int> machineEndTimes(numMachines, 0);
    // Tablica czasów zakończenia dla każdego zadania
    vector<int> jobEndTimes(numJobs, 0);

    for (int i = 0; i < numJobs; ++i) {
        int jobIndex = seq[i];
        for (int j = 0; j < numMachines; ++j) {
            if (i == 0) {
                machineEndTimes[j] = (j == 0 ? 0 : machineEndTimes[j - 1]) + processingTimes[jobIndex][j];
            } else {
                machineEndTimes[j] = max(machineEndTimes[j], jobEndTimes[i - 1]) + processingTimes[jobIndex][j];
            }
        }
        jobEndTimes[i] = machineEndTimes[numMachines - 1];
    }

    return jobEndTimes[numJobs - 1];
}

int mainNeh() {
    NehAlgorithm algorithm;
    vector<vector<int>> processingTimes = { {2, 3, 2}, {4, 10, 3}, {3, 2, 4} };
    auto result = algorithm.neh(processingTimes);

    cout << "Optimal order of tasks:\n";
    for (const auto& task : result) {
        cout << task << " ";
    }
    cout << "\n";

    return 0;
}
