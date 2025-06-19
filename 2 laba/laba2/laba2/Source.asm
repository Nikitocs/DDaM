.686
.model flat,stdcall
.stack 100h
.data
.code
ExitProcess PROTO STDCALL :DWORD
Start:
exit:
Invoke ExitProcess,1
End Start
