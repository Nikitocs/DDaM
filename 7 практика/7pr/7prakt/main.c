#include <htc.h>
unsigned int tmpCnt;
void imp(unsigned int cnt,int x){
do{ }while(TF2==0);
TF2 = 0;
if(x==2){
P10 = 1;
}
while (cnt != 0)cnt--;
P10 = 0;
}
void main()
{
int i=1;
tmpCnt = 2100; 
P1 = 0xFE; 
RCAP2H = 0xDC;
RCAP2L = 0xB; 
T2CON &= 0xFC;
ET2 = 1; 
EA = 1; 
T2CON |= 0x4; 
P3=0;
while(1)
{
if(P3==0x1){
tmpCnt = 3000;
}
if(P3==0x2){
tmpCnt = 1900;
}
if(i==2){
imp(tmpCnt,i);
i=1;
}else{
imp(tmpCnt,i);
i++;
}
}
}
