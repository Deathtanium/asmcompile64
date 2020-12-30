section .data
	msg		db 'Hello world',10	;the string "Hello world\n" is written to memory 
						;and the address of its starting point (pointer to the string)
						;is saved in msg
								
	msglen	equ $-msg			;msglen is $ (current memory address of the assembler) minus the
						;address of the string. Using this method we get the string length

section .text
	mov eax,4			;syscall 4 (write) takes 3 params:
	mov ebx,1			; - output buffer descriptor (1 for stdout or console)
	mov ecx,msg			; - pointer to the beginning of what I need to print
	mov edx,msglen			; - how many bytes to read starting with whatever address is in ecx
	int 0x80			;request interrupt

	mov eax,1			;syscall 1 (exit)
	int 0x80			;request interrupt
