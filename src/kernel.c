#include "video.h"
#include "stdlib.h"
#include "register.h"
#include "stdio.h"

int main() {
	video_initVideo();
	video_clearScreen();

	puts("Hello, world!\n");
	printf("ds register: %d\n", get_register_ds());
	printf("cs register: %d\n", get_register_cs());
	printf("ss register: %d\n", get_register_ss());
	
	abort();
}
