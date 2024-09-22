.MODEL SMALL
.STACK 100H
.DATA
    dots DB '----------------------------------------------------$'
    confirmMsg DB 'Please check your order and total price.$'
    paymentMsg DB 'Choose a payment method.$'
    option1 DB '1. Card$'
    option2 DB '2. TNG E-Wallet$'
    return DB '3. Return Main Menu$'

    guide DB 'Choose between 1-3: $'

    choice DB ?
    continueChoice DB ?
    
    cardNumberMsg DB 'Please enter your card number (16 numbers): $'
    tngNumberMsg DB 'Please enter your phone number (10 to 11 numbers without dash): $'
    addressMsg DB 'Please enter your address: $'  

    errorMsg DB 'Invalid. Please try again.$'

    cardNumber LABEL BYTE
	MAXCard DB 20
	ACTCard DB ?
	cardNumberBuffer DB 20 DUP ('$')

    phoneNumber LABEL BYTE
	MAXPhoneNum DB 20
	ACTPhoneNum DB ?
	phoneNumberBuffer DB 20 DUP ('$')
    
    address LABEL BYTE
	MAXaddress DB 50
	ACTaddress DB ?
	addressBuffer DB 50 DUP ('$')

    confirmAddressMsg DB 'This is your address: $'
    
    cartEmpty DB 'Your cart is empty. Go order some food.$'

    ;Card Payment
    confirmCardMsg DB 'This is your card number: $'
    askCardPaymentMsg DB 'Continue payment with this card? (Y = Yes)$'

    ;Tng Payment
    confirmPhoneMsg DB 'This is your phone number: $'
    askPhonePaymentMsg DB 'Continue payment with this number? (Y = Yes)$'

    paymentCancel DB 'Payment Cancel.$'
    paymentSuccess DB 'Payment Success.$'
    deliveryMsg DB 'Delivery is on the way.$'

    inputChar DB ?         ; Variable to store the input character
    promptMsg DB 'Press any key to continue: $'

    ;global var
    EXTRN selectionArray:BYTE
    EXTRN grandTotal:WORD 
    EXTRN totalItemCount:BYTE
    EXTRN quantity:BYTE

.CODE
    PUBLIC Pay
    EXTRN Order:NEAR                      
    EXTRN LoginMenu:NEAR 
    EXTRN MainMenu:NEAR
    EXTRN MAIN:NEAR
    EXTRN Cart:NEAR
include utils.asm
include payU.asm

Pay PROC
    MOV AX, @DATA
    MOV DS, AX

    CMP totalItemCount,0
    JE EMPTY

    CALL MENU

    CMP choice,1
    JE CardPayment
    CMP choice,2
    JE TngPayment
    CMP choice,3
    JE FINISH

    JMP Error

CardPayment:
    CALL CARDFUNCTION

    JMP FINISH  

TngPayment:
    CALL TNGFUNCTION

    JMP FINISH

Error:
    MOV AH,09H
    LEA DX,errorMsg
    INT 21H

    JMP FINISH

EMPTY:
    MOV AH,09H
    LEA DX,cartEmpty
    INT 21h

    CALL PrintNewLine

FINISH:
    MOV AH,09H
	LEA DX,promptMsg
	INT 21H

    CALL WaitForKeyPress

    CALL MainMenu 
    
    RET
    
Pay ENDP
END 