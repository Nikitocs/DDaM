#include <8051.h>

void main(){
	unsigned char i = 0, j = 0, a = 1;
	unsigned char massiv [11] ={
		0xC0,
		0xF9,
		0xA4,
		0xB0,
		0x99,
		0x92,
		0x82,
		0xF8,
		0x80,
		0x90,
		0xFF
	};
	unsigned char massivas [11] ={
		0x90,
		0x90,
		0xF9,
		0xA4,
		0xB0,	
		0x80,
		0x99,
		0x92,
		0x82,
		0xF8,
		0xFF
	};
	P1 = massiv [10];
	P3 = 0;
	i=0;
	
	while (2){
		while(P30==0){
			P2 = massiv[i];
			for(j=0;j<50;j++)
				continue;
			i+=1;
			if (i>9) i=0;
			delay(1);
		}
		while (P30==1){
			P2 = massivas[i];
			for(j=0;j<50;j++)
				continue;
			i+=1;
			if (i>9) i=1;
		delay(1);
			
		}
	}
}