.section .data
    msg: .string "Wynik: %d\n"  # Wiadomość formatująca
    array:
        .int 0,1,2,3,4,5,6,7,8,9,10,11,122,13,14,15,16,17,18,19,20,21,22,23,24
        
    completionTimes:
    	.int 0,0,0,0,0,0,0,0,0
    perm:
    	.int 2,1,0
    processingTimes:
    	.int 2,3,2,4,1,3,3,2,4

.section .bss
    .lcomm result, 4          # Miejsce na wynik
    .lcomm x, 4          
    .lcomm y, 4          

.section .text
    .globl _start

_start:
	movl $0, %esi
	
_i:
	movl $0, %edi
_j:
	# i to esi, j to edi
	#ecx to timeJobStarts
	#edx to timeMachineIsFree
	#eax, ebx zostało
	
	cmpl $0, %edi
	jne else_1
		movl $0, %ecx
		jmp if_1
	else_1:
		movl %esi, %eax 
    		movl %edi, %ebx 
		subl $1, %ebx    
    		movl $3, %ecx 
    		mul %ecx
    		addl %ebx, %eax 
    		movl completionTimes(, %eax, 4), %ecx  
    	if_1:
    		
    	cmpl $0, %esi
    	jne else_2
    		movl $0, %edx
    		jmp if_2
    	else_2:
    		movl %esi, %eax  
		subl $1, %eax
		movl %edi, %ebx   
		movl $3, %edx 
    		mul %edx
    		addl %ebx, %eax 
    		movl completionTimes(, %eax, 4), %edx   
    	if_2:
    	_b:	
	cmpl %ecx, %edx
	jge else_3
	
    	
    	#edx wolny
	    	movl perm(, %esi, 4), %eax # perm[i]
	    	movl %eax, %eax 
	    	movl %edi, %ebx 
	    	movl $3, %edx 
	    	mul %edx
	    	addl %ebx, %eax 
	    	movl processingTimes(, %eax, 4), %edx 
	    	addl %ecx, %edx
	    	
	    	movl %edx, %ecx
	    	movl %esi, %eax 
	    	movl %edi, %ebx 
	    	movl $3, %edx
	    	mul %edx
	    	addl %ebx, %eax 
	    	movl %ecx, completionTimes(, %eax, 4)
	    	jmp if_3
	    	
    	
    	else_3:
    	#ecx wolny
    		movl %edx, %ecx
    		movl perm(, %esi, 4), %eax # perm[i]
	    	movl %eax, %eax 
	    	movl %edi, %ebx 
	    	movl $3, %edx 
	    	mul %edx
	    	addl %ebx, %eax 
	    	movl processingTimes(, %eax, 4), %edx 
	    	addl %ecx, %edx
	    	
	    	
	    	movl %edx, %ecx
	    	movl %esi, %eax 
	    	movl %edi, %ebx 
	    	movl $3, %edx
	    	mul %edx
	    	addl %ebx, %eax 
	    	movl %ecx, completionTimes(, %eax, 4)
	if_3:
    		
    	

    	


	step:
	incl %edi
	cmpl $3, %edi
    	jl _j 
    	
    	incl %esi
    	cmpl $3, %esi
    	jl _i
    	
    	
    	
    	
    movl $0, %eax
    movl completionTimes(, %eax, 4), %ecx
    movl %ecx, result
    #printowanie
    movl $msg, %edi
    movl result, %esi
    movl $0, %eax 
    call printf
    
    movl $1, %eax
    movl completionTimes(, %eax, 4), %ecx
    movl %ecx, result
    #printowanie
    movl $msg, %edi
    movl result, %esi
    movl $0, %eax 
    call printf
    
    movl $2, %eax
    movl completionTimes(, %eax, 4), %ecx
    movl %ecx, result
    #printowanie
    movl $msg, %edi
    movl result, %esi
    movl $0, %eax 
    call printf
    
    movl $3, %eax
    movl completionTimes(, %eax, 4), %ecx
    movl %ecx, result
    #printowanie
    movl $msg, %edi
    movl result, %esi
    movl $0, %eax 
    call printf
    
    movl $4, %eax
    movl completionTimes(, %eax, 4), %ecx
    movl %ecx, result
    #printowanie
    movl $msg, %edi
    movl result, %esi
    movl $0, %eax 
    call printf
    
    movl $5, %eax
    movl completionTimes(, %eax, 4), %ecx
    movl %ecx, result
    #printowanie
    movl $msg, %edi
    movl result, %esi
    movl $0, %eax 
    call printf
    
    movl $6, %eax
    movl completionTimes(, %eax, 4), %ecx
    movl %ecx, result
    #printowanie
    movl $msg, %edi
    movl result, %esi
    movl $0, %eax 
    call printf
    
    movl $7, %eax
    movl completionTimes(, %eax, 4), %ecx
    movl %ecx, result
    #printowanie
    movl $msg, %edi
    movl result, %esi
    movl $0, %eax 
    call printf
    
    movl $8, %eax
    movl completionTimes(, %eax, 4), %ecx
    movl %ecx, result
    #printowanie
    movl $msg, %edi
    movl result, %esi
    movl $0, %eax 
    call printf
    	
    
    
    
         

    # Wyjście z programu
    movl $60, %eax            # syscall: exit
    xorl %edi, %edi           # kod wyjścia
    syscall

#Tak to sie kompiluje
#gcc -nostartfiles -no-pie -o program program.s -lc
#Tak sie wywoluje (normalnie)
#./program
