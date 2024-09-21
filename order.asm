.MODEL SMALL
.STACK 100H
.DATA

    ;Main Menu
    menuTitle DB 'Welcome to Ordering Page$'
    header DB '----------------------------------------$'
    option1 DB '1. Sweet and Sour Chicken Rice  - RM8$'
    option2 DB '2. Thai Style Chicken Rice      - RM8$'
    option3 DB '3. Black Pepper Chicken Rice    - RM10$'
    option4 DB '4. Butter Chicken Rice          - RM10$'
    option5 DB '5. Salted Egg Chicken Rice      - RM10$'
    option6 DB '6. Mongolian Chicken Rice       - RM9$'
    option7 DB '7. Cheesy Baked Chicken Rice    - RM10$'
    option8 DB '8. Fried Chicken Rice           - RM9$'
    goBack DB '9. Return$'
    
    ten DB 10

    guideFoodOption DB 'Choose between 1-9: $'
    choice DB ?

    guideQuantityOption DB 'Enter quantity (1-9): $'
    inputQuantity DB ?
    
    itemPrices DB 8,8,10,10,10,9,10,9
    
    ; Labels for selected food names
    rice1 DB 'Sweet and Sour Chicken Rice$'
    rice2 DB 'Thai Style Chicken Rice$'
    rice3 DB 'Black Pepper Chicken Rice$'
    rice4 DB 'Butter Chicken Rice$'
    rice5 DB 'Salted Egg Chicken Rice$'
    rice6 DB 'Mongolian Chicken Rice$'
    rice7 DB 'Cheesy Baked Chicken Rice$'
    rice8 DB 'Fried Chicken Rice$'                                  

    totalPrice DB 0

    priceMsg DB 'Price: RM$'
    itemMsg DB 'Quantity Ordered: $'
    grandTotalMsg DB 'Total Price: RM$'

    confirmMsg DB 'Order successfully added$'

    inputChar DB ?                 ; Variable to store the input character
    promptMsg DB 'Press any key to continue: $'
    errorMsg DB 'Invalid Choice. Please choose again.$'

    ;Global Variable
    PUBLIC quantity
    quantity DB 20 DUP (0)

    PUBLIC totalItemCount
    totalItemCount DB 0            ; Count of how many items were ordered (use for cart.asm)

    PUBLIC selectionArray
    selectionArray DB 20 DUP (0)

    PUBLIC grandTotal
    grandTotal DW 0

.CODE
    PUBLIC Order
    EXTRN MAIN:NEAR
    EXTRN LoginMenu:NEAR 
    EXTRN MainMenu:NEAR
    EXTRN Cart:FAR
include utils.asm
include orderU.asm

Order PROC
    MOV AX, @DATA
    MOV DS, AX

    CALL ClearScreen
    
    CALL MENU

    CALL PrintNewLine
    
    MOV AH,09H
    LEA DX,guideFoodOption
    INT 21H
    
    ; Get user input
    MOV AH,01H
    INT 21H
    SUB AL,30H              ; Convert ASCII to numerical value
    MOV choice,AL               ; Save the user's choice in the `choice` variable
    
    CALL PrintNewLine
    CALL PrintNewLine   
    
    ; Check user choice
    CMP choice, 1
    JE RICEA
    CMP choice, 2
    JE RICEB
    CMP choice, 3
    JE RICEC
    CMP choice, 4
    JE RICED
    CMP choice, 5
    JE RICEE
    CMP choice, 6
    JE RICEF
    CMP choice, 7
    JE RICEG
    CMP choice, 8
    JE RICEH
    CMP choice, 9
    JE FINISH

    JMP Order ; Return if invalid choice
    
RICEA:
    CALL printA
    CALL setIndexA
    JMP getQuantity

RICEB:
    CALL printB
    CALL setIndexB
    JMP getQuantity

RICEC:
    CALL printC
    CALL setIndexC
    JMP getQuantity

RICED:
    CALL printD
    CALL setIndexD
    JMP getQuantity
    
RICEE:
    CALL printE
    CALL setIndexE
    JMP getQuantity

RICEF:
    CALL printF
    CALL setIndexF
    JMP getQuantity
 
RICEG:
    CALL printG
    CALL setIndexG
    JMP getQuantity

RICEH:
    CALL printH
    CALL setIndexH
    JMP getQuantity

getQuantity:

    CALL QUANTITYINPUT

    CMP inputQuantity,0
    JE RETURN
    CMP inputQuantity,1                 ; Validation check for quantity
    JB RETURN
    CMP inputQuantity,9
    JA RETURN
    
    CALL PrintNewLine

    CALL CALQUANTITY
    JMP FINISH

RETURN:
    MOV AH,09H
    LEA DX,errorMsg                     ; Display Error Message
    INT 21H

    JMP FINISH    

FINISH:
    CALL PrintNewLine
    CALL PrintNewLine

    MOV AH,09H
	LEA DX,promptMsg
	INT 21H

    CALL WaitForKeyPress

    CALL MainMenu    
    RET
    
Order ENDP
END 