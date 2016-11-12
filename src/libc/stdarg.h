#ifndef _STDARG_H_
#define _STDARG_H_

typedef __builtin_va_list va_list;

#define va_start(list, param) __builtin_va_start(list, param)

#define va_end(list) __builtin_va_end(list)

#define va_arg(list, type) __builtin_va_arg(list, type)

#endif
