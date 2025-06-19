
#include <8051.h>

void slovo(char x) { 
	SBUF = x; 
	while(!TI); 
	TI = 0; 
}


void main()
{
	const unsigned char* string;
	int i;
	PCON_BITS.B7 = 0; 
	TMOD_BITS.B6 = 0; 
	TMOD_BITS.B4 = 0; 
	TMOD_BITS.B5 = 1; 
	TH1 = 0x0FA; 
	TR1 = 1; 

	SCON = 0; 
	SCON_BITS.B4 = 0; 
	SCON_BITS.B5 = 1; 
	SCON_BITS.B6 = 1; 
	SCON_BITS.B7 = 0; 
	string = "Pavel "; 

	while (1) {
		for (i = 0; i < 6; i++) {
			slovo(string[i]);
		}
	}

}
