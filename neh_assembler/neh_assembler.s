.text
.global neh_algorithm
#void neh_algorithm(int processingTimes[MAX_JOBS][MAX_MACHINES], int numJobs, int numMachines, int optimalOrder[MAX_JOBS]);
#int calculateMakespan(int processingTimes[MAX_JOBS][MAX_MACHINES], int jobOrder[MAX_JOBS], int numJobs, int numMachines)

calculate_makespan:
        pushq   %rbp
        movq    %rsp, %rbp
        subq    $39928, %rsp  # Rezerwuje 39928 bajtów na stosie dla zmiennych lokalnych
        movq    %rdi, -40024(%rbp)   #zapisz pierwszy argument prossesingTimes
        movq    %rsi, -40032(%rbp)  # Zapisz drugi argument funkcji numJobs
        movl    %edx, -40036(%rbp)   # Zapisz trzeci argument funkcji numMaschines
        movl    %ecx, -40040(%rbp)
        movl    $0, -4(%rbp)  #inicjacja i na 0
        jmp     outer_loop_check  # Skocz do sprawdzenia pętli zewnętrznej

calculate_makespan_outher_loop:
        movl    -4(%rbp), %eax  # Załaduj i do eax
        cltq       # Rozszerz znakowo %eax do %rax
        leaq    0(,%rax,4), %rdx  # Oblicz 4 * %rax (i * 4)
        movq    -40032(%rbp), %rax  # Załaduj drugi argument funkcji (numJobs) %rax
        addq    %rdx, %rax  # Dodaj offset do wskaźnika bazowego
        movl    (%rax), %eax  # Załaduj wartość z pamięci do %eax
        movl    %eax, -12(%rbp)  # Zapisz wartość do zmiennej lokalnej pod adresem -12(%rbp)
        movl    $0, -8(%rbp)   #ustaw j na 0
        jmp     inner_loop_check #skocz do inner_loop_check

calculate_makespan_inner_loop:
        cmpl    $0, -4(%rbp)   #porównuje i z 0
        jne     first_else_if_calculate_makespan  #Skacze do etykiety jeśli 'i' nie jest 0
        cmpl    $0, -8(%rbp) #porównuje j z 0
        jne     first_else_if_calculate_makespan  #Skacze do etykiety jeśli 'j' nie jest 0
        movl    -12(%rbp), %eax  #numJobs do eax
        movslq  %eax, %rdx  #Konwertuje wartość na 64-bitową w rdx
        movq    %rdx, %rax
        salq    $2, %rax  #Przesuwa wartość w rax o 4 bity w lewo (mnożenie przez 4)
        addq    %rdx, %rax
        leaq    0(,%rax,4), %rdx
        addq    %rdx, %rax
        salq    $4, %rax
        movq    %rax, %rdx
        movq    -40024(%rbp), %rax #ładuje wskaźnik na tablice processingTimes do rax
        addq    %rax, %rdx   #dodaje rax+rdx
        movl    -8(%rbp), %eax  #j do eax
        cltq
        movl    (%rdx,%rax,4), %ecx #Ładuje wartość spod adresu rdx + 4 * rax do ecx
        movl    -8(%rbp), %eax  #j do eax
        movslq  %eax, %rsi
        movl    -4(%rbp), %eax #i do eax
        movslq  %eax, %rdx
        movq    %rdx, %rax
        salq    $2, %rax # Przesuwa rax w lewo o 2 bity (mnoży przez 4)
        addq    %rdx, %rax
        leaq    0(,%rax,4), %rdx
        addq    %rdx, %rax
        salq    $2, %rax
        addq    %rsi, %rax
        movl    %ecx, -40016(%rbp,%rax,4) # Przechowaj wynik w 2D tablicy na stosie
        jmp     increment_i  #sokocz do increment_i

first_else_if_calculate_makespan:
        cmpl    $0, -4(%rbp)    #porównanie i z 0
        jne     second_else_if_calculate_makespan # Jeśli 'i' nie jest 0 skocz
        movl    -8(%rbp), %eax  #j do eax
        subl    $1, %eax #j--
        movslq  %eax, %rcx
        movl    -4(%rbp), %eax  #i do eax
        movslq  %eax, %rdx
        movq    %rdx, %rax
        salq    $2, %rax
        addq    %rdx, %rax
        leaq    0(,%rax,4), %rdx
        addq    %rdx, %rax
        salq    $2, %rax
        addq    %rcx, %rax
        movl    -40016(%rbp,%rax,4), %ecx  # # Wczytaj wartość z 2D tablicy na stosie
        movl    -12(%rbp), %eax   # Wczytaj wartość przechowywaną w zmiennej lokalnej
        movslq  %eax, %rdx
        movq    %rdx, %rax
        salq    $2, %rax
        addq    %rdx, %rax
        leaq    0(,%rax,4), %rdx # Pomnóż 'rax' przez 4 i zapisz w 'rdx'
        addq    %rdx, %rax
        salq    $4, %rax
        movq    %rax, %rdx
        movq    -40024(%rbp), %rax  #przenieś tablice do rax
        addq    %rax, %rdx
        movl    -8(%rbp), %eax
        cltq
        movl    (%rdx,%rax,4), %eax
        addl    %eax, %ecx
        movl    -8(%rbp), %eax
        movslq  %eax, %rsi
        movl    -4(%rbp), %eax
        movslq  %eax, %rdx
        movq    %rdx, %rax
        salq    $2, %rax
        addq    %rdx, %rax
        leaq    0(,%rax,4), %rdx
        addq    %rdx, %rax
        salq    $2, %rax
        addq    %rsi, %rax
        movl    %ecx, -40016(%rbp,%rax,4)
        jmp     increment_i

second_else_if_calculate_makespan:
        cmpl    $0, -8(%rbp)
        jne     else_calculate_makespan
        movl    -4(%rbp), %eax
        leal    -1(%rax), %edx
        movl    -8(%rbp), %eax
        movslq  %eax, %rcx
        movslq  %edx, %rdx
        movq    %rdx, %rax
        salq    $2, %rax
        addq    %rdx, %rax
        leaq    0(,%rax,4), %rdx
        addq    %rdx, %rax
        salq    $2, %rax
        addq    %rcx, %rax
        movl    -40016(%rbp,%rax,4), %ecx
        movl    -12(%rbp), %eax
        movslq  %eax, %rdx
        movq    %rdx, %rax
        salq    $2, %rax
        addq    %rdx, %rax
        leaq    0(,%rax,4), %rdx
        addq    %rdx, %rax
        salq    $4, %rax
        movq    %rax, %rdx
        movq    -40024(%rbp), %rax
        addq    %rax, %rdx
        movl    -8(%rbp), %eax
        cltq
        movl    (%rdx,%rax,4), %eax
        addl    %eax, %ecx
        movl    -8(%rbp), %eax
        movslq  %eax, %rsi
        movl    -4(%rbp), %eax
        movslq  %eax, %rdx
        movq    %rdx, %rax
        salq    $2, %rax
        addq    %rdx, %rax
        leaq    0(,%rax,4), %rdx
        addq    %rdx, %rax
        salq    $2, %rax
        addq    %rsi, %rax
        movl    %ecx, -40016(%rbp,%rax,4)
        jmp     increment_i

else_calculate_makespan:
        movl    -4(%rbp), %eax
        leal    -1(%rax), %edx
        movl    -8(%rbp), %eax
        movslq  %eax, %rcx
        movslq  %edx, %rdx
        movq    %rdx, %rax
        salq    $2, %rax
        addq    %rdx, %rax
        leaq    0(,%rax,4), %rdx
        addq    %rdx, %rax
        salq    $2, %rax
        addq    %rcx, %rax
        movl    -40016(%rbp,%rax,4), %ecx
        movl    -8(%rbp), %eax
        subl    $1, %eax
        movslq  %eax, %rsi
        movl    -4(%rbp), %eax
        movslq  %eax, %rdx
        movq    %rdx, %rax
        salq    $2, %rax
        addq    %rdx, %rax
        leaq    0(,%rax,4), %rdx
        addq    %rdx, %rax
        salq    $2, %rax
        addq    %rsi, %rax
        movl    -40016(%rbp,%rax,4), %eax
        cmpl    %eax, %ecx
        jle     if_completion_time_setting
        movl    -4(%rbp), %eax
        leal    -1(%rax), %edx
        movl    -8(%rbp), %eax
        movslq  %eax, %rcx
        movslq  %edx, %rdx
        movq    %rdx, %rax
        salq    $2, %rax
        addq    %rdx, %rax
        leaq    0(,%rax,4), %rdx
        addq    %rdx, %rax
        salq    $2, %rax
        addq    %rcx, %rax
        movl    -40016(%rbp,%rax,4), %edx
        jmp     check_competition_time

if_completion_time_setting:
        movl    -8(%rbp), %eax
        subl    $1, %eax
        movslq  %eax, %rcx
        movl    -4(%rbp), %eax
        movslq  %eax, %rdx
        movq    %rdx, %rax
        salq    $2, %rax
        addq    %rdx, %rax
        leaq    0(,%rax,4), %rdx
        addq    %rdx, %rax
        salq    $2, %rax
        addq    %rcx, %rax
        movl    -40016(%rbp,%rax,4), %edx

check_competition_time:
        movl    -12(%rbp), %eax
        movslq  %eax, %rcx
        movq    %rcx, %rax
        salq    $2, %rax
        addq    %rcx, %rax
        leaq    0(,%rax,4), %rcx
        addq    %rcx, %rax
        salq    $4, %rax
        movq    %rax, %rcx
        movq    -40024(%rbp), %rax
        addq    %rax, %rcx
        movl    -8(%rbp), %eax
        cltq
        movl    (%rcx,%rax,4), %eax
        leal    (%rdx,%rax), %ecx
        movl    -8(%rbp), %eax
        movslq  %eax, %rsi
        movl    -4(%rbp), %eax
        movslq  %eax, %rdx
        movq    %rdx, %rax
        salq    $2, %rax
        addq    %rdx, %rax
        leaq    0(,%rax,4), %rdx
        addq    %rdx, %rax
        salq    $2, %rax
        addq    %rsi, %rax
        movl    %ecx, -40016(%rbp,%rax,4)
increment_i:
        addl    $1, -8(%rbp)
inner_loop_check:
        movl    -8(%rbp), %eax
        cmpl    -40040(%rbp), %eax
        jl      calculate_makespan_inner_loop
        addl    $1, -4(%rbp)
outer_loop_check:#.L2:
        movl    -4(%rbp), %eax
        cmpl    -40036(%rbp), %eax
        jl      calculate_makespan_outher_loop
        movl    -40036(%rbp), %eax
        leal    -1(%rax), %edx
        movl    -40040(%rbp), %eax
        subl    $1, %eax
        movslq  %eax, %rcx
        movslq  %edx, %rdx
        movq    %rdx, %rax
        salq    $2, %rax
        addq    %rdx, %rax
        leaq    0(,%rax,4), %rdx
        addq    %rdx, %rax
        salq    $2, %rax
        addq    %rcx, %rax
        movl    -40016(%rbp,%rax,4), %eax
        leave
        ret


insertion_sort:
        pushq   %rbp                    # Zapisz obecny wskaźnik stosu
        movq    %rsp, %rbp              # Ustaw nowy wskaźnik stosu
        movq    %rdi, -24(%rbp)         # Przechowaj pierwszy argument (tablica) na stosie
        movl    %esi, -28(%rbp)         # Przechowaj drugi argument (rozmiar tablicy) na stosie
        movl    $1, -4(%rbp)            # Inicjalizuj zmienną 'i' na 1
        jmp     insertion_sort_outer_loop_check  # Skocz do sprawdzenia warunku pętli zewnętrznej

insertion_sort_outer_loop:
        movl    -4(%rbp), %eax          # Załaduj wartość 'i'
        cltq                            # Przekonwertuj 'eax' na 'rax' (rozszerzenie do 64-bit)
        leaq    0(,%rax,8), %rdx        # Oblicz offset dla elementu tablicy (i * 8)
        movq    -24(%rbp), %rax         # Załaduj wskaźnik do tablicy
        addq    %rdx, %rax              # Dodaj offset do wskaźnika tablicy
        movl    (%rax), %eax            # Załaduj wartość elementu tablicy
        movl    %eax, -16(%rbp)         # Przechowaj tę wartość jako 'key'
        movl    -4(%rbp), %eax          # Załaduj wartość 'i'
        cltq                            # Przekonwertuj 'eax' na 'rax'
        leaq    0(,%rax,8), %rdx        # Oblicz offset dla elementu tablicy (i * 8)
        movq    -24(%rbp), %rax         # Załaduj wskaźnik do tablicy
        addq    %rdx, %rax              # Dodaj offset do wskaźnika tablicy
        movl    4(%rax), %eax           # Załaduj wartość elementu tablicy (i+1)
        movl    %eax, -12(%rbp)         # Przechowaj tę wartość jako 'next_key'
        movl    -4(%rbp), %eax          # Załaduj wartość 'i'
        subl    $1, %eax                # Zmniejsz 'i' o 1
        movl    %eax, -8(%rbp)          # Przechowaj tę wartość jako 'j'
        jmp     insertion_sort_inner_loop_check  # Skocz do sprawdzenia warunku pętli wewnętrznej

insertion_sort_inner_loop:
        movl    -8(%rbp), %eax          # Załaduj wartość 'j'
        cltq                            # Przekonwertuj 'eax' na 'rax'
        leaq    0(,%rax,8), %rdx        # Oblicz offset dla elementu tablicy (j * 8)
        movq    -24(%rbp), %rax         # Załaduj wskaźnik do tablicy
        addq    %rdx, %rax              # Dodaj offset do wskaźnika tablicy
        movl    -8(%rbp), %edx          # Załaduj wartość 'j'
        movslq  %edx, %rdx              # Przekonwertuj 'edx' na 'rdx'
        addq    $1, %rdx                # Zwiększ 'rdx' o 1
        leaq    0(,%rdx,8), %rcx        # Oblicz offset dla elementu tablicy (j+1 * 8)
        movq    -24(%rbp), %rdx         # Załaduj wskaźnik do tablicy
        addq    %rcx, %rdx              # Dodaj offset do wskaźnika tablicy
        movl    (%rax), %eax            # Załaduj wartość elementu tablicy (j)
        movl    %eax, (%rdx)            # Przenieś tę wartość na miejsce (j+1)
        movl    -8(%rbp), %eax          # Załaduj wartość 'j'
        cltq                            # Przekonwertuj 'eax' na 'rax'
        leaq    0(,%rax,8), %rdx        # Oblicz offset dla elementu tablicy (j * 8)
        movq    -24(%rbp), %rax         # Załaduj wskaźnik do tablicy
        addq    %rdx, %rax              # Dodaj offset do wskaźnika tablicy
        movl    -8(%rbp), %edx          # Załaduj wartość 'j'
        movslq  %edx, %rdx              # Przekonwertuj 'edx' na 'rdx'
        addq    $1, %rdx                # Zwiększ 'rdx' o 1
        leaq    0(,%rdx,8), %rcx        # Oblicz offset dla elementu tablicy (j+1 * 8)
        movq    -24(%rbp), %rdx         # Załaduj wskaźnik do tablicy
        addq    %rcx, %rdx              # Dodaj offset do wskaźnika tablicy
        movl    4(%rax), %eax           # Załaduj wartość elementu tablicy (j+1)
        movl    %eax, 4(%rdx)           # Przenieś tę wartość na miejsce (j+1)
        subl    $1, -8(%rbp)            # Zmniejsz 'j' o 1

insertion_sort_inner_loop_check:
        cmpl    $0, -8(%rbp)            # Sprawdź czy 'j' jest mniejsze niż 0
        js      insert_key              # Jeśli tak, skocz do 'insert_key'
        movl    -8(%rbp), %eax          # Załaduj wartość 'j'
        cltq                            # Przekonwertuj 'eax' na 'rax'
        leaq    0(,%rax,8), %rdx        # Oblicz offset dla elementu tablicy (j * 8)
        movq    -24(%rbp), %rax         # Załaduj wskaźnik do tablicy
        addq    %rdx, %rax              # Dodaj offset do wskaźnika tablicy
        movl    4(%rax), %edx           # Załaduj wartość elementu tablicy (j)
        movl    -12(%rbp), %eax         # Załaduj wartość 'next_key'
        cmpl    %eax, %edx              # Porównaj 'next_key' z elementem tablicy (j)
        jl      insertion_sort_inner_loop  # Jeśli element tablicy (j) jest mniejszy, skocz do 'insertion_sort_inner_loop'

insert_key:
        movl    -8(%rbp), %eax          # Załaduj wartość 'j'
        cltq                            # Przekonwertuj 'eax' na 'rax'
        addq    $1, %rax                # Zwiększ 'rax' o 1
        leaq    0(,%rax,8), %rdx        # Oblicz offset dla elementu tablicy (j+1 * 8)
        movq    -24(%rbp), %rax         # Załaduj wskaźnik do tablicy
        addq    %rax, %rdx              # Dodaj offset do wskaźnika tablicy
        movl    -16(%rbp), %eax         # Załaduj wartość 'key'
        movl    %eax, (%rdx)            # Przenieś 'key' na miejsce (j+1)
        movl    -8(%rbp), %eax          # Załaduj wartość 'j'
        cltq                            # Przekonwertuj 'eax' na 'rax'
        addq    $1, %rax                # Zwiększ 'rax' o 1
        leaq    0(,%rax,8), %rdx        # Oblicz offset dla elementu tablicy (j+1 * 8)
        movq    -24(%rbp), %rax         # Załaduj wskaźnik do tablicy
        addq    %rax, %rdx              # Dodaj offset do wskaźnika tablicy
        movl    -12(%rbp), %eax         # Załaduj wartość 'next_key'
        movl    %eax, 4(%rdx)           # Przenieś 'next_key' na miejsce (j+1)
        addl    $1, -4(%rbp)            # Zwiększ 'i' o 1

insertion_sort_outer_loop_check:
        movl    -4(%rbp), %eax          # Załaduj wartość 'i'
        cmpl    -28(%rbp), %eax         # Porównaj 'i' z rozmiarem tablicy
        jl      insertion_sort_outer_loop  # Jeśli 'i' jest mniejsze, skocz do 'insertion_sort_outer_loop'
        popq    %rbp                    # Przywróć wskaźnik stosu
        ret                             # Zakończ funkcję

neh_algorithm:
        pushq   %rbp                    # Zachowaj wskaźnik stosu
        movq    %rsp, %rbp              # Ustaw nowy wskaźnik stosu
        subq    $1680, %rsp             # Zarezerwuj miejsce na stosie
        movq    %rdi, -1656(%rbp)       # Przechowaj pierwszy argument (tablica czasów) na stosie
        movl    %esi, -1660(%rbp)       # Przechowaj drugi argument (liczba zadań) na stosie
        movl    %edx, -1664(%rbp)       # Przechowaj trzeci argument (liczba maszyn) na stosie
        movq    %rcx, -1672(%rbp)       # Przechowaj czwarty argument (tablica na wynik) na stosie
        movl    $0, -4(%rbp)            # Inicjalizuj licznik pętli zewnętrznej (i = 0)
        jmp     neh_algorithm_outer_loop_check  # Skocz do sprawdzenia warunku pętli zewnętrznej

neh_algorithm_outer_loop:
        movl    -4(%rbp), %eax          # Załaduj wartość licznika pętli i
        cltq                            # Rozszerz eax do rax
        movl    -4(%rbp), %edx          # Załaduj wartość i
        movl    %edx, -848(%rbp,%rax,8) # Przechowaj wartość i w odpowiednim miejscu tablicy
        movl    -4(%rbp), %eax          # Załaduj wartość i
        cltq                            # Rozszerz eax do rax
        movl    $0, -844(%rbp,%rax,8)   # Zainicjalizuj element tablicy na 0
        movl    $0, -8(%rbp)            # Zainicjalizuj licznik pętli wewnętrznej (j = 0)
        jmp     neh_algorithm_inner_loop_check  # Skocz do sprawdzenia warunku pętli wewnętrznej

neh_algorithm_inner_loop:
        movl    -4(%rbp), %eax          # Załaduj wartość i
        cltq                            # Rozszerz eax do rax
        movl    -844(%rbp,%rax,8), %ecx # Załaduj wartość z tablicy (sumę czasów) do ecx
        movl    -4(%rbp), %eax          # Załaduj wartość i
        movslq  %eax, %rdx              # Rozszerz eax do rdx
        movq    %rdx, %rax              # Skopiuj rdx do rax
        salq    $2, %rax                # Przesuń w lewo (pomnóż przez 4)
        addq    %rdx, %rax              # Dodaj rdx do rax (pomnóż przez 5)
        leaq    0(,%rax,4), %rdx        # Przesuń w lewo (pomnóż przez 4) i dodaj do rdx
        addq    %rdx, %rax              # Dodaj rdx do rax (pomnóż przez 9)
        salq    $4, %rax                # Przesuń w lewo (pomnóż przez 16)
        movq    %rax, %rdx              # Skopiuj rax do rdx
        movq    -1656(%rbp), %rax       # Załaduj wskaźnik tablicy czasów
        addq    %rax, %rdx              # Dodaj wskaźnik tablicy do rdx
        movl    -8(%rbp), %eax          # Załaduj wartość j
        cltq                            # Rozszerz eax do rax
        movl    (%rdx,%rax,4), %eax     # Załaduj wartość czasu z tablicy
        leal    (%rcx,%rax), %edx       # Dodaj wartość czasu do sumy
        movl    -4(%rbp), %eax          # Załaduj wartość i
        cltq                            # Rozszerz eax do rax
        movl    %edx, -844(%rbp,%rax,8) # Przechowaj nową sumę w tablicy
        addl    $1, -8(%rbp)            # Zwiększ licznik j o 1

neh_algorithm_inner_loop_check:
        movl    -8(%rbp), %eax          # Załaduj wartość j
        cmpl    -1664(%rbp), %eax       # Porównaj j z liczbą maszyn
        jl      neh_algorithm_inner_loop # Jeśli j < liczba maszyn, powtórz pętlę wewnętrzną
        addl    $1, -4(%rbp)            # Zwiększ licznik i o 1

neh_algorithm_outer_loop_check:
        movl    -4(%rbp), %eax          # Załaduj wartość i
        cmpl    -1660(%rbp), %eax       # Porównaj i z liczbą zadań
        jl      neh_algorithm_outer_loop # Jeśli i < liczba zadań, powtórz pętlę zewnętrzną
        movl    -1660(%rbp), %edx       # Załaduj liczbę zadań do edx
        leaq    -848(%rbp), %rax        # Załaduj adres tablicy sum czasów do rax
        movl    %edx, %esi              # Przenieś liczbę zadań do esi
        movq    %rax, %rdi              # Przenieś adres tablicy sum do rdi
        call    insertion_sort          # Wywołaj funkcję sortowania przez wstawianie
        movl    $0, -12(%rbp)           # Inicjalizuj zmienną m na 0
        movl    $0, -16(%rbp)           # Inicjalizuj zmienną l na 0
        jmp     neh_algorithm_second_outer_looop_check # Skocz do sprawdzenia warunku drugiej pętli zewnętrznej

neh_algorithm_second_outer_loop:
        movl    $2147483647, -20(%rbp)  # Inicjalizuj wartość min_makespan na największą możliwą wartość
        movl    $0, -24(%rbp)           # Inicjalizuj zmienną min_index na 0
        movl    $0, -28(%rbp)           # Inicjalizuj zmienną k na 0
        jmp     neh_algorithm_temp_order_second_loop_check # Skocz do sprawdzenia warunku drugiej pętli wewnętrznej

neh_algorithm_m_0:
        movl    $0, -32(%rbp)           # Inicjalizuj licznik pętli dla porządkowania tymczasowego (m = 0)
        jmp     neh_algorithm_temp_order_loop_check # Skocz do sprawdzenia warunku pętli porządkowania tymczasowego

neh_algorithm_temp_order:
        movl    -32(%rbp), %eax         # Załaduj wartość m
        cltq                            # Rozszerz eax do rax
        movl    -1248(%rbp,%rax,4), %edx# Załaduj wartość z tablicy optymalnego porządku do edx
        movl    -32(%rbp), %eax         # Załaduj wartość m
        cltq                            # Rozszerz eax do rax
        movl    %edx, -1648(%rbp,%rax,4)# Skopiuj wartość do tymczasowej tablicy porządku
        addl    $1, -32(%rbp)           # Zwiększ m o 1

neh_algorithm_temp_order_loop_check:
        movl    -32(%rbp), %eax        # Wczytuje wartość licznika pętli
        cmpl    -12(%rbp), %eax        # Porównuje z liczbą zadań
        jl      neh_algorithm_temp_order  # Jeśli mniejsze, skacze do początku pętli
        movl    -12(%rbp), %eax        # Wczytuje liczbę zadań do temp_order
        movl    %eax, -36(%rbp)        # Zapisuje liczbę zadań jako temp_order
        jmp     neh_algorithm_makespan  # Skok do funkcji wyliczającej makespan

neh_algorithm_temp_order_second_loop:
        movl    -36(%rbp), %eax        # Wczytuje wartość temp_order
        subl    $1, %eax               # Dekrementuje temp_order
        cltq                            # Rozszerza eax do rax
        movl    -1648(%rbp,%rax,4), %edx  # Wczytuje wartość z tablicy do edx
        movl    -36(%rbp), %eax        # Wczytuje wartość temp_order
        cltq                            # Rozszerza eax do rax
        movl    %edx, -1648(%rbp,%rax,4)  # Zapisuje wartość z edx do tablicy
        subl    $1, -36(%rbp)          # Dekrementuje temp_order

neh_algorithm_makespan:
        movl    -36(%rbp), %eax        # Wczytuje temp_order (liczbę zadań w danej kolejności)
        cmpl    -28(%rbp), %eax        # Porównuje temp_order z liczbą wszystkich zadań
        jg      neh_algorithm_temp_order_second_loop  # Jeśli temp_order jest większe, przechodzi do poprzedniej pętli
        movl    -16(%rbp), %eax        # Wczytuje wartość zadań z kolejnością - aktualnie przetwarzaną
        cltq                            # Rozszerza eax do rax
        movl    -848(%rbp,%rax,8), %edx  # Wczytuje czas procesora dla aktualnego zadania
        movl    -28(%rbp), %eax        # Wczytuje wartość temp_order (liczbę wszystkich zadań)
        cltq                            # Rozszerza eax do rax
        movl    %edx, -1648(%rbp,%rax,4)  # Zapisuje czas procesora do tablicy jako makespan
        movl    -12(%rbp), %eax        # Wczytuje liczbę zadań do eax
       leal    1(%rax), %edi          # Inkrementuje liczbę zadań o 1
        movl    -1664(%rbp), %edx      # Wczytuje adres tablicy zadań
        leaq    -1648(%rbp), %rsi      # Wczytuje adres tablicy makespan
        movq    -1656(%rbp), %rax      # Wczytuje adres obliczenia makespana
        movl    %edx, %ecx             # Kopiuje adres tablicy zadań do ecx
        movl    %edi, %edx             # Kopiuje inkrementowaną liczbę zadań do edx
        movq    %rax, %rdi             # Kopiuje adres obliczenia makespana do rdi
        call    calculate_makespan     # Wywołuje funkcję obliczającą makespan
        movl    %eax, -48(%rbp)        # Zapisuje makespan do zmiennej lokalnej
        movl    -48(%rbp), %eax        # Wczytuje makespan do eax
        cmpl    -20(%rbp), %eax        # Porównuje makespan z dotychczasowym najlepszym makespanem
        jge     increment               # Jeśli nowy makespan jest większy lub równy, skacze do inkrementacji
        movl    -48(%rbp), %eax        # Wczytuje makespan do eax
        movl    %eax, -20(%rbp)        # Aktualizuje dotychczasowy najlepszy makespan
        movl    -28(%rbp), %eax        # Wczytuje temp_order (liczbę zadań)
        movl    %eax, -24(%rbp)        # Aktualizuje liczbę zadań dla dotychczas najlepszej kolejności

increment:
        addl    $1, -28(%rbp)          # Inkrementuje temp_order

neh_algorithm_temp_order_second_loop_check:
        movl    -28(%rbp), %eax        # Wczytuje wartość temp_order (liczbę zadań przetworzonych)
        cmpl    -12(%rbp), %eax        # Porównuje temp_order z liczbą wszystkich zadań
        jle     neh_algorithm_m_0      # Jeśli temp_order jest mniejsze lub równe, skacze do początku algorytmu
        movl    -12(%rbp), %eax        # Wczytuje liczbę wszystkich zadań
        movl    %eax, -40(%rbp)        # Zapisuje liczbę wszystkich zadań do zmiennej lokalnej
        jmp     set_on_best_position   # Przechodzi do ustawienia najlepszej kolejności zadań

set_job_order_loop:
        movl    -40(%rbp), %eax        # Wczytuje liczbę wszystkich zadań
        subl    $1, %eax               # Dekrementuje liczbę zadań
        cltq                            # Rozszerza eax do rax
        movl    -1248(%rbp,%rax,4), %edx  # Wczytuje czas procesora dla danego zadania
        movl    -40(%rbp), %eax        # Wczytuje liczbę wszystkich zadań
        cltq                            # Rozszerza eax do rax
        movl    %edx, -1248(%rbp,%rax,4)  # Aktualizuje czas procesora dla danego zadania w tablicy
        subl    $1, -40(%rbp)          # Dekrementuje liczbę wszystkich zadań

set_on_best_position:
        movl    -40(%rbp), %eax        # Wczytuje liczbę wszystkich zadań
        cmpl    -24(%rbp), %eax        # Porównuje liczbę wszystkich zadań z dotychczasową najlepszą kolejnością zadań
        jg      set_job_order_loop     # Jeśli jest większa, przechodzi do aktualizacji kolejności
        movl    -16(%rbp), %eax        # Wczytuje wartość dotychczas najlepszej kolejności
        cltq                            # Rozszerza eax do rax
        movl    -848(%rbp,%rax,8), %edx  # Wczytuje czas procesora dla danego zadania
        movl    -24(%rbp), %eax        # Wczytuje liczbę wszystkich zadań
        cltq                            # Rozszerza eax do rax
        movl    %edx, -1248(%rbp,%rax,4)  # Aktualizuje czas procesora dla danego zadania w tablicy
        addl    $1, -12(%rbp)          # Inkrementuje liczbę zadań przetworzonych
        addl    $1, -16(%rbp)          # Inkrementuje wartość dotychczas najlepszej kolejności

neh_algorithm_second_outer_looop_check:
        movl    -16(%rbp), %eax        # Wczytuje liczbę iteracji
        cmpl    -1660(%rbp), %eax      # Porównuje liczbę iteracji z maksymalną wartością
        jl      neh_algorithm_second_outer_loop  # Jeśli jest mniejsza, kontynuuje pętlę
        movl    $0, -44(%rbp)          # Inicjalizuje zmienną lokalną na 0
        jmp     copy_optimal_order_loop_check   # Przechodzi do sprawdzenia warunku zakończenia pętli kopiowania

copy_optimal_order_loop:
        movl    -44(%rbp), %eax        # Wczytuje wartość zmiennej lokalnej (indeks)
        cltq                            # Rozszerza eax do rax
        leaq    0(,%rax,4), %rdx       # Oblicza adres docelowy do skopiowania
        movq    -1672(%rbp), %rax      # Wczytuje bazę danych z optymalną kolejnością zadań
        addq    %rax, %rdx             # Dodaje bazę danych do indeksu, aby uzyskać prawidłowy adres
        movl    -44(%rbp), %eax        # Wczytuje wartość zmiennej lokalnej (indeks)
        cltq                            # Rozszerza eax do rax
        movl    -1248(%rbp,%rax,4), %eax  # Wczytuje zadanie optymalnej kolejności z tablicy zadań
        movl    %eax, (%rdx)           # Kopiuje zadanie do miejsca w pamięci
        addl    $1, -44(%rbp)          # Inkrementuje indeks

copy_optimal_order_loop_check:
        movl    -44(%rbp), %eax        # Wczytuje wartość zmiennej lokalnej (indeks)
        cmpl    -1660(%rbp), %eax      # Porównuje indeks z maksymalną wartością
        jl      copy_optimal_order_loop   # Jeśli jest mniejszy, kontynuuje pętlę kopiowania
        leave                           # Czyści stos
        ret                             # Zakończenie funkcji


