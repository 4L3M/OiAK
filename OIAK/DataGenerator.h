//
// Created by melamela on 05.06.2024.
//

#ifndef OIAK_DATAGENERATOR_H
#define OIAK_DATAGENERATOR_H

#include <iostream>
#include <vector>
#include <random>

using namespace std;

class DataGenerator {
    int numJobs;
    int numMachines;

public:
    DataGenerator(int numJobs, int numMachines){
        this->numJobs = numJobs;
        this->numMachines = numMachines;
    }

    vector<vector<int>> generateRandomData(int minProcessingTime, int maxProcessingTime) {
        vector<vector<int>> processingTimes(numJobs, vector<int>(numMachines));
        random_device rd;
        mt19937 gen(rd());
        uniform_int_distribution<> dis(minProcessingTime, maxProcessingTime);
        for (int i = 0; i < numJobs; ++i) {
            for (int j = 0; j < numMachines; ++j) {
                processingTimes[i][j] = dis(gen);
            }
        }
        return processingTimes;
    }
};
/*
int () {
    DataGenerator dg(20, 10);
    vector<vector<int>> processingTimes = dg.generateRandomData(1, 100);
    for (const auto& row : processingTimes) {
        for (int time : row) {
            cout << time << " ";
        }
        cout << endl;
    }
    return 0;
}*/


#endif //OIAK_DATAGENERATOR_H
