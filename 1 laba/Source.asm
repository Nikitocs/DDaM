.686
.model flat,stdcall
.stack 100h

.data
X db 15
Y db 79
Z db 81
result db 0 ;��� ���� ����������

.code
ExitProcess PROTO STDCALL :DWORD

Start:
;��������� X � Y
mov al, [X]     ; AL = X
add al, [Y]     ;  AL = X+Y

;����� ��������� �� 4
mov bl, 4
mov ah, 0		;�������� AH ����� ��������
div bl			; AX/BL, ��������� ���� � AL, � ������� � AH

mov [result], al ;�������� 1 ����� � result

;�������� Z-Y-X
mov al, [Z]		; AL=Z
sub al, [Y]		; AL=AL-Y
sub al, [X]		; AL=AL-X

;��������� or
mov bl, [result]	;�������� ��������� 1 �����
or al, bl			; AL=AL or result

;�������� ��������� ��������� � result
mov [result], al

Invoke ExitProcess,0
overflow:
Invoke ExitProcess,1 ; �� ����, ���� ��������� ������������, �� �������. 1
End Start
