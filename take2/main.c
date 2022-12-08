typedef unsigned char       uint8;
typedef signed char         int8;
typedef unsigned short      uint16;
typedef signed short        int16;
typedef unsigned int        uint32;
typedef signed int          int32;
typedef unsigned long       size;

typedef uint8               bool;
#define true                1
#define false               0

void hey() {}

void main()
{
    unsigned char *buff = (unsigned char *)0xB8000;
    *buff = 'a';
    
    while(1);
}