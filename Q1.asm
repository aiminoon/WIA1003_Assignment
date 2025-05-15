INCLUDE Irvine32.inc 

.data
array WORD 0,2,5,9,10           ; Array Initialization with 5 elements
sum DWORD 0                     ; Variable to store the sum of differences

.code
main PROC
    MOV ECX, LENGTHOF array     ; Load the length of the array (number of elements) into ECX
    MOV ESI, OFFSET array       ; Load the address of the first element of the array into ESI
    MOV EAX, 0                  ; Initializes EAX to 0
    MOV EBX, 0                  ; Initializes EBX to 0
    MOV EDX, 0                  ; Initializes EDX to 0

L1:
    MOV AX, [ESI]               ; Move the current element pointed to by ESI into AX
    MOV BX, [ESI + TYPE array]  ; Move the next element in the array into BX
    SUB BX, AX                  ; Subtract the current element (AX) from the next element (BX)
    ADD sum, EBX                ; Add the result of the subtraction to the sum
    MOV EDX, sum                ; Moves the current value of sum into the EDX
    ADD ESI, TYPE array         ; Move ESI to point to the next element in the array
    call DumpRegs               ; Displays the current state of the registers
    Loop L1                     ; Decrement ECX and repeat the loop if ECX is not zero

exit
main ENDP
END main
