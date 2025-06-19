#include <8051.h>

void main()
{
	while (1) {
	if (P3!=0xC0) {
	P3=0x40;
	P3=0x0;
	}
	P2=P1;
	}
}
