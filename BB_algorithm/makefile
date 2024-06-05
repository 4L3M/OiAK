all: oiak_asm_bb 

oiak_bb: oiak_asm_bb.o
	ld oiak_asm_bb.o -o oiak_asm_bb

oiak_bb.o: oiak_asm_bb.s
	as -oiak_asm_bb.s -o oiak_asm_bb.o
