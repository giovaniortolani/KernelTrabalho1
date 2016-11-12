#include "video.h"
#include "stdlib.h"
#include "register.h"
#include "stdio.h"

int main() {
	video_initVideo();
	video_clearScreen();

	puts("Hello, world!");
	putchar('\n');	
	putchar(get_register_ds());
	putchar('\n');	
	putchar(get_register_ss());
	putchar('\n');	
	putchar(get_register_cs());
	puts("\nTudo ok");
	
	abort();
}
