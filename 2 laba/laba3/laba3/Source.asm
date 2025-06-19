.686 
.model flat, stdcall 
.stack 100h 

.data 
    X   dw 5429h     ; Переменная X (16 бит, значение 5429h)
    Y   dw 7844h     
    Z   dw 0AD43h    
    Q   dw 5622h     
    R   dw 0         ; Результат R (16 бит, инициализирован 0)

.code 
ExitProcess PROTO STDCALL :DWORD 

Start:
    ; Шаг 1: Увеличиваю X,Y,Z,Q на 1 и суммирую
     mov esi, offset X  ; ESI = адрес переменной X в памяти
    mov ecx, 4         ; ECX = 4 (счетчик для цикла по 4 переменным)
    xor ebx, ebx       ; EBX = 0 (здесь будет сумма L)

loop_inc:
    mov ax, [esi]      ; AX = текущее значение переменной (X, Y, Z, Q)
    inc ax             ; Увеличиваю AX на 1 (X+1, Y+1 и т.д.)
    mov [esi], ax      ; Сохраняю новое значение обратно в память
    add bx, ax         ; Добавляю AX к сумме L (BX = BX + AX)
    add esi, 2         ; Переходим к следующей переменной (+2 байта)
    loop loop_inc      ; Повторяю цикл, пока ECX > 0

    ; Шаг 2: Вычисление M = (L & X') - (L & Y')
    mov ax, bx         ; AX = L (сумма из BX)
    and ax, [X]        ; AX = L & X' (побитовое И)
    mov dx, ax         ; Сохраняю результат в DX
    mov ax, bx         ; Снова загружаю L в AX
    and ax, [Y]        ; AX = L & Y'
    sub dx, ax         ; DX = (L & X') - (L & Y') ? M

    ; Выбор подпрограммы в зависимости от M
    cmp dx, 921Bh      ; Сравниваем M с 921Bh
    jae call_sp1       ; Если M >= 921Bh, перехожу к call_sp1
    call subprog2      ; Если M < 921Bh, вызываем subprog2
    jmp check_even     ; Переход к проверке четности R

call_sp1:
    call subprog1      ; Вызываем subprog1

check_even:
    ; Шаг 3: Проверка четности R
    mov ax, [R]        ; Загружаю R в AX
    test ax, 1         ; Проверяю младший бит (0 – четное, 1 – нечетное)
    jz even_r          ; Если четное (ZF=1), переходим к even_r
    jmp odd_r          ; Если нечетное (ZF=0), переходим к odd_r

even_r:
    or ax, 009Fh       ; Побитовое ИЛИ: R = R | 009Fh
    mov [R], ax        ; Сохраняю результат
    jmp ADDR1          ; Переход к метке ADDR1

odd_r:
    dec ax             ; Уменьшаю R на 1: R = R - 1
    mov [R], ax        ; Сохраняю результат
    jmp ADDR2          ; Переход к метке ADDR2

; Подпрограмма 1: R = M/2 - 12B9h
subprog1 PROC
    mov ax, dx         ; AX = M
    shr ax, 1          ; Делим M на 2 (логический сдвиг вправо)
    sub ax, 12B9h      ; Вычитаю 12B9h: AX = M/2 - 12B9h
    mov [R], ax        ; Сохраняем результат в R
    ret                ; Возврат из подпрограммы
subprog1 ENDP

; Подпрограмма 2: R = M - Q'/2
subprog2 PROC
    mov ax, [Q]        ; AX = Q'
    shr ax, 1          ; Делим Q' на 2: AX = Q'/2
    mov bx, dx         ; BX = M
    sub bx, ax         ; BX = M - Q'/2
    mov [R], bx        ; Сохраняем результат в R
    ret                ; Возврат из подпрограммы
subprog2 ENDP

; Метки для переходов (заглушки)
ADDR1:                ; Код для четного R
    jmp exit          ; Переход к завершению

ADDR2:                ; Код для нечетного R
    jmp exit          ; Переход к завершению

exit:
    Invoke ExitProcess, 0 
End Start           
