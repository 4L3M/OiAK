#include <iostream>

#define MAX_JOBS 100
#define MAX_MACHINES 100
extern "C" void neh_algorithm(int processingTimes[MAX_JOBS][MAX_MACHINES], int numJobs, int numMachines, int optimalOrder[MAX_JOBS]);
//extern "C" size_t neh_asm(int (*tasksArr)[2], int size);
//extern "C" unsigned int* insertionSort(unsigned int* tab, size_t size);
int main() {
  // Przykładowa tablica dwuwymiarowa zawierająca czasy na różnych maszynach
  /*  int tasksArr[][2] = {{5,3},{2, 3}, {1, 5}, {4, 2}, {7, 4}};
    int size = sizeof(tasksArr) / sizeof(tasksArr[0]);

    // Wywołanie funkcji NEH i uzyskanie całkowitego czasu wykonania
    int total_time = neh_asm(tasksArr, size);

    // Wyświetlenie optymalnej kolejności
    printf("Optimal sequence: ");
    for (int i = 0; i < size; ++i) {
        printf("(%d, %d) ", tasksArr[i][0], tasksArr[i][1]);
    }
    printf("\n");

    // Wyświetlenie całkowitego czasu wykonania
    printf("Total time: %d\n", total_time);
*/
    // Przykładowe dane wejściowe: czasy przetwarzania dla 4 zadań na 3 maszynach
    int processingTimes[MAX_JOBS][MAX_MACHINES] = {
	{2, 3, 2}, {4, 10, 3}, {3, 2, 4}
    };

    int numJobs = 3;
    int numMachines = 3;

    int optimalOrder[MAX_JOBS];
    neh_algorithm(processingTimes, numJobs, numMachines, optimalOrder);

    printf("Optimal job order: ");
    for (int i = 0; i < numJobs; ++i) {
        printf("%d ", optimalOrder[i] ); // +1 aby używać numeracji zadań od 1
    }
    printf("\n");

    return 0;
    return 0;
}
