.MODEL SMALL
.STACK 100
.DATA
    ;Login Menu
    loginTitle      DB      'Welcome to Our Login Page$'
    header          DB      '----------------------------------------$'
    option1         DB      '1. Login$'
    option2         DB      '2. Exit$'
    choice          DB      ?
    guideOption     DB      'Choose between 1-2: $'
    invalidChoice   DB      'Invalid Choice. Please Try Again!$'

    ;Login
    enterName       DB      'Enter name: $'
    enterPassword   DB      'Enter password: $'
    msgSuccess      DB      'Login successfully.$'
    msgFailed       DB      'Login failed. Please try again.$'
    
    USER            DB      "admin$"
    PASS            DB      "123$"
    
    ;Login Username
    username            LABEL BYTE
	MAXUSERNAME         DB      20
	ACTUSERNAME         DB      ?
	usernameBuffer      DB      20 DUP ('$')
    
    ;Login Password
    password            LABEL BYTE
	MAXPASSWORD         DB      20
	ACTPASSWORD         DB      ?
	passwordBuffer      DB      20 DUP ('$')
    
    ;getchar function
    inputChar           DB      ?                                   ; variable to store the input character 
    promptMsg           DB      'Press any key to continue: $'

.CODE
    PUBLIC  LoginMenu
    EXTRN   MAIN:NEAR
    EXTRN   MainMenu:NEAR 

include utils.asm
include loginU.asm

LoginMenu PROC
    MOV AX,@DATA
	MOV DS,AX
    
    CALL ClearScreen
    
    CALL MENU

    ; Check user choice
    CMP choice,1
    JE LOGIN
    CMP choice,2
    JE EXIT
    
    MOV AH,09H
    LEA DX,invalidChoice
    INT 21h
    
    CALL PrintNewLine

    MOV AH,09H
    LEA DX,promptMsg
    INT 21H

    CALL WaitForKeyPress
    ; Unconditional jump to finish if no valid choice is made
    JMP MAIN ; Return to the main menu if invalid choice is made
    
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

    MOV SI,0
	MOV CL,ACTUSERNAME
    JMP L1

EXIT:
    RET

; Compare the input username and password with the stored ones
L1:
	MOV BL,USER[SI]	
	CMP usernameBuffer[SI],BL
	JE N1
	
	MOV AH,09H
	LEA DX,msgFailed
	INT 21H
	JMP FINISH

N1:	
	INC SI

	MOV AL,ACTUSERNAME
	CMP AL,05
	JE L2
	
E1:
	MOV AH,09H
	LEA DX,msgFailed
	INT 21H
	JMP FINISH
		

LOOP L1
    MOV SI,0
	MOV CL,ACTPASSWORD

L2:
	MOV BL,PASS[SI]	
	CMP passwordBuffer[SI],BL
	JE N2
	
	MOV AH,09H
	LEA DX,msgFailed
	INT 21H
	
    CALL PrintNewLine
        
	JMP FINISH

N2:	
	INC SI

	MOV AL,ACTPASSWORD
	CMP AL,03
	JE SUCCESS
	
E2:
	MOV AH,09H
	LEA DX,msgFailed
	INT 21H
    
    CALL PrintNewLine

	JMP FINISH
		
LOOP L2

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