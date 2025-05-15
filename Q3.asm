INCLUDE Irvine32.inc 
; EAX register hold the value read from user and calculate the sum
; ECX register store the number of loop
; EDX register hold the address of string and store the sum

.data 
s1 BYTE "Enter 32-bit integer : ",0				; A prompt string to ask the user to enter an integer.
s2 BYTE "The sum of 32-bit integers is : ",0	; A string to display the result.
count = 3										; Defines the number of integers the program will handle.
array DWORD count DUP(?)						; An array to store the integers entered by the user. count DUP(?) means it will have count (3) uninitialized DWORD (32-bit) elements.

.code 
main PROC 
	mov esi,OFFSET array						; Moves the starting address of the array to the ESI register. ESI will be used to point to elements in the array.
	mov ecx,count								; Moves the value of count (3) into the ECX register. ECX will be used as a loop counter.
	call PromptForIntegers						; Calls the PromptForIntegers procedure to read integers from the user.
	call ArraySum								; Calls the ArraySum procedure to calculate the sum of the integers.
	call DisplaySum								; Calls the DisplaySum procedure to display the sum. 
	exit 
	main ENDP

; This procedure prompts the user to enter integers and stores them in the array. The USES directive tells the assembler that this procedure will use the ecx, edx, and esi registers.
PromptForIntegers PROC USES ecx edx esi 
	mov edx,OFFSET s1							; Moves the address of the s1 string into the EDX register.
L1: 
	call WriteString							; Calls the WriteString procedure to display the prompt (s1). 
	call ReadInt								; Calls the ReadInt procedure to read an integer from the user into the EAX register.
	call Crlf									; Calls the Crlf procedure to print a newline.
	mov [esi],eax								; Stores the value in EAX (the integer read) into the memory location pointed to by ESI (current position in the array).
	add esi,TYPE DWORD							; Advances the ESI pointer by the size of a DWORD (4 bytes).
	loop L1										; Decrements ECX and loops back to the L1 label if ECX is not zero.
	ret											; Returns from the procedure.
	PromptForIntegers ENDP

; This procedure calculates the sum of the integers in the array.
ArraySum PROC USES esi ecx 
	mov eax,0									; Initializes EAX to 0. This will hold the sum.
L1: 
	add eax,[esi]								; Adds the value pointed to by ESI (current array element) to EAX.
	add esi,TYPE DWORD							; Advances the ESI pointer by the size of a DWORD (4 bytes).
	loop L1										; Decrements ECX and loops back to the L1 label if ECX is not zero.
	ret											; Returns from the procedure with the sum in EAX.
	ArraySum ENDP 

; This procedure displays the sum of the integers.
DisplaySum PROC USES edx 
	mov edx,OFFSET s2							; Moves the address of the s2 string into the EDX register.
	call WriteString							; Calls the WriteString procedure to display the result prompt (s2).
	call WriteInt								; Calls the WriteInt procedure to display the integer in EAX (the sum).
	ret											; Returns from the procedure.
	DisplaySum ENDP 

END main
