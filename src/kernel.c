#include "video.h"
#include "stdlib.h"
#include "register.h"
#include "stdio.h"

int main() {
	video_initVideo();
	video_clearScreen();

	video_putString("Hello, world!");
	video_putChar('\n');
	video_putChar(get_register_ds());
	video_putChar('\n');
	video_putChar(get_register_ss());
	video_putChar('\n');
	video_putChar(get_register_cs());
	video_putChar('\n');
	printNumber(-13);
	
	abort();
}
