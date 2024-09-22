.MODEL SMALL
.STACK 100
.DATA
    ;Login Menu Display
    loginTitle          DB      'Welcome to Our Login Page$'
    header              DB      '----------------------------------------$'
    option1             DB      '1. Login$'
    option2             DB      '2. Exit$'
    choice              DB      ?
    guideOption         DB      'Choose between 1-2: $'
    invalidChoice       DB      'Invalid Choice. Please Try Again!$'

    ;Login
    enterName           DB      'Enter name: $'
    enterPassword       DB      'Enter password: $'                         ;Input Login Display
    msgSuccess          DB      'Login successfully.$'
    msgFailed           DB      'Login failed. Please try again.$'          ;Display Login Output
    
    USER                DB      "admin$"                                    ;username for login
    PASS                DB      "123$"                                      ;password for login
    
    ;Login Username String
    username            LABEL BYTE                                              
	MAXUSERNAME         DB      20
	ACTUSERNAME         DB      ?
	usernameBuffer      DB      20 DUP ('$')
    
    ;Login Password String
    password            LABEL BYTE
	MAXPASSWORD         DB      20
	ACTPASSWORD         DB      ?
	passwordBuffer      DB      20 DUP ('$')
    
    ;Getchar Function
    inputChar           DB      ?                                       ; variable to store the random character
    promptMsg           DB      'Press any key to continue: $'          ; display a message for user to enter any key

.CODE
    PUBLIC  LoginMenu                                                   ; Set LoginMenu as public for other files to use
    EXTRN   MAIN:NEAR                                                   ; Set MAIN from main.asm as external to use        
    EXTRN   MainMenu:NEAR                                               ; Set MainMenu from menu.asm as external to use     

include utils.asm                                                       ; Include the general utility file for use
include loginU.asm                                                      ; Include the login utility file for use

LoginMenu PROC
    MOV AX,@DATA
	MOV DS,AX
    
    CALL ClearScreen                                                    ; Call clear screen function
    
    CALL MENU                                                           ; Call Login Display from loginU.asm

    ; Check user choice
    CMP choice,1
    JE LOGIN
    CMP choice,2
    JE EXIT
    
    MOV AH,09H
    LEA DX,invalidChoice                                                ; Display invalid message
    INT 21h
    
    CALL PrintNewLine                                                   ; new line

    MOV AH,09H
    LEA DX,promptMsg                                                    ; prompt message for get char function
    INT 21H

    CALL WaitForKeyPress

    ; Unconditional jump to finish if no valid choice is made

    JMP MAIN                                                            ; Return to the main menu if invalid choice is made
    

    EXIT:
        RET                                                             ; Returning back to main.asm


LOGIN:
    ; Display prompt and get the username
    MOV AH,09H
    LEA DX,enterName
    INT 21H

    MOV AH,0AH
    LEA DX,username     
    INT 21H
    
    CALL PrintNewLine 

    ; Display prompt and get the password
    MOV AH,09H
    LEA DX,enterPassword
    INT 21H

    MOV AH,0AH
    LEA DX,password
    INT 21H
    
    CALL PrintNewLine 

     ; Username Comparing
    MOV SI,0
	MOV CL,ACTUSERNAME                                                  ; Compare entered name with the correct name
    JMP L1                                  

    L1:
	    MOV BL,USER[SI]	
	    CMP usernameBuffer[SI],BL
	    JE N1

        JMP WRONGACCESS                                                 ; If not correct, jump to display error                                               

    N1:	
	    INC SI

	    MOV AL,ACTUSERNAME                                                  ; compare string length
	    CMP AL,05                                                           ; length of "admin" is 05
	    JE L2
	
        JMP WRONGACCESS
    LOOP L1


    ; Password Comparing
    MOV SI,0
	MOV CL,ACTPASSWORD                                                  

    L2:
	    MOV BL,PASS[SI]	
	    CMP passwordBuffer[SI],BL
	    JE N2
	
        JMP WRONGACCESS

    N2:	
	    INC SI

	    MOV AL,ACTPASSWORD
	    CMP AL,03
	    JE SUCCESS
	
    E2:
	    JMP WRONGACCESS
		
LOOP L2

WRONGACCESS:
	MOV AH,09H
	LEA DX,msgFailed                                                    ; username not correct, error display 
	INT 21H

    CALL PrintNewLine

	JMP FINISH 

SUCCESS:

    CALL PrintNewLine

	MOV AH,09H
	LEA DX,msgSuccess
	INT 21H
    
    CALL PrintNewLine 
    
    MOV AH,09H
	LEA DX,promptMsg
	INT 21H

    CALL WaitForKeyPress 

	JMP MainMenu

    
FINISH:
    CALL PrintNewLine

    MOV AH,09H
    LEA DX,promptMsg
    INT 21H

    CALL WaitForKeyPress

    CALL PrintNewLine
    
    JMP LoginMenu

LoginMenu ENDP
END