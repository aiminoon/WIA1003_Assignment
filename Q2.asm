INCLUDE Irvine32.inc
; EAX register print the value
; EBX register get the first value to print for each rows
; ECX register handle total remaining 'rows' to print
; EDX register handle total remaining 'columns' to print

.data
num BYTE 8			; Defines a byte-sized variable named num and initializes it with the value 8.

.code
main PROC
	MOV EAX,0		; Initializes EAX register to 0 (Display value).
	MOV EBX,0		; Initializes EBX register to 0 (Initiate value). 
	MOV ECX,0		; Initializes ECX register to 0 (Outer loop counter for L1). 
	MOV EDX,0		; Initializes EDX register to 0 (Inner loop counter for L2). 
	MOVZX EDX,num	; Loads the value of num (8) into EDX register, zero-extending the byte to a double word.
	MOVZX ECX,num	; Loads the value of num (8) into ECX register, zero-extending the byte to a double word.

L1: 
	MOV EAX, EBX	; Moves the value of EBX into EAX. Initially, both are 0.
	MOV EDX, ECX	; Moves the value of ECX into EDX. Initially, ECX is 8 (from num).

L2:					; Display value.
	INC EAX			; Increments the value in EAX by 1.
	call WriteDec	; Print the value in EAX as a decimal number.
	DEC EDX			; Decrements the value in EDX by 1.
	JNZ L2			; Jumps back to the L2 label if EDX is not zero.

call Crlf			; Print a newline.
INC EBX				; Increments the value in EBX by 1.
DEC ECX				; Decrements the value in ECX by 1.
JNZ L1				; Jumps back to the L1 label if ECX is not zero.

exit
main ENDP
END main
