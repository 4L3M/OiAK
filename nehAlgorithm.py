def neh(tasksArr):
    # sortowanie tablicy według sumy czsów wykonania każdego zadania
    sortedArr = sorted(tasksArr, key=lambda x: sum(x))

    #sList - lista która będzie przechowywać optymalną kolejnośc zadań narazie przechowuje tylko pierwsze zadanie z posortowanej listy zadań
    sList = [sortedArr[0]]

    # Iteracyja po wszystkich zadaniach zaczynając od drugiego
    for i in range(1, len(sortedArr)):
        minTime = float('inf') #inicjalizacja minimalnego czasu na nieskończoność
        bestIndex = -1
        task = sortedArr[i]

        #iteracja po wszystkich możliwych pozycjach dzie zadanie może być wstawione
        for j in range(len(sList) + 1):
            # Wstawienie zadania na pozycję j w kopii listy sList.
            sList_copy = sList[:]
            sList_copy.insert(j, task)
            # Obliczenie całkowitego czasu wykonania dla tego ustawienia.
            time = totalTime(sList_copy)

            # Jeśli obliczony czas jest mniejszy niż dotychczasowy minimalny czas,
            # zapisanie go jako nowy minimalny czas i indeksu, gdzie zadanie powinno być wstawione.
            if time < minTime:
                minTime = time
                bestIndex = j

        # Wstawienie zadania na najlepszą pozycję
        sList.insert(bestIndex, task)

    return sList

def totalTime(seq):
    totalTime = 0
    leadTimes = [0] * len(seq)

    # Iteracja po wszystkich zadaniach w sekwencji.
    for i, task in enumerate(seq):
        # Obliczenie czasu oczekiwania (lead time) dla każdego zadania.
        leadTimes[i] = (leadTimes[i-1] if i > 0 else 0) + task[0]
        # Dodanie do całkowitego czasu wykonania iloczynu czasu oczekiwania i czasu trwania zadania.
        totalTime += leadTimes[i] * task[1]

    return totalTime

# Przykładowe tablica dwuwymiarowa
tasksArr = [(2, 3), (1, 5), (4, 2), (7, 4)]

# Wywołanie funkcji NEH
optimizedSeq = neh(tasksArr)
print("Optymalna kolejność:", optimizedSeq)
print("Całkowity czas wykonania:", totalTime(optimizedSeq))