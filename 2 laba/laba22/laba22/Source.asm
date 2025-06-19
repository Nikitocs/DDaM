.686 
.model flat, stdcall 
.stack 100h 

.data 
    X   dw 5429h     ; ���������� X (16 ���, �������� 5429h)
    Y   dw 7844h     
    Z   dw 0AD43h    
    Q   dw 5622h     
    R   dw 0         ; ��������� R (16 ���, ��������������� 0)

.code 
ExitProcess PROTO STDCALL :DWORD 

Start:
    ; ��� 1: ����������� X,Y,Z,Q �� 1 � ���������
    mov esi, offset X  ; ESI = ����� ���������� X � ������
    mov ecx, 4         ; ECX = 4 (������� ��� ����� �� 4 ����������)
    xor ebx, ebx       ; EBX = 0 (����� ����� ����� L)

loop_inc:
    mov ax, [esi]      ; AX = ������� �������� ���������� (X, Y, Z, Q)
    inc ax             ; ����������� AX �� 1 (X+1, Y+1 � �.�.)
    mov [esi], ax      ; ��������� ����� �������� ������� � ������
    add bx, ax         ; ��������� AX � ����� L (BX = BX + AX)
    add esi, 2         ; ��������� � ��������� ���������� (+2 �����)
    loop loop_inc      ; ��������� ����, ���� ECX > 0

    ; ��� 2: ���������� M = (L & X') - (L & Y')
    mov ax, bx         ; AX = L (����� �� BX)
    and ax, [X]        ; AX = L & X' (��������� �)
    mov dx, ax         ; ��������� ��������� � DX
    mov ax, bx         ; ����� ��������� L � AX
    and ax, [Y]        ; AX = L & Y'
    sub dx, ax         ; DX = (L & X') - (L & Y') ? M

    ; ����� ������������ � ����������� �� M
    cmp dx, 921Bh      ; ���������� M � 921Bh
    jae call_sp1       ; ���� M >= 921Bh, ��������� � call_sp1
    call subprog2      ; ���� M < 921Bh, �������� subprog2
    jmp check_even     ; ������� � �������� �������� R

call_sp1:
    call subprog1      ; �������� subprog1

check_even:
    ; ��� 3: �������� �������� R
    mov ax, [R]        ; ��������� R � AX
    test ax, 1         ; ��������� ������� ��� (0 � ������, 1 � ��������)
    jz even_r          ; ���� ������ (ZF=1), ��������� � even_r
    jmp odd_r          ; ���� �������� (ZF=0), ��������� � odd_r

even_r:
    or ax, 009Fh       ; ��������� ���: R = R | 009Fh
    mov [R], ax        ; ��������� ���������
    jmp ADDR1          ; ������� � ����� ADDR1

odd_r:
    dec ax             ; ��������� R �� 1: R = R - 1
    mov [R], ax        ; ��������� ���������
    jmp ADDR2          ; ������� � ����� ADDR2

; ������������ 1: R = M/2 - 12B9h
subprog1 PROC
    mov ax, dx         ; AX = M
    shr ax, 1          ; ����� M �� 2 (���������� ����� ������)
    sub ax, 12B9h      ; �������� 12B9h: AX = M/2 - 12B9h
    mov [R], ax        ; ��������� ��������� � R
    ret                ; ������� �� ������������
subprog1 ENDP

; ������������ 2: R = M - Q'/2
subprog2 PROC
    mov ax, [Q]        ; AX = Q'
    shr ax, 1          ; ����� Q' �� 2: AX = Q'/2
    mov bx, dx         ; BX = M
    sub bx, ax         ; BX = M - Q'/2
    mov [R], bx        ; ��������� ��������� � R
    ret                ; ������� �� ������������
subprog2 ENDP

; ����� ��� ��������� (��������)
ADDR1:                ; ��� ��� ������� R
    jmp exit          ; ������� � ����������

ADDR2:                ; ��� ��� ��������� R
    jmp exit          ; ������� � ����������

exit:
    Invoke ExitProcess, 0 
End Start           
