.686
.model flat,stdcall
.stack 100h

.data
X db 15
Y db 79
Z db 81
result db 0 ;Для хран результата

.code
ExitProcess PROTO STDCALL :DWORD

Start:
;Скложение X и Y
mov al, [X]     ; AL = X
add al, [Y]     ;  AL = X+Y

;Делим результат на 4
mov bl, 4
mov ah, 0		;Обнуляем AH перед делением
div bl			; AX/BL, результат идет в AL, а остаток в AH

mov [result], al ;сохранил 1 часть в result

;Вычисляю Z-Y-X
mov al, [Z]		; AL=Z
sub al, [Y]		; AL=AL-Y
sub al, [X]		; AL=AL-X

;Побитовое or
mov bl, [result]	;Загрузил результат 1 части
or al, bl			; AL=AL or result

;Сохраняю финальный результат в result
mov [result], al

Invoke ExitProcess,0
overflow:
Invoke ExitProcess,1 ; По сути, если произошло переполнение, то возвращ. 1
End Start
