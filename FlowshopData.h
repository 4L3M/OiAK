#include <iostream>
#include <iomanip>
#include <vector>
#include <cstdlib>
#include <ctime>

using namespace std;

class FlowshopData {
public:
    void generateData(int numTasks, int numMachines) {
        cout << numTasks << " " << numMachines << "\n";

        srand(time(nullptr));

        for (int i = 1; i <= numTasks; ++i) {

            for (int j = 0; j < numMachines; ++j) {;
                int time = (rand() % 100) + 1;
                cout << "\t" << j+1 << " " << time;
            }
            cout << "\n";
        }
    }
};