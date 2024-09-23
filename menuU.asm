MENU PROC
    ; Display Menu
    MOV AH,09H
    LEA DX,menuTitle            ; Display menuTitle
    INT 21h
    
    CALL PrintNewLine

    MOV AH,09H 
    LEA DX,header                ; Display header   
    INT 21H

    CALL PrintNewLine
    
    MOV AH,09H
    LEA DX,option1                ; Display option1
    INT 21H
    
    CALL PrintNewLine
    
    MOV AH,09H
    LEA DX,option2                ; Display option2
    INT 21H

    CALL PrintNewLine
    
    MOV AH,09H
    LEA DX,option3                ; Display option3
    INT 21H
    
    CALL PrintNewLine
    
    MOV AH,09H  
    LEA DX,option4                 ; Display option4
    INT 21H
    
    CALL PrintNewLine

    MOV AH,09H  
    LEA DX,return                  ; Display return 
    INT 21H
    
    CALL PrintNewLine
    CALL PrintNewLine
    
    MOV AH,09H
    LEA DX,guideOption              ; Display guidance for user
    INT 21H
    
    ; Get user input
    MOV AH,01H
    INT 21H
    SUB AL,30H                      ; Convert ASCII to numerical value
    MOV choice,AL                   ; Save the user's choice in the `choice` variable
    
    
    CALL PrintNewLine

    RET
MENU ENDP


CLEARDATA PROC
    MOV CX, 20                        ; Set the counter for 20 elements
    LEA SI, selectionArray            ; Load the base address of selectionArray into SI
    LEA DI, quantity                  ; Load the base address of quantity into DI

    MOV grandTotal,0 
    MOV totalItemCount,0

ClearArrays:
    MOV BYTE PTR [SI], 0              ; Clear selectionArray element (set to 0)
    MOV BYTE PTR [DI], 0              ; Clear quantityArray element (set to 0)
    INC SI                            ; Move to the next element in selectionArray
    INC DI                            ; Move to the next element in quantity
LOOP ClearArrays                      ; Repeat until CX becomes 0   

    MOV AH,09H
	LEA DX,deleteMsg                      ; Display delete message
	INT 21H

    CALL PrintNewLine

    MOV AH,09H
	LEA DX,promptMsg                      
	INT 21H

    CALL WaitForKeyPress

    RET
CLEARDATA ENDP

EMPTY PROC
    MOV AH,09H
    LEA DX,cartEmpty
    INT 21h

    CALL PrintNewLine

    MOV AH,09H
	LEA DX,promptMsg                      
	INT 21H

    CALL WaitForKeyPress

    
EMPTY ENDP