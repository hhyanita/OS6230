#ifndef ULIB_H
#define ULIB_H

#include "kernel/types.h"

void* memmove(void *vdst, const void *vsrc, int n);
char* strcpy(char *s, const char *t);
int strcmp(const char *p, const char *q);
unsigned int strlen(const char *s);
void* memset(void *dst, int c, unsigned int n);
char* strchr(const char *s, char c);
char* gets(char *buf, int max);
int stat(const char *n, struct stat *st);
int atoi(const char *s);
int memcmp(const void *s1, const void *s2, unsigned int n);
void* memcpy(void *dst, const void *src, unsigned int n);

#endif
