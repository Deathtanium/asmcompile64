WRITE_CALL	equ 4		
EXIT_CALL	equ 1
STDOUT 		equ 1

section .data
	x		equ 12345		;AICI este numarul de afisat
	ncif	resd 16
	num 	resq 256
section .text
	mov eax,x 		;numarul cu care lucram
	
	mov edi,0		;edi ne va numara cifrele
	
	_div10:
	mov edx,0		;curatam restul
	mov ecx,10		;setam divizorul
	div ecx			;facem impartirea. In eax ramane vechiul_eax/10
	
	inc	edi			;incrementam pentru fiecare cifra
	cmp eax,0		;repetam pana cand eax==0
	jne _div10
	
	mov [ncif],edi
	
	mov esi,[ncif]	;pregatim un "for"
	dec esi			;de la ncif-1 la 0.
	mov eax,x		;refacem numarul
	_loop1:
	mov edx,0				;la fiecare pas trebuie sa 		
	mov ecx,10				;avem in edx cifra de prelucrat
	div ecx					;a.i. repetam ca la numararea cifrelor
	
	add edx,48 				;transformam cifra in char
	mov [num+4*esi],edx		;daca num e pozitia 0 atunci punem cifra pe pozitia 
							;esi (x4 pentru ca fiecare cifra (caracter) are nevoie de 4 biti
							;esi mergand de la ncif-1 la 0
							
	dec esi					;bucla cat timp esi>=0
	cmp esi,0
	jge _loop1
	
	
	mov eax,[ncif]		;========
	inc eax				;aici facem pe eax in 
	mov ebx,4			;(ncif+1)*4
	mul ebx				;========
	mov edi,eax			;aici adaugam un
	mov eax,10
	mov [num+edi],eax	;stringului
	
	inc edi
	mov eax,WRITE_CALL
	mov ebx,STDOUT		
	mov ecx,num
	mov edx,40
	int 0x80
	
	mov eax,EXIT_CALL
	int 0x80