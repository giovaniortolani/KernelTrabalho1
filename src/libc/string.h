#ifndef _STRING_H_
#define _STRING_H_

#include "stddef.h"

size_t strlen(const char* str1);

char* strcpy(char*, const char*);

int strcmp(const char*, const char*);

void memcpy(void*, const void*, size_t);

#endif
