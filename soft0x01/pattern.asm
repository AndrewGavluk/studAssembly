;programm to check string by pattern with * and ?
; 

global _start

section .text

;[ebp+8]  is p to str
;[ebp+12] is p to patt

match:				;  subroutine START
	
	push ebp		;  save base pointer(p) to stack
	mov ebp, esp		;  move stack p to base p
	sub esp, 4		;  save the local "counter" variable "I" at [esp-4]
	push esi		;  save esi edi to stack
	push edi
	mov esi, [ebp+8]	; save argv[1] (string) to esi
	mov edi, [ebp+12]	; save argv[2] (pattern) to edi
	
.again				; loop pointer
	cmp byte [edi], 0	; have reached the end of pattern?
	jne .not_end		;
				; cycle end procesing
	cmp byte [esi], 0	; have reached the  end of string
	jne near .false		; 
	jmp .true		;

.not_end:
	cmp byte [edi], '*'	; compare character with '*'
	jne .not_star		; if not '*' go to .not_star
	mov dword [ebp-4], 0	; set cycle counter to 0
				; if '*' start recursive cycle 
.start_loop:
				; preparing the new arguments to recursive call	 
				; it need to check when "*" - any-number is end
				; then check eql of [edi+1] and [esi+i] in recursive
				;  

				; edi - is argv[2] or pattern
	mov eax, edi		; save it to accumulator (acc)
	inc eax				; increment acc to send it to recursive
	push eax			; push it to stack

				; esi - is argv[1] or string
	mov eax, esi 		; save it to acc
	add eax, [ebp-4]	; add "counter" to esi [esi+i]
	push eax			; push it to stack

	call match			; recursive call
	add esp, 8			; remove params from stack
	test eax, eax		; if zero in eax comparassion
	
	jnz .true			; if not zero go to .true
	add eax [ebp-4]		; else add "I" to eax 
	cmp byte [esi+eax], 0; if zero (EOL) in [esi+eax](string) comparassion
	je. false			; if zero go to end
	inc dword [ebp-4]	; else increment "I"
	jmp .start_loop		;

.not_star:
	mov al, [edi]		;
	cmp al, '?'
	je .quest
	cmp al [esi]
	jne .false
	jmp .goon



