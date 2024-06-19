.text
    global _start

_start:

    ; Read input from user
    mov eax, 3     ; Sets up a sys_read system call (system call number 3).
    mov ebx, 0     ; Specifies file descriptor 0 (standard input).
    mov ecx, input ; Points ecx to the input buffer.
    mov edx, 30    ; Increase to match buffer size
    int 80h        ; Executes the system call (reads user input into input buffer).

    ; Convert string to integer
    mov esi, input      ; ESI points to the start of input
    call convertToInt
    mov [num1], eax
    
    call NextInt
    call convertToInt
    mov [num2], eax
    
    call NextInt
    call convertToInt
    mov [opCode], eax
    
    mov eax, [num1]
    mov esi, str_buffer
    call IntegerToString
    mov [num1Str],eax
    
    mov eax, [num2]
    mov esi, str_buffer
    call IntegerToString
    mov [num2Str],eax

    mov eax, [opCode]
    mov esi, str_buffer
    call IntegerToString
    mov [opStr],eax
    
    mov eax, [opCode]
    cmp eax, 1
    je func_Max
    cmp eax, 2
    je func_Gcd
    jmp func_Lcm

exit:
    mov eax, 1
    xor ebx, ebx
    int 80h

func_Max:
    mov eax, [num1]
    mov ebx, [num2]
    cmp eax, ebx
    jg .Num1Greater
    mov [num3], ebx
    jmp .printResult
    .Num1Greater:
      mov [num3], eax
      jmp .printResult
    .printResult:
        mov ecx, FunctionFormat
        call strLen
        mov edx, eax    ; Length of string to print
        mov eax, 4
        mov ebx, 1
        mov ecx, FunctionFormat
        int 80h
    
        mov ecx, [opStr]
        call strLen
        mov edx, eax    ; Length of string to print
        mov eax, 4
        mov ebx, 1
        mov ecx, [opStr]
        int 80h
    
        mov ecx, MaxFormat1
        call strLen
        mov edx, eax
        mov eax, 4
        mov ebx, 1
        mov ecx, MaxFormat1
        int 80h
    
        mov eax, [num1]
        mov esi, str_buffer
        call IntegerToString
        xor edx, edx
        mov edx, ecx
        mov ecx, eax
        mov eax, 4
        mov ebx, 1
        int 80h
    
        mov ecx, AndFormat
        call strLen
        mov edx, eax
        mov eax, 4
        mov ebx, 1
        mov ecx, AndFormat
        int 80h
    
        mov eax, [num2]
        mov esi, str_buffer
        call IntegerToString
        xor edx, edx
        mov edx, ecx
        mov ecx, eax
        mov eax, 4
        mov ebx, 1
        int 80h 
    
        mov ecx, IsFormat
        call strLen
        mov edx, eax
        mov eax, 4
        mov ebx, 1
        mov ecx, IsFormat
        int 80h
        
        mov eax, [num3]
        mov esi, str_buffer
        call IntegerToString
        xor edx, edx
        mov edx, ecx
        mov ecx, eax
        mov eax, 4
        mov ebx, 1
        int 80h
        jmp exit
  
func_Lcm:
    mov eax, [num1]  ; Load first number into eax
    mov ebx, [num2]  ; Load second number into ebx
    call compute_gcd ; Call function to compute gcd
    ; Compute LCM: abs(ecx * ebx) / eax
    mov ecx, eax
    mov eax, [num1]
    mov ebx, [num2]
    imul eax, ebx    ; Multiply original numbers
    xor edx, edx
    div ecx         ; Divide by GCD
    mov [num3], eax  ; Store result in num3
    jmp .printResult
    .printResult:
        mov ecx, FunctionFormat
        call strLen
        mov edx, eax    ; Length of string to print
        mov eax, 4
        mov ebx, 1
        mov ecx, FunctionFormat
        int 80h
    
        mov ecx, [opStr]
        call strLen
        mov edx, eax    ; Length of string to print
        mov eax, 4
        mov ebx, 1
        mov ecx, [opStr]
        int 80h
    
        mov ecx, LcmFormat1
        call strLen
        mov edx, eax
        mov eax, 4
        mov ebx, 1
        mov ecx, LcmFormat1
        int 80h
    
        mov eax, [num1]
        mov esi, str_buffer
        call IntegerToString
        xor edx, edx
        mov edx, ecx
        mov ecx, eax
        mov eax, 4
        mov ebx, 1
        int 80h
    
        mov ecx, AndFormat
        call strLen
        mov edx, eax
        mov eax, 4
        mov ebx, 1
        mov ecx, AndFormat
        int 80h
    
        mov eax, [num2]
        mov esi, str_buffer
        call IntegerToString
        xor edx, edx
        mov edx, ecx
        mov ecx, eax
        mov eax, 4
        mov ebx, 1
        int 80h 
    
        mov ecx, IsFormat
        call strLen
        mov edx, eax
        mov eax, 4
        mov ebx, 1
        mov ecx, IsFormat
        int 80h
        
        mov eax, [num3]
        mov esi, str_buffer
        call IntegerToString
        xor edx, edx
        mov edx, ecx
        mov ecx, eax
        mov eax, 4
        mov ebx, 1
        int 80h
        jmp exit

func_Gcd:
    mov eax, [num1]  ; Load first number into eax
    mov ebx, [num2]  ; Load second number into ebx
    call compute_gcd ; Call function to compute gcd
    mov [num3], eax
    jmp .printResult
    .printResult:
        mov ecx, FunctionFormat
        call strLen
        mov edx, eax    ; Length of string to print
        mov eax, 4
        mov ebx, 1
        mov ecx, FunctionFormat
        int 80h
    
        mov ecx, [opStr]
        call strLen
        mov edx, eax    ; Length of string to print
        mov eax, 4
        mov ebx, 1
        mov ecx, [opStr]
        int 80h
    
        mov ecx, GcdFormat1
        call strLen
        mov edx, eax
        mov eax, 4
        mov ebx, 1
        mov ecx, GcdFormat1
        int 80h
    
        mov eax, [num1]
        mov esi, str_buffer
        call IntegerToString
        xor edx, edx
        mov edx, ecx
        mov ecx, eax
        mov eax, 4
        mov ebx, 1
        int 80h
    
        mov ecx, AndFormat
        call strLen
        mov edx, eax
        mov eax, 4
        mov ebx, 1
        mov ecx, AndFormat
        int 80h
    
        mov eax, [num2]
        mov esi, str_buffer
        call IntegerToString
        xor edx, edx
        mov edx, ecx
        mov ecx, eax
        mov eax, 4
        mov ebx, 1
        int 80h 
    
        mov ecx, IsFormat
        call strLen
        mov edx, eax
        mov eax, 4
        mov ebx, 1
        mov ecx, IsFormat
        int 80h
        
        mov eax, [num3]
        mov esi, str_buffer
        call IntegerToString
        xor edx, edx
        mov edx, ecx
        mov ecx, eax
        mov eax, 4
        mov ebx, 1
        int 80h
        jmp exit

convertToInt:
    xor eax, eax        ; Clear EAX for storing result
    .Loop:
        movzx ebx, byte [esi]  ; Move one byte of input into EBX
        test ebx, ebx          ; Test if byte is null terminator (end of string)
        jz .end
        cmp ebx, ' '             ; Check if the character is a whitespace
        je .end      ; If whitespace, jump to skip_character
        sub ebx, '0'           ; Convert ASCII to integer (subtract ASCII value of '0')
        imul eax, eax, 10      ; Multiply current result by 10 (shift left by one decimal place)
        add eax, ebx           ; Add new digit to result
        inc esi
        jmp .Loop
    .end:
        ret

IntegerToString:
    ;xor edi, edi
    xor ecx, ecx
    add esi, 9
    mov byte [esi], 0  ; String terminator
    mov ebx, 10
    .next_digit:
        xor edx, edx        ; Clear edx prior to dividing edx:eax by ebx
        div ebx             ; eax /= 10
        add dl, '0'         ; Convert the remainder to ASCII 
        dec esi            ; store characters in reverse order
        mov [esi], dl
        inc ecx
        test eax, eax
        jnz .count    ; Repeat until eax==0
        ; return a pointer to the first digit (not necessarily the start of the provided buffer)
        mov eax, esi
        ret
    .count:
        ;inc edi
        jmp .next_digit

strLen:
    xor eax,eax ; count = 0
    jmp .overit
.looptop:
    inc ecx
    inc eax
.overit:
    cmp byte[ecx],0
    jnz .looptop
    ret

NextInt:
    .loop:
        movzx ebx, byte [esi]
        test ebx, ebx
        jz .end
        cmp ebx, ' '
        je .skipSpace
        inc esi
        jmp .end
    .skipSpace:
        inc esi
        jmp .end
    .end:
        ret 

compute_gcd:
    ; Check if ebx is 0
    test ebx, ebx
    jz .gcd_done  ; if ebx is 0, gcd is in eax
    ; Perform modulo operation
    xor edx, edx
    div ebx
    ; Swap numbers: new_a = b, new_b = a % b
    mov eax, ebx
    mov ebx, edx
    ; Repeat
    jmp compute_gcd

    .gcd_done:
        ret

section .bss
    input resb 30
    numStrSize equ 10
    num1 resd 4
    num2 resd 4
    opCode resd 4
    num3 resd 4
    num1Str resb 1
    num2Str resb 1
    opStr resb 1
    str_buffer resb numStrSize
    ResultStrLen resd 4

section .data
    FunctionFormat: db 'Function ',0
    LcmFormat1: db ': least common multiply of ',0
    AndFormat: db ' and ',0
    IsFormat: db ' is ',0
    FullStopFormat: db '.',0
    MaxFormat1: db ': maximum of ',0
    GcdFormat1: db ': greatest common divider of ',0