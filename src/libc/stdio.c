#include "stdio.h"
#include "../video.h"

void printNumber(int number, int base) {
	int base_pot = 1;

	if (number < 0) {
		video_putChar('-');
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
			video_putChar('0' + put_num);
		} else {
			video_putChar((put_num - 10) + 'A');
		}

		number = rest;
		base_pot /= base;
	}
}
