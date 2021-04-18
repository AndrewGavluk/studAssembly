%include "stud_io.inc"
global _start

section .text
_start: mov eax, 0
again:  PRINT "Hello World"
        PUTCHAR 10
	PUTCHAR 13
	inc eax
	cmp eax, 7
	jl again
	FINISH
