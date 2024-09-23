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

    ;getchar
    inputChar              DB       ?                                           
    promptMsg              DB       'Press any key to continue: $'
    
    ;delete segment
    confirmDeleteMsg       DB       'Are you sure to remove all orders? (Y = Yes)$'
    deleteOption           DB       ?
    deleteMsg              DB       'Order Deleted$'

    errorMsg               DB       'Invalid Choice. Please choose again.$'
    
    cartEmpty              DB       'Your cart is empty. Go order some food.$'
    
    ;set following data types as external so that these data types which is global can use in this file
    EXTRN selectionArray:BYTE                  
    EXTRN grandTotal:WORD                      
    EXTRN totalItemCount:BYTE                  
    EXTRN quantity:BYTE                        

.CODE
    PUBLIC MainMenu                 ; Set MainMenu as public for other files to use
    EXTRN MAIN:NEAR                 ; Set MAIN from main.asm as external to use
    EXTRN LoginMenu:NEAR            ; Set LoginMenu from login.asm as external to use
    EXTRN Order:NEAR                ; Set Order from order.asm as external to use
    EXTRN Cart:NEAR                 ; Set Cart from cart.asm as external to use
    EXTRN Pay:NEAR                  ; Set Pay from pay.asm as external to use
     
include utils.asm                   ; Include the general utility file for use
include menuU.asm                   ; Include the menu utility file for use

MainMenu PROC
    MOV AX, @DATA
    MOV DS, AX

    CALL ClearScreen                ; Call clear screen function
    
    CALL MENU                       ; Call Menu Display from menuU.asm
    
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

    JMP MainMenu                     ; Return to the main menu if invalid choice is made
    
NEWORDER:
    CALL Order                       ; Call Order Function from order.asm

    JMP FINISH                       ; Jump to the end of the program

SHOWCART:
    CALL Cart                        ; Call Cart Function from cart.asm

    MOV AH,09H
	LEA DX,promptMsg                    
	INT 21H

    CALL WaitForKeyPress

    CALL MainMenu    

    JMP FINISH                        ; Jump to the end of the program

PAYMENT:
    CALL Cart                          ; Call Pay Function from pay.asm

    CMP totalItemCount,0
    JE EMPTYprompt

    CALL Pay

    JMP MainMenu

    JMP FINISH                        ; Jump to the end of the program
    
DELETE:
    CALL Cart

    CMP totalItemCount,0
    JE EMPTYprompt

    MOV AH,09H
	LEA DX,confirmDeleteMsg           ; Display confirm delete message
	INT 21H

    MOV AH,01H
    INT 21H
    MOV deleteOption,AL                ; Store user's choice for deletion

    CALL PrintNewLine

    CMP deleteOption,'Y'
    JE CLEAR                            ; compare 'Y' & 'y' for the word yes
    CMP deleteOption,'y'                ; if same, jump to CLEAR segment
    JE CLEAR

    CALL PrintNewLine

    MOV AH,09H
	LEA DX,promptMsg                     ; Display return back after choosing not to delete
	INT 21H

    CALL WaitForKeyPress

    JMP MainMenu

EMPTYprompt:
    CALL EMPTY

    JMP MainMenu

CLEAR:
    CALL PrintNewLine

    CALL CLEARDATA                        ; call clear data from menuU.asm to remove all saved options by setting value of SI and arrays to nothing      

    JMP MainMenu                           ; Jump back to MainMenu after deleting

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