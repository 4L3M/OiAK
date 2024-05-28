#include <iostream>

extern "C" size_t neh_asm(unsigned int* tab, size_t size);
//extern "C" unsigned int* insertionSort(unsigned int* tab, size_t size);
int main() {
  //unsigned int* tab;
  //tab = new unsigned int[2];
  //std::cout << neh_asm(tab, 111) << '\n';
  //return 0;
// Przykładowa tablica do sortowania
 unsigned int arr[][2] = {{1, 5}, {1, 3},{2,4},{0,1}};
    size_t size = sizeof(arr) / sizeof(arr[0]);

    neh_asm(reinterpret_cast<unsigned int*>(arr), size);

    // Wyświetl posortowaną tablicę (tutaj może być kod odpowiedzialny za wyświetlenie tablicy)
    for (size_t i = 0; i < size; ++i) {
        std::cout << "{" << arr[i][0] << ", " << arr[i][1] << "} ";
    }
    std::cout << std::endl;

    return 0;
}
