INCLUDE Irvine32.inc
; EDX register hold the address of string
; EAX register store the value read from user, AL hold the grade

.data 
prompt BYTE "Enter mark (0-100): ",0  ; Prompt the user and display the result.
result BYTE "Grade: ",0               ; Prompt the user and display the result.
invalidMsg BYTE "Invalid input !",0
num DWORD ?                           ; 32-bit memory location to store the integer entered by the user.

.code 
main PROC 
    call GetValue                     ; Call GetValue to get a valid mark from the user.
    call CalculateGrade               ; Calls the CalculateGrade procedure to determine the letter grade.
    exit                              ; Exit the program
main ENDP 

GetValue PROC 
    promptLoop:
        mov edx,OFFSET prompt         ; Moves the address of prompt into edx.
        call WriteString              ; Calls WriteString to display the prompt "Enter mark (0-100): ".
        call ReadInt                  ; Calls ReadInt to read an integer from the user, which stores the result in the eax register.

        ; Validate input
        cmp eax,0                     ; Compare input with 0
        jl invalidInput               ; Jump if input is less than 0
        cmp eax,100                   ; Compare input with 100
        jg invalidInput               ; Jump if input is greater than 100

        mov num,eax                   ; Moves the value in eax (the entered integer) into the memory location num.
        ret                           ; Return from GetValue if input is valid

    invalidInput:
        mov edx,OFFSET invalidMsg     ; Moves the address of invalidMsg into edx.
        call WriteString              ; Display invalid input message.
        call Crlf                     ; Move to a new line.
        jmp promptLoop                ; Jump back to promptLoop

GetValue ENDP 

CalculateGrade PROC 
    mov eax,num                       ; Move the valid input into eax for grade calculation.

    .IF eax>=90 
        mov al,'A'                    ; Sets 'A' to al.
    .ELSEIF eax>=80 
        mov al,'B'                    ; Sets 'B' to al.
    .ELSEIF eax>=70 
        mov al,'C'                    ; Sets 'C' to al.
    .ELSEIF eax>=60 
        mov al,'D'                    ; Sets 'D' to al.
    .ELSE 
        mov al,'F'                    ; Sets 'F' to al.
    .ENDIF                            ; End if condition

    mov edx, OFFSET result            ; Moves the address of result into edx.
    call WriteString                  ; Calls WriteString to display "Grade: ".
    call WriteChar                    ; Calls WriteChar to display the character in al (the letter grade).
    ret
CalculateGrade ENDP 

END main
