#include "video.h"

int main() {
	video_initVideo();
	video_clearScreen();

	video_putString("Hello, world!");
	
	return 0;
}
