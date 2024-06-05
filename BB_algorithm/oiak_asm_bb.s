	.file	"oiak_c_bb.c"
	.text
	.globl	calculateMakespan
	.type	calculateMakespan, @function
calculateMakespan:
.LFB6:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$88, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -56(%rbp)
	movl	%esi, -60(%rbp)
	movq	%rdx, -72(%rbp)
	movl	%ecx, -64(%rbp)
	movl	%r8d, -76(%rbp)
	movq	%r9, -88(%rbp)
	movl	-64(%rbp), %eax
	cltq
	salq	$3, %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, -24(%rbp)
	movl	$0, -48(%rbp)
	jmp	.L2
.L3:
	movl	-76(%rbp), %eax
	cltq
	salq	$2, %rax
	movl	-48(%rbp), %edx
	movslq	%edx, %rdx
	leaq	0(,%rdx,8), %rcx
	movq	-24(%rbp), %rdx
	leaq	(%rcx,%rdx), %rbx
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, (%rbx)
	addl	$1, -48(%rbp)
.L2:
	movl	-48(%rbp), %eax
	cmpl	-64(%rbp), %eax
	jl	.L3
	movl	$0, -44(%rbp)
	jmp	.L4
.L11:
	movl	$0, -40(%rbp)
	jmp	.L5
.L10:
	cmpl	$0, -40(%rbp)
	je	.L6
	movl	-44(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rdx
	movl	-40(%rbp), %eax
	cltq
	salq	$2, %rax
	subq	$4, %rax
	addq	%rdx, %rax
	movl	(%rax), %eax
	jmp	.L7
.L6:
	movl	$0, %eax
.L7:
	movl	%eax, -32(%rbp)
	cmpl	$0, -44(%rbp)
	je	.L8
	movl	-44(%rbp), %eax
	cltq
	salq	$3, %rax
	leaq	-8(%rax), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rdx
	movl	-40(%rbp), %eax
	cltq
	salq	$2, %rax
	addq	%rdx, %rax
	movl	(%rax), %eax
	jmp	.L9
.L8:
	movl	$0, %eax
.L9:
	movl	%eax, -28(%rbp)
	movl	-28(%rbp), %edx
	movl	-32(%rbp), %eax
	cmpl	%eax, %edx
	cmovge	%edx, %eax
	movl	%eax, %ecx
	movl	-44(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-56(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-72(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rdx
	movl	-40(%rbp), %eax
	cltq
	salq	$2, %rax
	addq	%rdx, %rax
	movl	(%rax), %edx
	movl	-44(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rsi
	movq	-24(%rbp), %rax
	addq	%rsi, %rax
	movq	(%rax), %rsi
	movl	-40(%rbp), %eax
	cltq
	salq	$2, %rax
	addq	%rsi, %rax
	addl	%ecx, %edx
	movl	%edx, (%rax)
	addl	$1, -40(%rbp)
.L5:
	movl	-40(%rbp), %eax
	cmpl	-76(%rbp), %eax
	jl	.L10
	addl	$1, -44(%rbp)
.L4:
	movl	-44(%rbp), %eax
	cmpl	-64(%rbp), %eax
	jl	.L11
	movl	-64(%rbp), %eax
	cltq
	salq	$3, %rax
	leaq	-8(%rax), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rdx
	movl	-76(%rbp), %eax
	cltq
	salq	$2, %rax
	subq	$4, %rax
	addq	%rdx, %rax
	movl	(%rax), %edx
	movq	-88(%rbp), %rax
	movl	%edx, (%rax)
	movl	$0, -36(%rbp)
	jmp	.L12
.L13:
	movl	-36(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	free@PLT
	addl	$1, -36(%rbp)
.L12:
	movl	-36(%rbp), %eax
	cmpl	-64(%rbp), %eax
	jl	.L13
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	nop
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	calculateMakespan, .-calculateMakespan
	.globl	lowerBound
	.type	lowerBound, @function
lowerBound:
.LFB7:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movq	%rdi, -40(%rbp)
	movl	%esi, -44(%rbp)
	movq	%rdx, -56(%rbp)
	movl	%ecx, -48(%rbp)
	movl	%r8d, -60(%rbp)
	movl	-48(%rbp), %eax
	cltq
	movl	$4, %esi
	movq	%rax, %rdi
	call	calloc@PLT
	movq	%rax, -8(%rbp)
	movl	$0, -28(%rbp)
	jmp	.L15
.L16:
	movl	-28(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-8(%rbp), %rax
	addq	%rdx, %rax
	movl	$1, (%rax)
	addl	$1, -28(%rbp)
.L15:
	movl	-28(%rbp), %eax
	cmpl	-44(%rbp), %eax
	jl	.L16
	movl	$0, -24(%rbp)
	movl	$0, -20(%rbp)
	jmp	.L17
.L22:
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-8(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %eax
	testl	%eax, %eax
	jne	.L18
	movl	$2147483647, -16(%rbp)
	movl	$0, -12(%rbp)
	jmp	.L19
.L21:
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-56(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rdx
	movl	-12(%rbp), %eax
	cltq
	salq	$2, %rax
	addq	%rdx, %rax
	movl	(%rax), %eax
	cmpl	%eax, -16(%rbp)
	jle	.L20
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-56(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rdx
	movl	-12(%rbp), %eax
	cltq
	salq	$2, %rax
	addq	%rdx, %rax
	movl	(%rax), %eax
	movl	%eax, -16(%rbp)
.L20:
	addl	$1, -12(%rbp)
.L19:
	movl	-12(%rbp), %eax
	cmpl	-60(%rbp), %eax
	jl	.L21
	movl	-16(%rbp), %eax
	addl	%eax, -24(%rbp)
.L18:
	addl	$1, -20(%rbp)
.L17:
	movl	-20(%rbp), %eax
	cmpl	-48(%rbp), %eax
	jl	.L22
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movl	-24(%rbp), %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	lowerBound, .-lowerBound
	.globl	branchAndBound
	.type	branchAndBound, @function
branchAndBound:
.LFB8:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$96, %rsp
	movq	%rdi, -40(%rbp)
	movl	%esi, -44(%rbp)
	movq	%rdx, -56(%rbp)
	movl	%ecx, -48(%rbp)
	movl	%r8d, -60(%rbp)
	movq	%r9, -72(%rbp)
	movq	16(%rbp), %rax
	movq	%rax, -80(%rbp)
	movq	24(%rbp), %rax
	movq	%rax, -88(%rbp)
	movq	32(%rbp), %rax
	movq	%rax, -96(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	40(%rbp), %eax
	cmpl	-48(%rbp), %eax
	jne	.L25
	leaq	-32(%rbp), %r8
	movl	-60(%rbp), %edi
	movl	-48(%rbp), %ecx
	movq	-56(%rbp), %rdx
	movl	40(%rbp), %esi
	movq	-96(%rbp), %rax
	movq	%r8, %r9
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	calculateMakespan
	movq	-72(%rbp), %rax
	movl	(%rax), %edx
	movl	-32(%rbp), %eax
	cmpl	%eax, %edx
	jle	.L39
	movl	-32(%rbp), %edx
	movq	-72(%rbp), %rax
	movl	%edx, (%rax)
	movq	-88(%rbp), %rax
	movl	40(%rbp), %edx
	movl	%edx, (%rax)
	movl	$0, -28(%rbp)
	jmp	.L27
.L28:
	movl	-28(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-96(%rbp), %rax
	addq	%rdx, %rax
	movl	-28(%rbp), %edx
	movslq	%edx, %rdx
	leaq	0(,%rdx,4), %rcx
	movq	-80(%rbp), %rdx
	addq	%rcx, %rdx
	movl	(%rax), %eax
	movl	%eax, (%rdx)
	addl	$1, -28(%rbp)
.L27:
	movl	-28(%rbp), %eax
	cmpl	40(%rbp), %eax
	jl	.L28
	jmp	.L39
.L25:
	movl	$0, -24(%rbp)
	jmp	.L30
.L37:
	movl	$0, -20(%rbp)
	movl	$0, -16(%rbp)
	jmp	.L31
.L34:
	movl	-16(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-96(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %eax
	cmpl	%eax, -24(%rbp)
	jne	.L32
	movl	$1, -20(%rbp)
	jmp	.L33
.L32:
	addl	$1, -16(%rbp)
.L31:
	movl	-16(%rbp), %eax
	cmpl	40(%rbp), %eax
	jl	.L34
.L33:
	cmpl	$0, -20(%rbp)
	jne	.L35
	movl	40(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-96(%rbp), %rax
	addq	%rax, %rdx
	movl	-24(%rbp), %eax
	movl	%eax, (%rdx)
	movl	40(%rbp), %eax
	leal	1(%rax), %esi
	leaq	-32(%rbp), %r8
	movl	-60(%rbp), %edi
	movl	-48(%rbp), %ecx
	movq	-56(%rbp), %rdx
	movq	-96(%rbp), %rax
	movq	%r8, %r9
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	calculateMakespan
	movl	40(%rbp), %eax
	leal	1(%rax), %esi
	movl	-60(%rbp), %edi
	movl	-48(%rbp), %ecx
	movq	-56(%rbp), %rdx
	movq	-96(%rbp), %rax
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	lowerBound
	movl	-32(%rbp), %edx
	addl	%edx, %eax
	movl	%eax, -12(%rbp)
	movq	-72(%rbp), %rax
	movl	(%rax), %eax
	cmpl	%eax, -12(%rbp)
	jge	.L35
	movl	40(%rbp), %eax
	leal	1(%rax), %edi
	movq	-72(%rbp), %r9
	movl	-60(%rbp), %r8d
	movl	-48(%rbp), %ecx
	movq	-56(%rbp), %rdx
	movl	-44(%rbp), %esi
	movq	-40(%rbp), %rax
	pushq	%rdi
	pushq	-96(%rbp)
	pushq	-88(%rbp)
	pushq	-80(%rbp)
	movq	%rax, %rdi
	call	branchAndBound
	addq	$32, %rsp
.L35:
	addl	$1, -24(%rbp)
.L30:
	movl	-24(%rbp), %eax
	cmpl	-48(%rbp), %eax
	jl	.L37
.L39:
	nop
	movq	-8(%rbp), %rax
	subq	%fs:40, %rax
	je	.L38
	call	__stack_chk_fail@PLT
.L38:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	branchAndBound, .-branchAndBound
	.section	.rodata
.LC0:
	.string	"Best permutation: "
.LC1:
	.string	"%d "
.LC2:
	.string	"\nBest makespan: %d\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB9:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$144, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$2, -48(%rbp)
	movl	$3, -44(%rbp)
	movl	$2, -40(%rbp)
	movl	$4, -36(%rbp)
	movl	$10, -32(%rbp)
	movl	$3, -28(%rbp)
	movl	$3, -24(%rbp)
	movl	$2, -20(%rbp)
	movl	$4, -16(%rbp)
	movl	$0, -132(%rbp)
	jmp	.L41
.L42:
	leaq	-48(%rbp), %rcx
	movl	-132(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	salq	$2, %rax
	leaq	(%rcx,%rax), %rdx
	movl	-132(%rbp), %eax
	cltq
	movq	%rdx, -80(%rbp,%rax,8)
	addl	$1, -132(%rbp)
.L41:
	cmpl	$2, -132(%rbp)
	jle	.L42
	movl	$3, -124(%rbp)
	movl	$3, -120(%rbp)
	movl	$2147483647, -140(%rbp)
	movl	$0, -136(%rbp)
	leaq	-140(%rbp), %r8
	movl	-120(%rbp), %edi
	movl	-124(%rbp), %ecx
	leaq	-80(%rbp), %rdx
	leaq	-104(%rbp), %rax
	pushq	$0
	leaq	-92(%rbp), %rsi
	pushq	%rsi
	leaq	-136(%rbp), %rsi
	pushq	%rsi
	leaq	-116(%rbp), %rsi
	pushq	%rsi
	movq	%r8, %r9
	movl	%edi, %r8d
	movl	$0, %esi
	movq	%rax, %rdi
	call	branchAndBound
	addq	$32, %rsp
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, -128(%rbp)
	jmp	.L43
.L44:
	movl	-128(%rbp), %eax
	cltq
	movl	-116(%rbp,%rax,4), %eax
	movl	%eax, %esi
	leaq	.LC1(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	addl	$1, -128(%rbp)
.L43:
	movl	-136(%rbp), %eax
	cmpl	%eax, -128(%rbp)
	jl	.L44
	movl	-140(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC2(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, %eax
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L46
	call	__stack_chk_fail@PLT
.L46:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
