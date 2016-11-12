#include "video.h"
#include "stdlib.h"

int main() {
	video_initVideo();
	video_clearScreen();

	video_putString("Hello, world!");
	
	abort();
}
