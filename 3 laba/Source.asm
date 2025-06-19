.686
.model flat,stdcall
.stack 100h
.data
array_start		dd 0.5, 1.0, 0.9 ; Определяет двумерный массив 3x3
				dd 0.1, 2.0, 0.2
				dd 0.3, 4.0, 3.0

array_sin 		dd 0.0, 0.0, 0.0 ; массив 3x3 для хранения синусов
		  		dd 0.0, 0.0, 0.0
		 		dd 0.0, 0.0, 0.0

array_cos 		dd 0.0, 0.0, 0.0 ; массив 3x3 для хранения косинусов
		  		dd 0.0, 0.0, 0.0
		  		dd 0.0, 0.0, 0.0
i dd 0	; счётчик строк
j dd 0	; счётчик столбцов
n dd 3	; размерность массива
temp dd 0.0		; временная переменная
mysize dd 4		; размер ячейки

.code
ExitProcess PROTO STDCALL :DWORD
Start:
	
	finit; ; Инициализация сопроцессора FPU

L1:
	mov j, 0; обнуление счётчика столбцов 
	xor eax, eax;
	xor ebx, ebx;
	xor ecx, ecx;

L2:
	mov eax, n; ;Загрузка размера массива в EAX
	mul i;		;Умножение EAX на текущий индекс строки (i)
	add eax, j; ; Добавление текущего индекса столбца (j) для вычисления линейного индекса
	mul mysize; ; Умножение на размер элемента (4 байта) для получения байтового смещения

	fld array_start[eax]; Загрузка элемента массива array_start в стек FPU. Данные в радианах
	fld array_start[eax];

	fsin;					Вычисление sin
	fstp array_sin[eax];
	fcos;					Вычисление cos
	fstp array_cos[eax];

	inc j;					изменение индекс j, увеличение счетчика
	mov ebx, j;
	mov ecx, n;
	cmp ebx, ecx;			Сравнение счетчика столбцов с размером массива, если не равно - переход на L2
	jne L2;
			
	inc i;					изменение индекс i
	mov ebx, i;
	mov ecx, n;
	cmp ebx, ecx;
	jne L1;

exit:
Invoke ExitProcess,1
End Start
