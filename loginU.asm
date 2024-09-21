MENU PROC
    MOV AH,09H
    LEA DX,loginTitle
    INT 21H
    
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
    CALL PrintNewLine 
    
    MOV AH,09H
    LEA DX,guideOption
    INT 21H
    
    MOV AH,01H
    INT 21H
    MOV choice,AL               ; Save the user's choice in the `choice` variable
    SUB choice,30H              ; Convert ASCII to numerical value
    
    CALL PrintNewLine 
    CALL PrintNewLine 
    RET
MENU ENDP