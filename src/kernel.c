#include "video.h"

int main() {
	video_initVide();
	video_clearScreen();

	video_putString("Hello, world!");
	
	return 0;
}
