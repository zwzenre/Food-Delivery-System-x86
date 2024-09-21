.MODEL SMALL
.STACK 100H
.DATA

    ;menu segment
    menuTitle              DB       'Welcome to Main Menu$'
    header                 DB       '----------------------------------------$'
    option1                DB       '1. New Order$'
    option2                DB       '2. View Cart$'
    option3                DB       '3. Payment$'
    option4                DB       '4. Remove Order$'
    return                 DB       '5. Return$'
    choice                 DB       ?
    guideOption            DB       'Choose between 1-5: $'
    exitMsg                DB       'Exiting the system...$'

    inputChar              DB       ?                                           ; Variable to store the input character
    promptMsg              DB       'Press any key to continue: $'
    
    ;delete segment
    confirmDeleteMsg       DB       'Are you sure to remove all orders? (Y = Yes)$'
    deleteOption           DB       ? 
    deleteMsg              DB       'Order Deleted$'

    errorMsg               DB       'Invalid Choice. Please choose again.$'

    ;set following data types as external to become a global variable for to be used in other files
    EXTRN selectionArray:BYTE                  
    EXTRN grandTotal:WORD                      
    EXTRN totalItemCount:BYTE                  
    EXTRN quantity:BYTE                        


.CODE
    PUBLIC MainMenu
    EXTRN MAIN:NEAR
    EXTRN LoginMenu:NEAR 
    EXTRN Order:NEAR
    EXTRN Cart:NEAR
    EXTRN Pay:NEAR
     
include utils.asm
include menuU.asm

MainMenu PROC
    MOV AX, @DATA
    MOV DS, AX

    CALL ClearScreen
    
    CALL MENU
    
    ; Check user choice
    CMP choice,1
    JE NEWORDER
    CMP choice,2
    JE SHOWCART
    CMP choice,3
    JE PAYMENT
    CMP choice,4
    JE DELETE
    CMP choice,5
    JE FINISH
    
    ; Unconditional jump to finish if no valid choice is made
    JMP MainMenu ; Return to the main menu if invalid choice is made
    
NEWORDER:
    CALL Order

    JMP FINISH  ; Jump to the end of the program

SHOWCART:
    CALL Cart

    MOV AH,09H
	LEA DX,promptMsg
	INT 21H

    CALL WaitForKeyPress

    CALL MainMenu    

    JMP FINISH  ; Jump to the end of the program

PAYMENT:
    CALL Cart
    CALL Pay

    JMP FINISH  ; Jump to the end of the program
    
DELETE:
    MOV AH,09H
	LEA DX,confirmDeleteMsg
	INT 21H

    MOV AH,01H
    INT 21H
    MOV deleteOption,AL

    CALL PrintNewLine

    CMP deleteOption,'Y'
    JE CLEAR
    CMP deleteOption,'y'
    JE CLEAR

    CALL PrintNewLine

    MOV AH,09H
	LEA DX,errorMsg
	INT 21H

    CALL WaitForKeyPress

    JMP MainMenu

CLEAR:
    CALL PrintNewLine

    MOV AH,09H
	LEA DX,deleteMsg
	INT 21H

    CALL CLEARDATA

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

    CALL MAIN
    RET
    
MainMenu ENDP
END 