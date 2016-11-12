#ifndef __VIDEO_H__
#define __VIDEO_H__

#define VIDEOBUFFER_ADDR 0xB8000
#define VIDEO_COLS 80
#define VIDEO_ROWS 24

enum colors {
	BLACK,
	BLUE,
	GREEN,
	CYAN,
	RED,
	MAGENTA,
	BROWN,
	LIGHT_GREY,
	DARK_GREY,
	LIGHT_BLUE,
	LIGHT_GREEN,
	LIGHT_CYAN,
	LIGHT_RED,
	LIGHT_MAGENTA,
	LIGHT_BROWN,
	WHITE
};

void video_initVideo();
void video_clearScreen();

void video_setColor(const colors font, const colors background);
void video_putChar(const char character);
void video_putString(const char* str);

void video_moveCursor(const char row, const char col);

#endif
