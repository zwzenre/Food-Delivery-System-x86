.MODEL SMALL
.STACK 100
.DATA
    ;Declare display text and 
    loginTitle      DB      'Welcome to Our Login Page$'
    header          DB      '----------------------------------------$'
    exitMsg         DB      'Exit Program? (Y = Yes)$'
    exit            DB      ?

.CODE

    PUBLIC  MAIN                     ; Declare the procedure in this file to be use by other files
    EXTRN   LoginMenu:NEAR           ; Declare Others file to external

include utils.asm

MAIN PROC

	MOV AX,@DATA
	MOV DS,AX

    CALL ClearScreen                  ; Call function to clear the screen

	CALL LoginMenu                    ; Call in the login.asm and run the login function

    MOV AH,09H
    LEA DX,exitMsg                    ; After returning from login function, display confirm exit message 
    INT 21h
    
    MOV AH,07H
    INT 21h                           ; Save input in 'exit'
    MOV exit,AL
    
    CMP exit,'Y'                      ; Compare exit with word 'Y'
    JE FINISH                         ; If equal, then jump to FINISH segment
    CMP exit,'y'                      ; Compare exit with word'y'
    JE FINISH                         ; If equal, then jump to FINISH segment

    JMP MAIN                          ; If 'exit' is not 'Y' or 'y', program will jump back to 'MAIN'

    CALL PrintNewLine                 ; Print a new line
    
FINISH:

	MOV AX,4C00H                      ; Terminate the program
	INT 21H

MAIN ENDP
END MAIN