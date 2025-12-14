.MODEL SMALL
.STACK 100H
.DATA
    MSG1 DB 'Enter A Hexadecimal Number (0-FFFF) : $'
    MSG2 DB 0DH,0AH, 'Decimal : $'
    NUM DW 0
    TEN DW 10
                                           
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    CALL INPUT       ; Get hexadecimal input
    CALL CONVERSION  ; Convert to decimal (in this case, just prepares for output)
    CALL OUTPUT      ; Display decimal result
    
    MOV AH, 4CH
    INT 21H
MAIN ENDP

INPUT PROC
    ; Display input prompt
    LEA DX, MSG1
    MOV AH, 09H
    INT 21H
    
    MOV NUM, 0       ; Initialize number
    
READ_HEX:
    ; Read a character
    MOV AH, 01H
    INT 21H
    
    ; Check for Enter key
    CMP AL, 0DH
    JE INPUT_DONE
    
    ; Convert ASCII to number
    SUB AL, 30H
    CMP AL, 9
    JLE DIGIT
    
    ; Convert A-F
    SUB AL, 7
    
DIGIT:
    ; Build number
    MOV AH, 0
    MOV BX, AX
    
    MOV AX, NUM
    MOV CL, 4
    SHL AX, CL      ; Shift left by 4 bits
    
    ADD AX, BX      ; Add new digit
    MOV NUM, AX
    
    JMP READ_HEX
    
INPUT_DONE:
    RET
INPUT ENDP

CONVERSION PROC
    ; In this case, conversion is handled during input
    ; This procedure is included for modularity
    RET
CONVERSION ENDP

OUTPUT PROC
    ; Display output message
    LEA DX, MSG2
    MOV AH, 09H
    INT 21H
    
    ; Load number for printing
    MOV AX, NUM
    
    ; Save registers
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    MOV CX, 0       ; Initialize digit counter
    
DIVIDE:
    MOV DX, 0
    DIV TEN         ; Divide by 10
    PUSH DX         ; Save remainder (digit)
    INC CX          ; Count digits
    
    CMP AX, 0       ; Check if done
    JNE DIVIDE
    
PRINT_DIGITS:
    POP DX          ; Get digit
    ADD DL, 30H     ; Convert to ASCII
    MOV AH, 02H     ; Print character
    INT 21H
    LOOP PRINT_DIGITS
    
    ; Restore registers
    POP DX
    POP CX
    POP BX
    POP AX
    RET
OUTPUT ENDP

END MAIN