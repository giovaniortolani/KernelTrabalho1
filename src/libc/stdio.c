#include "stdio.h"
#include "../video.h"

void printNumber(int number) {
	int dec_pot = 1;

	if (number < 0) {
		video_putChar('-');
		number = number * -1;
	}

	do {
		dec_pot *= 10;
	} while (dec_pot < number);
	dec_pot /= 10;

	int rest = 0;
	int put_num = 0;
	while (dec_pot != 0) {
		rest = number % dec_pot;
		put_num = (number - rest) / dec_pot;
		video_putChar('0' + put_num);

		number = rest;
		dec_pot /= 10;
	}
}
