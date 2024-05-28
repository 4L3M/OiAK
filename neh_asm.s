.text

.globl neh_asm

# size_t neh_asm(unsigned int* data, size_t size)
neh_asm:
        # Prolog
        pushq   %rbp            #zachowaj rbp na stosie
        movq    %rsp, %rbp
        movq    %rdi, -40(%rbp)   # Przechowaj wskaźnik do tablicy (data)
        movq    %rsi, -48(%rbp)   # Przechowaj rozmiar tablicy (size)

        # Inicjalizacja zmiennej indeksu i
        movq    $1, -8(%rbp)      # i = 1
        jmp     sort_outer_loop_check #skok do sprawdzania zakończenia pętli zewnetrznej

# Outer Loop: for (i = 1; i < size; ++i)
sort_outer_loop:
        movq    -8(%rbp), %rax  #przenoszenie i do rax
        leaq    0(,%rax,8), %rdx  # rdx = i * 8 (rozmiar wiersza w bajtach)
        movq    -40(%rbp), %rax   #przenieś wskaźnik do tablicy do rax
        addq    %rdx, %rax      # Obliczanie adresu data[i][0] i zapisuje do rax
        movl    (%rax), %eax    #przenieś data[i][0] do eax
        movl    %eax, -24(%rbp)   # key[0] = arr[i][0]
        movq    -8(%rbp), %rax  #przenieś i do rax
        salq    $3, %rax          # rax = i * 8
        leaq    4(%rax), %rdx     # rdx = i * 8 + 4
        movq    -40(%rbp), %rax   #przenieś wskaźnik do tablicy do rax
        addq    %rdx, %rax   #oblicznie adresu data[i][1], zapisz do rax
        movl    (%rax), %eax  #przenieś arr[i][1] do eax
        movl    %eax, -20(%rbp)   # key[1] = arr[i][1]

        # Suma wartości wiersza
        movl    -24(%rbp), %edx  #edx = key[0]
        movl    -20(%rbp), %eax  #eax = key[1]
        addl    %edx, %eax      #suma key[0] i key[1], wynik w eax
        movl    %eax, -16(%rbp)   # sum_key = key[0] + key[1]

        # Inicjalizacja zmiennej indeksu j
        movq    -8(%rbp), %rax  #przenies i do rax
        subl    $1, %eax        #i-1 ,wynik eax
        movl    %eax, -12(%rbp)   # j = i - 1

        # Inner Loop: while (j >= 0 && (data[j][0] + data[j][1]) > sum_key)
sort_inner_loop:
        # Sprawdzenie warunku j >= 0
        cmpl    $0, -12(%rbp)   #prównaj j z 0
        js      insert_key       #skok do insert_key jesli j<0

        # Obliczenie sumy wartości w wierszu data[j]
        movl    -12(%rbp), %eax  #przenies j do eax
        addl    %eax, %eax      #j = j+j wynik w eax
        cltq                    #konwertuj eax do rax
        leaq    0(,%rax,4), %rdx #oblicz przesunięcie j*8 i zapisz do rdx
        movq    -40(%rbp), %rax   #przenieś wskaźnik do tablicy do rax
        addq    %rdx, %rax      #oblicz adres data[j] i zapisz do rax
        movl    (%rax), %edx    #załaduj data[j][0] do edx
        movl    -12(%rbp), %eax  #przenies j do eax
        addl    %eax, %eax   #j=j+j
        cltq                #konwertuj eax do rax
        addq    $1, %rax        #dodaj 1 do rax
        leaq    0(,%rax,4), %rcx   #oblicz przesunięcie j*8+4, wynik w rcx
        movq    -40(%rbp), %rax  #przenies wskaźnik tablicy do rax
        addq    %rcx, %rax      #oblicz adres data[j][1] i zapisz do rax
        movl    (%rax), %eax    #przenieś data[j][1] do eax
        addl    %edx, %eax        # sum_j = data[j][0] + data[j][1], wynik eax

        # Sprawdzenie warunku sum_j > sum_key
        movl    -16(%rbp), %edx #przenieś sum_key do edx
        cmpl    %eax, %edx      #porównaj sum_j i sum_key
        jb      move_elements     # Jeśli sum_j > sum_key,skok do move_elements

        # Przejdź do wstawiania klucza
        jmp     insert_key

move_elements:
        # Przesunięcie elementów tablicy data[j + 1][0] = data[j][0]
        movl    -12(%rbp), %eax   #przenies j do eax
        addl    %eax, %eax      #j = j+j
        cltq
        leaq    0(,%rax,4), %rdx  #oblicz przesunięcie j*8 i zapisz do rdx
        movq    -40(%rbp), %rax  #przenieś wskaźnik na tablice do rax
        addq    %rdx, %rax      #oblicz adres data[j]
        movl    (%rax), %eax    #przenieś data[j][0] do eax

        #przesunięcie elementów tablicy data[j+1[1]=data[j][1]
        movl    -12(%rbp), %edx #przenieś j do eax
        addl    $1, %edx        #dodaj 1 do edx j = j+1
        addl    %edx, %edx      #(j+1)*2
        movslq  %edx, %rdx      #konwertuj edx do rdx
        leaq    0(,%rdx,4), %rcx   #przesunięcie (j+1)*8 do rcx
        movq    -40(%rbp), %rdx  #przenieś wskaznik na tablice
        addq    %rcx, %rdx      #oblicz adres data[j+1]
        movl    %eax, (%rdx)    #przenieś wartość data[j][0] do data[j+1][0]

        # Przesunięcie elementów tablicy data[j + 1][0] = data[j][0] (kontynuacja)
        movl    -12(%rbp), %eax #j do eax
        addl    %eax, %eax      #j=j+j
        cltq
        addq    $1, %rax #dodaj 1 do rax j=j+1
        leaq    0(,%rax,4), %rdx   #załaduj przesunięcie j*8+4
        movq    -40(%rbp), %rax    #przenies wskaznik na tablice
        addq    %rdx, %rax      #oblicz adres data[j]
        movl    -12(%rbp), %edx #przenieś j do edx
        addl    $1, %edx        #dodaj 1 j+1
        addl    %edx, %edx      #(j+1)*2
        movslq  %edx, %rdx
        addq    $1, %rdx        #dodaj 1 do rdx (j+1)*2+1
        leaq    0(,%rdx,4), %rcx #przesunięcie (j+1)*8+4
        movq    -40(%rbp), %rdx
        addq    %rcx, %rdx   #Oblicz adres data[j + 1][1] i zapisz do rdx
        movl    (%rax), %eax  #przenieś data[j][1] do eax
        movl    %eax, (%rdx) #przenieś data[j][1] do data[j+1][1]

        # Zmniejszenie indeksu j
        subl    $1, -12(%rbp)  #j--
        jmp     sort_inner_loop

insert_key:
        # Wstawienie klucza na odpowiednią pozycję
        movl    -12(%rbp), %eax #przxenies j do eax
        addl    $1, %eax        #j+1
        addl    %eax, %eax      #(j+1)*2
        cltq
        leaq    0(,%rax,4), %rdx  #załaduj (j+1)*8
        movq    -40(%rbp), %rax
        addq    %rax, %rdx      #oblicz adres data[j+1]
        movl    -24(%rbp), %eax #key[0] do eax
        movl    %eax, (%rdx) #data[j+1][0] = key[0]

        # Wstawienie klucza na odpowiednią pozycję
        movl    -12(%rbp), %eax #przenieś j do eax
        addl    $1, %eax
        addl    %eax, %eax
        cltq
        addq    $1, %rax
        leaq    0(,%rax,4), %rdx #załaduj (j+1)*8+4
        movq    -40(%rbp), %rax
        addq    %rax, %rdx  #oblicz adres data[j+1]
        movl    -20(%rbp), %eax #key[1] do eax
        movl    %eax, (%rdx)  #data[j+1][1] = key[1]

        # Zwiększenie indeksu i
        addq    $1, -8(%rbp)

sort_outer_loop_check:
        # Sprawdzenie warunku zakończenia pętli zewnętrznej
        movq    -8(%rbp), %rax
        cmpq    -48(%rbp), %rax
        jb      sort_outer_loop


        # Epilog
        popq    %rbp
        ret
#kompilacja g++ main.cpp ins.s -no-pie
