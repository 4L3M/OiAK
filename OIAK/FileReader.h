//
// Created by melamela on 05.06.2024.
//

#ifndef OIAK_FILEREADER_H
#define OIAK_FILEREADER_H

#include <iostream>
#include <fstream>
#include <string>
#include <vector>

using namespace std;
class FileReader {

    public:
    static vector<vector<int>> loadFromFile(const string& filename) {
        ifstream file(filename);
        if (!file.good()) {
            cout << "Blednie podana nazwa pliku: " << filename << "\n";
            return {};
        }
        int jobs, machines = 0;
        file >> jobs >> machines;
        vector<vector<int>> processingTimes(jobs, vector<int>(machines));
        for (int i = 0; i < jobs; ++i) {
            for (int j = 0; j < machines; ++j) {
                int machineIndex, processingTime;
                file >> machineIndex >> processingTime;
                processingTimes[i][j] = processingTime;
            }
        }
        file.close();
        return processingTimes;

    }

    static void printProcessingTimes(const std::vector<std::vector<int>>& processingTimes) {
        for (const auto& row : processingTimes) {
            for (int time : row) {
                std::cout << time << " ";
            }
            std::cout << std::endl;
        }
    }




    int * loadfromfileINT(std::string filename, int sizetab[]) {
        std::ifstream file(filename);
        if (!file.good()) {
            std::cout << "Blednie podana nazwa pliku: "<<filename<<"\n" ;
            return NULL;
        }
        int size = 0;
        file >> size;
        int * tab = new int[size];
        for(int i = 0; i < size; i++){
            file >> tab[i];
        }
        for (int i = 0; i < size; ++i) {
            std::cout<< tab[i] << " ";
        }
        std::cout << std::endl;
        file.close();
        sizetab[0]=size;
        return tab;
    }



    int saveFile(string nazwaPliku, string zawartosc) {

        ofstream plik(nazwaPliku); // Otwarcie pliku do zapisu

        if (!plik) {
            cerr << "Nie mozna utworzyc pliku." << endl;
            return 1;
        }

        plik << zawartosc; // Zapisanie zawartosci do pliku
        plik.close(); // Zamknięcie pliku

        cout << "Zawartosc zostala zapisana do pliku." << endl;

        return 0;
    }

    template < typename T >
    int saveFile2(string nazwaPliku, T tab[], int size) {

        ofstream plik(nazwaPliku); // Otwarcie pliku do zapisu

        if (!plik) {
            cerr << "Nie mozna utworzyc pliku." << endl;
            return 1;
        }

        for(int i = 0; i < size; i++){
            plik << tab[i] << " ";
        }
        plik << endl;

        plik.close(); // Zamknięcie pliku

        cout << "Zawartosc zostala zapisana do pliku." << endl;

        return 0;
    }
};

/*int mainf() {
    std::string filename = "C:\\Users\\melamela\\CLionProjects\\OIAK\\flowshop.txt";
    int numJobs, numMachines;

    std::vector<std::vector<int>> processingTimes = FileReader::loadFromFile(filename);

    if (!processingTimes.empty()) {
        std::cout << "Loaded processing times (" << numJobs << " jobs, " << numMachines << " machines):\n";
        FileReader::printProcessingTimes(processingTimes);
    } else {
        std::cerr << "Failed to load processing times from file: " << filename << "\n";
    }

    return 0;
}*/
#endif //OIAK_FILEREADER_H
