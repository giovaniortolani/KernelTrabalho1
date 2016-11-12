#include "stdio.h"
#include "../video.h"
#include "string.h"
#include "stdbool.h"
#include "stdarg.h"

void printNumber(int number, int base) {
	int base_pot = 1;

	if (number < 0) {
		putchar('-');
		number = number * -1;
	}

	do {
		base_pot *= base;
	} while (base_pot <= number);
	base_pot /= base;

	int rest = 0;
	int put_num = 0;
	while (base_pot != 0) {
		rest = number % base_pot;
		put_num = (number - rest) / base_pot;
		if (put_num < 10) {
			putchar('0' + put_num);
		} else {
			putchar((put_num - 10) + 'A');
		}

		number = rest;
		base_pot /= base;
	}
}

int putchar(int ch) {
	video_putChar((char) ch);
}

int puts(const char* str) {
	video_putString(str);
}

int printf(const char* format, ...){
	int i, size = 0;
	char op;
	va_list list;
	
	size = strlen(format);	
	putchar('\n');
	printNumber(size, 10);
	putchar('\n');

	va_start(list, format);

	for(i = 0; i < size; i++){
		if(format[i] == '%' && i + 1 <= size){
			op = format[i + 1];
			switch(op){
				case 'c' :
					putchar(va_arg(list, int)); 
					i = i + 2;
					break;

				case 's' :
					puts(va_arg(list, char*));
					i = i + 2;
					break;

				case 'd' :
					printNumber(va_arg(list, int) , 10);
					i = i + 2;
					break;

				case 'x' :
					printNumber(va_arg(list, int) , 16);
					i = i + 2;
					break;

				case 'b' :
					printNumber(va_arg(list, int) , 2);
					i = i + 2;
					break;

				default :
					putchar(format[i++]);
					break;
			}
		} else putchar(format[i]);
	}

	return 1;
}
