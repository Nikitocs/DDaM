#include <8051.h>

void delay(unsigned int time) {
    unsigned int i, j;
    for (i = 0; i < time; i++)
        for (j = 0; j < 5; j++);
}

void send_cmd(unsigned char cmd) {
    P0 = cmd;   
    P2 = 0x01;
    P2 = 0x00; 
}

void send_data(unsigned char *dat) {
    P0 = dat;  
    P2 = 0x03; 
    P2 = 0x02; 
}

void vyvod(unsigned char *text){
	unsigned char i, j, len = 0;
	unsigned char *probel=" ";
    unsigned char start_pos = 6;

 while (text[len] != '\0') len++;

    send_cmd(0x80 + 0x40); 
    for (i = 0; i < start_pos; i++) {
        send_data(' ');
    }
    for (i = 0; i < len; i++) {
        send_data(text[i]);
    }
    for (i = start_pos + len; i < 16; i++) {
        send_data(' ');
    }

 }

void scroll_text(unsigned char *text, unsigned int pos) {
    unsigned char len = 0;
	unsigned int  i,j,k;
    while (text[len] != '\0') len++;
	while(1) {
  		j = 0;
  		while (j != 20) {
   			if (j < len) {
    			send_cmd(0x80);
    			//send_cmd(pos);
    			for (i = 0; i < j+1; i++) {
     				send_data(text[len - 1 - j + i]);
    			}
   			}
   			else {
    			send_cmd(pos - len);
    			send_data(" ");
    			for (i = 0; i < len; i++) {
     				send_data(text[i]);
    			}
   			}
   			pos += 1;
   			j += 1;
  		}
  		k = len;
  		while (k != -1) {
   			send_cmd(0x8F - k + len);
   			send_data(" ");
   			for (i = 0; i < k - 1; i++) {
    			send_data(text[i]); 
   			}
   			k -= 1;
  		}
  		// pos = 0x93;
  		pos = 0x80;
 	}
}



void main()
{ 
	unsigned char first[] = {0xB0, 0xA0, 0xA2, 0xA5, 0xAC, 0x00};
	unsigned char second[] = {0xAB, 0xB1, 0xA9, 0xA2, 0xAF, 0xB9, 0xA6, 0xA9, 0xAE, 0x00};
	unsigned int pos = 0x80;
	vyvod(second);
	scroll_text(first, pos);
	while(1);
}