org 0x7C00
bits 16

%define ENDL 0x0D, 0x0A

start:
	jmp main

;
;prints a string to the screen.
;params:
;	-ds:si points to the string


puts:
	; save registers
	push si
	push ax

.loop:
	lodsb	; loads next character in al
	or al, al
	jz .done

	mov ah, 0x0e ; call bios interrupt
	mov bh, 0
	int 0x10

	jmp .loop

.done:
	pop ax
	pop si
	ret

main:

	;setup data segment
	mov ax, 0
	mov ds, ax
	mov es, ax

	;setup stack
	mov ss, ax
	mov sp, 0x7C00 ;grows downward from 0x7C00

	mov si, msg_hello
	call puts

	hlt
.halt:
	jmp .halt

msg_hello: db 'Hello World', ENDL, 0


times 510-($-$$) db 0
dw 0AA55h
