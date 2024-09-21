CLEARDATA PROC
    MOV CX, 20                       ; Set the counter for 20 elements
    LEA SI, selectionArray            ; Load the base address of selectionArray into SI
    LEA DI, quantity            ; Load the base address of quantity into DI

    MOV grandTotal,0 
    MOV totalItemCount,0

ClearArrays:
    MOV BYTE PTR [SI], 0              ; Clear selectionArray element (set to 0)
    MOV BYTE PTR [DI], 0              ; Clear quantityArray element (set to 0)
    INC SI                            ; Move to the next element in selectionArray
    INC DI                            ; Move to the next element in quantity
LOOP ClearArrays                  ; Repeat until CX becomes 0   
    RET
CLEARDATA ENDP

MENU PROC
    CALL PrintNewLine 

    MOV AH,09H
    LEA DX,confirmMsg
    INT 21H

    CALL PrintNewLine
    
    MOV AH,09H
    LEA DX,paymentMsg
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
    INT 21h

    CALL PrintNewLine
    CALL PrintNewLine

    MOV AH,09H
    LEA DX,guide
    INT 21H

    MOV AH,01H
    INT 21h                 ;input for choice
    SUB AL,30H
    MOV choice,AL

    CALL PrintNewLine
    CALL PrintNewLine
    RET
MENU ENDP

ADDRESSINPUT PROC
    MOV AH,09H
    LEA DX,addressMsg
    INT 21h
    
    MOV AH,0AH
    LEA DX,address
    INT 21H

    CALL PrintNewLine

    MOV AH,09H
    LEA DX,confirmAddressMsg
    INT 21h

    MOV AH,09H
    LEA DX,addressBuffer
    INT 21H
    
    CALL PrintNewLine
    CALL PrintNewLine

    RET

ADDRESSINPUT ENDP


CARDFUNCTION PROC
    CALL ADDRESSINPUT

    MOV AH,09H
    LEA DX,cardNumberMsg
    INT 21H

    MOV AH,0AH
    LEA DX,cardNumber
    INT 21H
    
    CALL PrintNewLine 

    CMP ACTCard,16
    JE continuePayWithCard

    CALL PrintNewLine
    
    MOV AH,09H
    LEA DX,errorMsg
    INT 21H
        
    CALL PrintNewLine
        
    JMP FIN1

continuePayWithCard:
    MOV AH,09H    
    LEA DX,confirmCardMsg
    INT 21h
    
    MOV AH,09H
    LEA DX,cardNumberBuffer
    INT 21H

    CALL PrintNewLine
    CALL PrintNewLine

    MOV AH,09H
    LEA DX,askCardPaymentMsg
    INT 21H

    CALL PAYMENT

FIN1:
    RET
CARDFUNCTION ENDP


TNGFUNCTION PROC
    CALL ADDRESSINPUT

    MOV AH,09H
    LEA DX,tngNumberMsg
    INT 21H

    MOV AH,0AH
    LEA DX,phoneNumber
    INT 21H
    
    CALL PrintNewLine 

    CMP ACTPhoneNum,10
    JE continuePayWithPhone
    CMP ACTPhoneNum,11
    JE continuePayWithPhone

    CALL PrintNewLine
    
    MOV AH,09H
    LEA DX,errorMsg
    INT 21H
        
    CALL PrintNewLine
        
    JMP FIN2

continuePayWithPhone:
    MOV AH,09H
    LEA DX,confirmPhoneMsg
    INT 21h
    
    MOV AH,09H
    LEA DX,phoneNumberBuffer
    INT 21H

    CALL PrintNewLine
    CALL PrintNewLine

    MOV AH,09H
    LEA DX,askPhonePaymentMsg
    INT 21H

    CALL PAYMENT 
        
FIN2:
    RET
TNGFUNCTION ENDP

PAYMENT PROC
    MOV AH,07H
    INT 21h
    MOV continueChoice,AL

    CMP continueChoice,'Y'
    JE continuePay
    CMP continueChoice,'y'
    JE continuePay

    CALL PrintNewLine

    MOV AH,09H
    LEA DX,errorMsg
    INT 21H

    CALL WaitForKeyPress

    JMP FIN

    continuePay:
        MOV AH,09H
        LEA DX,paymentSuccess
        INT 21H
    
        CALL PrintNewLine

        MOV AH,09H
        LEA DX,deliveryMsg
        INT 21H

        CALL CLEARDATA
    
        CALL PrintNewLine
    
        JMP FIN

    cancel:
        MOV AH,09H
        LEA DX,paymentCancel
        INT 21H
        
        CALL PrintNewLine

        JMP FIN
    
    FIN:
        RET
PAYMENT ENDP