#include "video.h"

char* const video_ptr = (char* const) VIDEOBUFFER_ADDR;

unsigned char mouseRow;
unsigned char mouseCol;

unsigned char vgaColor;

void video_initVideo() {
	video_setColor(WHITE, BLACK);

	video_moveCursor(0, 0);
	return;
}

void video_clearScreen() {
	unsigned int = 0;
	while (i < VIDEO_ROWS * VIDEO_COLS * 2) {
		video_ptr[i++] = ' ';
		video_ptr[i++] = vgaColor;
	}

	return;
}

void video_setColor(const colors font, const colors bg) {
	vgaColor = font | bg << 4;
	return;
}

void video_putChar(const char character) {
	if (character == '\n') {
		mouseCol = 0;
		++mouseRow;
		return;
	}


	unsigned int index = 2 * ((row * VIDEO_COLS) + col);	
	video_ptr[index] = character;
	video_ptr[index + 1] = vgaColor;

	if (++mouseCol == VIDEO_COLS) {
		mouseCol = 0;
		mouseRow++;
	}

	return;
}

void video_putString(const char* str) {
	unsigned int i = 0;
	while (str[i] != '\0') {
		video_putChar(str[i++]);
	}

	return;
}

void video_moveCursor(const char row, const char col) {
	mouseRow += row;
	mouseRow = mouseRow % VIDEO_ROWS;

	mouseCol += col;
	mouseCol = mouseCol % VIDEO_COLS;
	return;
}
