#include "stdio.h"
#include "../video.h"

void printNumber(int number, int base) {
	int base_port = 1;

	if (number < 0) {
		video_putChar('-');
		number = number * -1;
	}

	do {
		base_port *= base;
	} while (base_port < number);
	base_port /= base;

	int rest = 0;
	int put_num = 0;
	while (base_port != 0) {
		rest = number % base_port;
		put_num = (number - rest) / base_port;
		video_putChar('0' + put_num);

		number = rest;
		base_port /= base;
	}
}
