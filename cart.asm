.MODEL SMALL
.STACK 100H
.DATA
    menuTitle DB 'Welcome to Cart Page$'
    header DB 'Food                                 Quantity$'
    dots DB '----------------------------------------------------$'
    EXTRN selectionArray:BYTE
    EXTRN grandTotal:WORD 
    EXTRN totalItemCount:BYTE
    EXTRN quantity:BYTE
    
    ; Labels for selected food names
    rice1 DB 'Sweet and Sour Chicken Rice             $'
    rice2 DB 'Thai Style Chicken Rice                 $'
    rice3 DB 'Black Pepper Chicken Rice               $'
    rice4 DB 'Butter Chicken Rice                     $'
    rice5 DB 'Salted Egg Chicken Rice                 $'
    rice6 DB 'Mongolian Chicken Rice                  $'
    rice7 DB 'Cheesy Baked Chicken Rice               $'
    rice8 DB 'Fried Chicken Rice                      $'
    
    totalPriceMsg DB 'Grand Total: RM$'       
    totalQuantityMsg DB 'Total Item: $'

    inputChar DB ?         ; Variable to store the input character
    promptMsg DB 'Press any key to continue: $'

.CODE
    PUBLIC Cart
    EXTRN Order:NEAR                      
    EXTRN LoginMenu:NEAR 
    EXTRN MainMenu:NEAR
    EXTRN MAIN:NEAR
include utils.asm
include cartU.asm

Cart PROC
    MOV AX, @DATA
    MOV DS, AX

    CALL ClearScreen

    CALL MENU                                                

    RICEA:
        CMP selectionArray[0],0                     ; (index = 0) __ __ __ __ __ __ __
        JZ RICEB

        MOV AH,09H
        LEA DX,rice1
        INT 21H

        MOV AH,02H
        MOV DL,quantity[0]
        ADD DL,30H
        INT 21H

        CALL PrintNewLine
            
    RICEB:
        CMP selectionArray[1],0
        JZ RICEC

        MOV AH,09H
        LEA DX,rice2
        INT 21H
        
        MOV AH,02H
        MOV DL,quantity[1]
        ADD DL,30H
        INT 21H
        
        CALL PrintNewLine
        
    RICEC:
        CMP selectionArray[2],0
        JZ RICED

        MOV AH,09H
        LEA DX,rice3
        INT 21H
    
        MOV AH,02H
        MOV DL,quantity[2]
        ADD DL,30H
        INT 21H
        
        CALL PrintNewLine

    RICED:
        CMP selectionArray[3],0
        JZ RICEE

        MOV AH,09H
        LEA DX,rice4
        INT 21H
    
        MOV AH,02H
        MOV DL,quantity[3]
        ADD DL,30H
        INT 21H
        
        CALL PrintNewLine 
        
    RICEE:
        CMP selectionArray[4],0
        JZ RICEF

        MOV AH,09H
        LEA DX,rice5
        INT 21H
    
        MOV AH,02H
        MOV DL,quantity[4]
        ADD DL,30H
        INT 21H
        
        CALL PrintNewLine
            
    RICEF:
        CMP selectionArray[5],0
        JZ RICEG

        MOV AH,09H
        LEA DX,rice6
        INT 21H
    
        MOV AH,02H
        MOV DL,quantity[5]
        ADD DL,30H
        INT 21H
        
        CALL PrintNewLine

    RICEG:
        CMP selectionArray[6],0
        JZ RICEH

        MOV AH,09H
        LEA DX,rice7
        INT 21H
    
        MOV AH,02H
        MOV DL,quantity[6]
        ADD DL,30H
        INT 21H
        
        CALL PrintNewLine
        
    RICEH:
        CMP selectionArray[7],0
        JZ EXIT

        MOV AH,09H
        LEA DX,rice8
        INT 21H
    
        MOV AH,02H
        MOV DL,quantity[7]
        ADD DL,30H
        INT 21H
        
        CALL PrintNewLine
    
EXIT:    
    CALL PrintNewLine
    CALL PrintNewLine

    MOV AH,09H
    LEA DX,totalPriceMsg 
    INT 21h

    MOV BX,grandTotal   
    CALL PrintWordAsDecimal

    CALL PrintNewLine

    MOV AH,09H
    LEA DX,totalQuantityMsg 
    INT 21h
    
    MOV BL,totalItemCount
    CALL PrintWordAsDecimal    

    CALL PrintNewLine   
    RET 

Cart ENDP
END
