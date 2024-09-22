ClearRegisters PROC 
    XOR AX,BX
    XOR BX,BX
    XOR CX,CX
    XOR DX,DX
ClearRegisters ENDP

ClearScreen PROC
    PUSH AX        ; Save registers
    PUSH BX
    PUSH CX
    PUSH DX
    
    MOV AH,0H
    MOV AL,3H
    INT 10H

    POP DX         ; Restore registers
    POP CX
    POP BX
    POP AX
    RET
ClearScreen endp


PrintString PROC
    ; Assumes DX points to the string to print
    MOV AH, 09H         ; DOS function to print a string
    INT 21H             ; Call DOS interrupt
    RET
PrintString ENDP

PrintNewLine PROC
    MOV AH, 02H         ; BIOS function to output a character
    MOV DL, 0DH         ; Carriage return
    INT 21H
    MOV DL, 0AH         ; Line feed
    INT 21H
    RET
PrintNewLine ENDP

; Waits for the user to press any key
WaitForKeyPress PROC
    MOV AH, 00H         ; BIOS function to read a character without echo
    INT 16H             ; Call BIOS interrupt
    RET
WaitForKeyPress ENDP

PrintWordAsDecimal PROC
    PUSH AX        ; Save registers
    PUSH BX
    PUSH CX
    PUSH DX

    MOV CX, 10     ; We'll divide by 10 to extract digits
    XOR DX, DX     ; Clear DX to ensure no extra values in DX
    MOV AX, BX     ; Copy BX (the word value) to AX for division

    ; Check if AX is zero, handle zero as a special case
    CMP AX, 0
    JNE NEXT
    MOV DL, '0'    ; If AX is 0, print '0'
    MOV AH, 02H    ; DOS print character function
    INT 21H
    JMP END_PRINT

    NEXT:
        ; Begin the loop to extract digits
        MOV SI, 0      ; Index into digit buffer
        MOV DI, 6      ; Maximum of 5 digits + null terminator

    DIV_LOOP:
        XOR DX, DX     ; Clear DX before DIV
        DIV CX         ; AX = AX / 10, DX = remainder (digit)

        ADD DL, '0'    ; Convert remainder to ASCII
        PUSH DX        ; Store the digit on the stack
    
        INC SI         ; Count how many digits we have
        CMP AX, 0      ; If AX is 0, we are done
        JNE DIV_LOOP

        ; Now print digits in reverse order (from the stack)
    PRINT_LOOP:
        POP DX         ; Get the next digit from the stack
        MOV AH, 02H    ; DOS function to print a character
        INT 21H
        DEC SI         ; Decrease digit count
        JNZ PRINT_LOOP ; If there are still digits, continue

    END_PRINT:
        POP DX         ; Restore registers
        POP CX
        POP BX
        POP AX
        RET
PrintWordAsDecimal ENDP