#include <8051.h>

void msec(int x) {
    while (x-- > 0) {
        TH0 = (-10000) >> 8;
        TL0 = -10000;
        TR0 = 1;
        do;
        while (TF0 == 0);
        TF0 = 0;
        TR0 = 0;
    }
}

void main() {
    TMOD = 0x1;
    
    while (1) { 
        P1 = 0x04;    
        msec(100);
        
        P1 = 0x20;    
        msec(100);
        
        P1 = 0x08 + 0x10;  
        msec(300);
        
        P1 = 0x02 + 0x40;  
        msec(500);
        
        P1 = 0x01 + 0x80;  
        msec(700);
        
        P1 = 0x0;  
        msec(100); 
    }
}