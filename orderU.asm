MENU PROC
    ; Display Menu
    MOV AH,09H
    LEA DX,menuTitle
    INT 21h
    
    CALL PrintNewLine

    MOV AH,09H
    LEA DX,header
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
    LEA DX,option3
    INT 21H
    
    CALL PrintNewLine
    
    MOV AH,09H
    LEA DX,option4
    INT 21H
    
    CALL PrintNewLine
    
    MOV AH,09H
    LEA DX,option5
    INT 21H
    
    CALL PrintNewLine
    
    MOV AH,09H
    LEA DX,option6
    INT 21H
    
    CALL PrintNewLine
    
    MOV AH,09H
    LEA DX,option7
    INT 21H
    
    CALL PrintNewLine

    MOV AH,09H
    LEA DX,option8
    INT 21H
    
    CALL PrintNewLine

    MOV AH,09H
    LEA DX,goBack
    INT 21H
    
    CALL PrintNewLine
    RET
MENU ENDP

QUANTITYINPUT PROC
    MOV AH,09H
    LEA DX, guideQuantityOption         ; Display message
    INT 21H

    MOV AH, 01H
    INT 21H
    SUB AL,30H                          ; Convert ASCII to numerical value
    MOV inputQuantity, AL               ; Save the user's quantity input

    MOV BX,0                            ; Clear BX for usage
    MOV BL, itemPrices[SI]              ; With SI being 0, itemPrices[0] is the first value in the list which is RM8 and move to BL

    CALL PrintNewLine
    
    RET
QUANTITYINPUT ENDP

CALQUANTITY PROC
    MOV AL,inputQuantity                ; store input quantity into AL
    ADD totalItemCount,AL               ; add the input quantity into global var 

    ADD quantity[SI],AL                 ; for example, when 1st food type is chosen, SI will be set to 0 from the previous function.
                                        ; so for quantity[0] will store the AL for the 1st food type
                                        ; it will be later used in cart

    MOV AH,09H                          
    LEA DX,priceMsg                     ; display price message
    INT 21H

    MOV AX,0                            ; Clear AX for usage
    MOV AL, BL                          ; example originally 1st food type = RM 8 in BL, move to AL for multiplication purpose
    MUL inputQuantity                   ; times the number inputQuantity that user enter

    ;AX = total price for one menu item
    ADD grandTotal,AX                   ; add the AX that saves the current total item price to the global variable grand total

    DIV ten                             ; the current item total price is still in AL, divide ten for displaying 2 digit purpose later on
    MOV BX,AX                           ; move AX to BX just in case

    MOV AH,02H
    MOV DL,BL
    ADD DL,30H                          ; display 1st digit of the current item total price
    INT 21H
    
    MOV AH,02H
    MOV DL,BH                           ; display 2nd digit of the current item total price
    ADD DL,30H
    INT 21H

    CALL PrintNewLine
    CALL PrintNewLine

    MOV AH,09H
    LEA DX,itemMsg                       ; display total item quantity message
    INT 21H

    MOV AH,02H
    MOV DL,inputQuantity                 ; display the quantity that the user input
    ADD DL,30H
    INT 21H

    CALL PrintNewLine

    MOV AH,09H
    LEA DX,confirmMsg                    ; display order has been added
    INT 21h

    RET
CALQUANTITY ENDP

printA proc
    MOV AH,09H
    LEA DX,rice1                          ; display Sweet and Sour Chicken Rice
    INT 21H
    
    CALL PrintNewLine
    
    RET
printA endp 

printB proc
    MOV AH,09H
    LEA DX,rice2                          ; display Thai Style Chicken Rice 
    INT 21h
    
    CALL PrintNewLine

    RET
printB endp 

printC proc
    MOV AH,09H  
    LEA DX,rice3                         ; display Black Pepper Chicken Rice
    
    INT 21h
    
    CALL PrintNewLine

    RET
printC endp 

printD proc
    MOV AH,09H
    LEA DX,rice4                         ; display Butter Chicken Rice
    INT 21h
    
    CALL PrintNewLine

    RET
printD endp 

printE proc
    MOV AH,09H
    LEA DX,rice5                            ; display Salted Egg Chicken Rice
    INT 21h
    
    CALL PrintNewLine

    RET
printE endp

printF proc
    MOV AH,09H
    LEA DX,rice6                            ; display Mongolian Chicken Rice
    INT 21h
    
    CALL PrintNewLine

    RET
printF endp 

printG proc
    MOV AH,09H
    LEA DX,rice7                             ; display Cheesy Baked Chicken Rice
    INT 21h
    
    CALL PrintNewLine

    RET
printG endp 

printH proc
    MOV AH,09H
    LEA DX,rice8                        ; display Fried Chicken Rice
    INT 21h
    
    CALL PrintNewLine

    RET
printH endp 

setIndexA proc
    MOV SI,0                        ; Set the SI to 0, later use in itemPrice array to get the first food's price which is RM8
    MOV selectionArray[SI],1        ; Is now known that SI = 0,  it will point the FIRST index in the array of selectionArray and set as 1
    RET
setIndexA endp

setIndexB proc
    MOV SI,1
    MOV selectionArray[SI],2
    RET
setIndexB endp

setIndexC proc
    MOV SI,2
    MOV selectionArray[SI],3
    RET
setIndexC endp

setIndexD proc
    MOV SI,3
    MOV selectionArray[SI],4
    RET
setIndexD endp

setIndexE proc
    MOV SI,4
    MOV selectionArray[SI],5
    RET
setIndexE endp

setIndexF proc
    MOV SI,5
    MOV selectionArray[SI],6
    RET
setIndexF endp

setIndexG proc
    MOV SI,6
    MOV selectionArray[SI],7
    RET
setIndexG endp

setIndexH proc
    MOV SI,7
    MOV selectionArray[SI],8
    RET
setIndexH endp