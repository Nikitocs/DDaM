#include <8051.h>

void main() {	
    unsigned int i, j;
	unsigned int size_str2 = 6;
    unsigned char *str = "DCBA#9630852*741"; 
	unsigned char *str2="Hello!";
	unsigned int row1code, row2code, row3code, row4code;

    P0 = 0x38; //komanda LCD display
    P2 = 0x1;  //port P2
    P2 = 0x0;  // port P2 zaverchenye
    
    P0 = 0x80;
    P2 = 0x1;
    P2 = 0x0;

    while(1) {
        i = -1;

		P1 = 0xEF;
		row1code = P1;
		P1 = 0xDF;
		row2code = P1;
		P1 = 0xBF;
		row3code = P1;
		P1 = 0x7F;
		row4code = P1;

		if (row1code == 0xEE && row2code == 0xDE && row3code == 0xBE && row4code == 0x7E) {
			for (j = 0; j < size_str2; j++) {
				P0 = str2[i]; 
            	P2 = 0x3;     
            	P2 = 0x2; 
			}
		} else {
			P1 = 0xEF;
        	if (P1 == 0xEE) i = 15;
        	if (P1 == 0xED) i = 14;
        	if (P1 == 0xEB) i = 13;
        	if (P1 == 0xE7) i = 12;
	
        	P1 = 0xDF; 
        	if (P1 == 0xDE) i = 11;
        	if (P1 == 0xDD) i = 10;
        	if (P1 == 0xDB) i = 9;
        	if (P1 == 0xD7) i = 8;
	
        	P1 = 0xBF; 
        	if (P1 == 0xBE) i = 7;
        	if (P1 == 0xBD) i = 6;
        	if (P1 == 0xBB) i = 5;
        	if (P1 == 0xB7) i = 4;
	
        	P1 = 0x7F; 
        	if (P1 == 0x7E) i = 3;
        	if (P1 == 0x7D) i = 2;
        	if (P1 == 0x7B) i = 1;
        	if (P1 == 0x77) i = 0;
	
        	if (i != -1) {
            	P0 = str[i]; 
            	P2 = 0x3;     
            	P2 = 0x2; 
        	}
		}
    }
}