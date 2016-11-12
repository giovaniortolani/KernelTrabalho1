#include "register.h"

int get_register_cs(){
	int cs = 0;
	__asm__ __volatile__
	(
	 	"movw %%cs, %%ax\n\t;"	 	
		: "=a"(cs)
	);

	return cs;
}

int get_register_ss(){
	int ss = 0;
	__asm__ __volatile__
	(
	 	"movw %%ss, %%ax\n\t;"	 	
		: "=a"(ss)
	);

	return ss;
}

int get_register_ds(){
	int ds = 0;
	__asm__ __volatile__
	(
	 	"movw %%ds, %%ax\n\t;"	 	
		: "=a"(ds)
	);

	return ds;
}
