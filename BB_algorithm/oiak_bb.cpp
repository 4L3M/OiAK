#include <iostream>
#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

// Funkcja obliczaj�ca czas przetwarzania dla danej permutacji
int calculateMakespan(const vector<int>& perm, const vector<vector<int>>& processingTimes) {
    int numJobs = perm.size();
    int numMachines = processingTimes[0].size();
    vector<vector<int>> completionTimes(numJobs, vector<int>(numMachines, 0));

    for (int i = 0; i < numJobs; ++i) {
        for (int j = 0; j < numMachines; ++j) {
            int timeJobStarts = (j == 0) ? 0 : completionTimes[i][j - 1];
            int timeMachineIsFree = (i == 0) ? 0 : completionTimes[i - 1][j];
            completionTimes[i][j] = max(timeJobStarts, timeMachineIsFree) + processingTimes[perm[i]][j];
        }
    }
    return completionTimes[numJobs - 1][numMachines - 1];
}

// Oblicza doln� granic� dla aktualnej permutacji (na podstawie pozosta�ych zada�)
int lowerBound(const vector<int>& perm, const vector<vector<int>>& processingTimes, int numMachines) {
    vector<bool> included(processingTimes.size(), false);
    for (int job : perm) included[job] = true;

    int lb = 0;
    for (int i = 0; i < included.size(); ++i) {
        if (!included[i]) {
            int minTime = INT_MAX;
            for (int j = 0; j < numMachines; ++j) {
                minTime = min(minTime, processingTimes[i][j]);
            }
            lb += minTime;
        }
    }
    return lb;
}

// Rekurencyjna funkcja branch and bound
void branchAndBound(vector<int>& perm, const vector<vector<int>>& processingTimes, int& bestMakespan, vector<int>& bestPerm, vector<int>& currentPerm) {
    if (currentPerm.size() == processingTimes.size()) {
        int makespan = calculateMakespan(currentPerm, processingTimes);
        if (makespan < bestMakespan) {
            bestMakespan = makespan;
            bestPerm = currentPerm;
        }
    }
    else {
        for (int i = 0; i < processingTimes.size(); ++i) {
            if (find(currentPerm.begin(), currentPerm.end(), i) == currentPerm.end()) {
                currentPerm.push_back(i);
                int estimatedBound = calculateMakespan(currentPerm, processingTimes) + lowerBound(currentPerm, processingTimes, processingTimes[0].size());
                if (estimatedBound < bestMakespan) {
                    branchAndBound(perm, processingTimes, bestMakespan, bestPerm, currentPerm);
                }
                currentPerm.pop_back();
            }
        }
    }
}

int main() {
    vector<vector<int>> processingTimes = { {2, 3, 2}, {4, 10, 3}, {3, 2, 4} };
    int bestMakespan = INT_MAX;
    vector<int> bestPerm;
    vector<int> perm;
    branchAndBound(perm, processingTimes, bestMakespan, bestPerm, perm);

    cout << "Best permutation: ";
    for (int i : bestPerm) cout << i << " ";
    cout << "\nBest makespan: " << bestMakespan << endl;
    return 0;
}
