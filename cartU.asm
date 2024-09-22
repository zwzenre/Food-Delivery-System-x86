MENU PROC
    ; Display Menu
    MOV AH,09H
    LEA DX,menuTitle
    INT 21h
    
    CALL PrintNewLine
    CALL PrintNewLine

    MOV AH,09H
    LEA DX,header
    INT 21H

    CALL PrintNewLine        

    MOV AH,09H
    LEA DX,dots
    INT 21H

    CALL PrintNewLine

    RET
MENU ENDP

calculate_total_quantity PROC
    push si
    push cx

    lea si, selectionArray
    mov cx, 8    ; number of items
    xor bx, bx

calculate_total_quantity_loop:
    add bx, [si]
    inc si
LOOP calculate_total_quantity_loop
    pop cx
    pop si
    ret
calculate_total_quantity ENDP