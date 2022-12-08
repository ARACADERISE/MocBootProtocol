//#include "inc.h"

void outb(unsigned short port, char val);
void printstring(char const *val);

//void print_hex_impl(unsigned int num, int nibbles) { for(int i = nibbles - 1; i >= 0; -- i) outb(0xE9, "0123456789ABCDEF"[(num >> (i * 4))&0xF]); }
//#define print_hex(num) print_hex_impl((u64)(num), sizeof((num)) * 2)

void BldrInitBoot(){

    unsigned char* lol = (unsigned char *)0xb8000;
    lol[0] = 's';
    lol[2] = 'x';
    //lol[4] = 'x';

    printstring("Hey");

    while(1);
}

void outb(unsigned short port, char val) {
  asm volatile (
    "outb %1, %0\n"
    : : "dN"(port), "a"(val)
  );
}

void printstring(char const *val) {
  char i = 0;
  unsigned char *vid_mem_buf = (unsigned char *)0xB8000;

  while(*val)
  {
    *vid_mem_buf = *val;
    vid_mem_buf+=2;
    *val++;
  }
}