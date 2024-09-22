MENU PROC
    MOV AH,09H
    LEA DX,loginTitle          ; Display title
    INT 21H
    
    CALL PrintNewLine 
    
    MOV AH,09H
    LEA DX,header               ; Display header
    INT 21H

    CALL PrintNewLine 
    
    MOV AH,09H
    LEA DX,option1               ; Display option1
    INT 21H
    
    CALL PrintNewLine 
    
    MOV AH,09H
    LEA DX,option2               ; Display option2
    INT 21H
    
    CALL PrintNewLine 
    CALL PrintNewLine 
    
    MOV AH,09H
    LEA DX,guideOption          ; Display guidance for user
    INT 21H
    
    MOV AH,01H
    INT 21H
    MOV choice,AL               ; save user's input
    SUB choice,30H              ; Convert ASCII to numerical value
    
    CALL PrintNewLine 
    CALL PrintNewLine 
    RET
MENU ENDP