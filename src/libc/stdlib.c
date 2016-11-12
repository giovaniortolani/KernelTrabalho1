#include "stdlib.h"

void abort(){
	__asm__ __volatile__
	(
	 	//stop kernel
		"hlt\n\t;"	 
	 );
}
