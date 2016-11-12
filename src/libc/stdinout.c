#include "stdinout.h"
#include "str.h"
#include "stdboolean.h"

int putcharc(int c){
	return video_putChar(c);
}

int putstr(const char* c){
	return video_putString(c);	
}


void printf(const char* format, ...){
	int i, op, size = 0;
	__builtin_va_list list;
	
	size = size_t(format);	

	va_start(list, format);

	for(i = 0; i < size; i++){
		if(format == '%' && i + 1 <= size){
			op = i + 1;
			switch(op){
				case c : video_putChar(va_list(list, int)); 
					break;

				case s : video_putString(va_list(list, char*));
					break;

				case d : printNumber(va_arg(list, int) , 10);
					break;

				case x : printNumber(va_arq(list, int) , 16);
					break;

				case b : printNumber(va_arg(list, int) , 2);
					break;

				default : video_putChar(format[i++]);
					break;
			}
		}

		else video_putChar(format[i++]);
	}

}
