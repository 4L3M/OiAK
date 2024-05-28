.section .data
jobs:					# Czas przetwarzania dla kolejnych zadań na kolejnych maszynach 
    .int 3, 2
    .int 2, 1
    .int 4, 3
numJobs: .int 3				# Liczba zadań
numMachines: .int 2			# Liczba maszyn

bestSequence: .space 12			# Najlepsza sekwencja	 
bestCost: .int 2147483647		# Początkowy najlepszy koszt ustawiony na maksymalną wartość integera

.section .bss
.lcomm stack, 480  # 10 states * 48 bytes each		# Stos dla stanów
.lcomm sp, 4						# Wskaźnik stosu
.lcomm machineEndTime, 40				# Czas zakończenia na maszynie
.lcomm jobEndTime, 40					# Czas zakończenia dla zadania
.lcomm sequence, 40					# Bieżąca sekwencja zadań

.section .text
.global _start

_start:
   
    movl $2147483647, bestCost				# Ustawienie początkowego najlepszego kosztu
    movl $stack, %ebx 					# Inicjalizacja wskaźnika stosu
    movl $0, sp						# Inicjalizacja wskaźnika stosu

    call pushInitialState				# Umieszczenie początkowego stanu na stosie

dfs_loop:
    cmpl $0, sp  					# Sprawdzenie, czy stos jest pusty
    je done						# Jeżeli stos jest pusty to zakończ program

   
    call popState					# Pobranie stanu ze stosu

    
    movl 0(%esp), %ecx					# Pobranie długości sekwencji
    cmpl numJobs, %ecx					# Sprawdzenie czy osiągnieto pełną sekwencję
    je update_best_sequence				# Jeżeli tak, to zaktualizuj najlepszą sekwencję

    call generateNextStates				# Generowanie kolejnych stanów i umieszczenie ich na stosie
    jmp dfs_loop					# Kontynuuj pętle

update_best_sequence:					# Aktualizacja najlepszej sekwencji
   
    movl 4(%esp), %eax					# Pobranie bound (dolnej granicy)			
    cmpl bestCost, %eax 				# Porównanie bound z najlepszym kosztem
    jge continue					# Jeśli bound >= bestCost, przejdź do continue

    # Zaktualizowanie najlepszego kosztu
    movl %eax, bestCost
    
    # Wskaźniki na bieżącą i najlepszą sekwencję
    movl sequence, %esi
    movl bestSequence, %edi
    
    # Przeniesienie wartości z sequence do bestSequence
    movl (%esi), %eax
    movl %eax, (%edi)
    movl 4(%esi), %eax
    movl %eax, 4(%edi)
    movl 8(%esi), %eax
    movl %eax, 8(%edi)

continue:
    # Usunięcie bieżącego stanu ze stosu
    addl $8, %esp
    jmp dfs_loop

generateNextStates:
    # Pobranie długości sekwencji
    movl 0(%esp), %ecx
    movl $0, %esi

gen_next_loop:
    # Sprawdzenie, czy osiągnięto maksymalną liczbę zadań
    cmpl numJobs, %esi
    jge gen_next_done

    movl %esi, %eax
    call isInSequence
    testl %eax, %eax
    jnz next_i

    # Dodanie nowego stanu z zadaniem %esi
    movl %ecx, %edi
    addl $1, %edi
    leal sequence(,%ecx,4), %edx
    movl %esi, (%edx)
    leal sequence, %edx
    pushl %edi
    call calculateBound
    pushl %eax
    call pushState

next_i:
    incl %esi
    jmp gen_next_loop

gen_next_done:
    ret

calculateBound:
    # Inicjalizacja machineEndTime i jobEndTime na 0
    xorl %edi, %edi
    xorl %esi, %esi

init_machineEndTime:
    movl %esi, machineEndTime(,%edi,4)
    incl %edi
    cmpl numMachines, %edi
    jl init_machineEndTime

init_jobEndTime:
    movl %esi, jobEndTime(,%edi,4)
    incl %edi
    cmpl numJobs, %edi
    jl init_jobEndTime

    movl 0(%esp), %ecx  # Pobranie długości sekwencji
    xorl %esi, %esi  # Zerowanie indeksu

calc_loop:
    # Sprawdzenie, czy osiągnięto koniec sekwencji
    cmpl %ecx, %esi
    jge calc_done

    leal sequence(,%esi,4), %edx
    movl (%edx), %ebx  # Pobranie bieżącego zadania

    xorl %edi, %edi  # Zerowanie indeksu maszyny

machine_loop:
    # Pętla obliczająca bound dla każdej maszyny
    cmpl numMachines, %edi
    jge next_job

    leal jobs(,%ebx,4), %eax
    movl (%eax,%edi,4), %eax  # Pobranie czasu przetwarzania dla bieżącej maszyny

    cmpl $0, %edi
    je first_machine

    movl machineEndTime(,%edi,4), %edx  # Pobranie czasu zakończenia dla bieżącej maszyny
    movl machineEndTime(,%edi-1,4), %ecx  # Pobranie czasu zakończenia dla poprzedniej maszyny
    cmpl %ecx, %edx  # Porównanie czasów zakończenia
    cmovl %ecx, %edx  # Ustawienie czasu zakończenia na większy z dwóch wartości
    addl %eax, %edx  # Dodanie czasu przetwarzania
    movl %edx, machineEndTime(,%edi,4)  # Zapisanie nowego czasu zakończenia
    movl %edx, jobEndTime(,%ebx,4)  # Zapisanie czasu zakończenia zadania

    jmp next_machine

first_machine:
    addl %eax, machineEndTime(,%edi,4)
    movl machineEndTime(,%edi,4), %eax
    movl %eax, jobEndTime(,%ebx,4)

next_machine:
    incl %edi
    jmp machine_loop

next_job:
    incl %esi
    jmp calc_loop

calc_done:
    xorl %eax, %eax
    xorl %edi, %edi

lower_bound_loop:
    cmpl numMachines, %edi
    jge lower_bound_done

    movl machineEndTime(,%edi,4), %edx
    cmpl %edx, %eax
    cmovl %edx, %eax

    incl %edi
    jmp lower_bound_loop

lower_bound_done:
    ret

isInSequence:
    movl 0(%esp), %ebx
    movl 0(%esp,%ebx,4), %ecx
    leal sequence, %edx
    movl %ebx, %eax

in_seq_loop:
    cmpl %eax, %ecx
    je not_in_seq

    leal sequence(,%eax,4), %edi
    movl (%edi), %edi
    cmpl %edi, %ebx
    je in_seq

    incl %eax
    jmp in_seq_loop

in_seq:
    movl $1, %eax
    ret

not_in_seq:
    xorl %eax, %eax
    ret

pushState:
    movl %ecx, (%ebx,sp,4)  # Zapisanie długości sekwencji
    movl %eax, 4(%ebx,sp,4) # Zapisanie bound
    addl $8, sp  # Inkrementacja wskaźnika stosu
    ret

popState:
    subl $8, sp  # Dekrementacja wskaźnika stosu
    movl (%ebx,sp,4), %ecx  # Pobranie długości sekwencji
    movl 4(%ebx,sp,4), %eax # Pobranie bound
    ret

pushInitialState:
    movl $0, %ecx  # Ustawienie długości sekwencji na 0
    movl $0, %eax  # Ustawienie bound na 0
    call pushState  # Dodanie początkowego stanu na stos
    ret

done:
    movl $60, %eax  # Ustawienie numeru systemowego wywołania exit
    xorl %edi, %edi  # Ustawienie kodu wyjścia na 0
    syscall  # Wywołanie systemowe exit
