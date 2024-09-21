.MODEL SMALL
.STACK 100H
.DATA
    ;menu segment
    menuTitle              DB       'Welcome to Top Up Menu$'
    header                 DB       '----------------------------------------$'
    chooseOption           DB       'Choose your top-up option: $'
    option1                DB       '1. Card$'
    option2                DB       '2. Tng E-Wallet$'
    return                 DB       '3. Return$'
    choice                 DB       ?
    guideOption            DB       'Choose between 1-3: $'
    exitMsg                DB       'Exiting the system...$'

    inputChar              DB       ?                                           ; Variable to store the input character
    promptMsg              DB       'Press any key to continue: $'
    

.CODE
    PUBLIC Wallet
    EXTRN MAIN:NEAR
    EXTRN LoginMenu:NEAR 
    EXTRN Order:NEAR
    EXTRN Cart:NEAR
    EXTRN Pay:NEAR
     
include utils.asm

Wallet PROC
    MOV AX, @DATA
    MOV DS, AX

    CALL ClearScreen

    MOV AH,09H
    LEA DX,menuTitle
    INT 21h

    CALL PrintNewLine

    MOV AH,09H
    LEA DX,header
    INT 21H

    CALL PrintNewLine

    MOV AH,09H
    LEA DX,chooseOption
    INT 21H

    CALL PrintNewLine

    MOV AH,09H
    LEA DX,option1
    INT 21H

    CALL PrintNewLine

    MOV AH,09H
    LEA DX,option2
    INT 21H

    CALL PrintNewLine

    MOV AH,09H
    LEA DX,return
    INT 21H

    CALL PrintNewLine
    CALL PrintNewLine

    MOV AH,09H
    LEA DX,guideOption
    INT 21H

    MOV AH,01H
    INT 21H
    SUB AL,30H
    MOV choice,AL

    CALL PrintNewLine



FINISH:
    CALL PrintNewLine

    MOV AH,09H
	LEA DX,promptMsg
	INT 21H

    CALL WaitForKeyPress

    CALL MAIN
    RET
    
Wallet ENDP
END 