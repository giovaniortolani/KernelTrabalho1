#include "string.h"
#include "stddef.h"

size_t strlen(const char* str){
	int size = 0;

	while(*str != '\0'){
		str++;
		size++;
	}

	return (size_t)size;
}


char* strcpy(char* str1, const char* str2){
	size_t size = strlen(str2);
	int i = 0;
	
	while(i != (int)size){
		str1[i] = str2[i];
		i++;
	}

	return str1;
}


int strcmp(const char* str1, const char* str2){
	if(strlen(str1) == strlen(str2)){
		while(*str1 && *str2){
			if(*str1 != *str2){
				if(*str1 < *str2) return 1;
				else return -1;			
			}

			*str1++;
			*str2++;
		}

		return 0;
	}

	else if(strlen(str1) > strlen(str2)) return 1;

	return -1;	
}

/*sem testar*/
void memcpy(void* str1, const void* str2, size_t num){
	char* fim = (char*)str1;	
	char* ini = (char*)str2;

	while(num){
		*fim = *ini;
		
		*fim++;
		*ini++;
		num--;
	}	
}
