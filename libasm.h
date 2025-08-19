#ifndef LIBASM_H
# define LIBASM_H

unsigned long ft_strlen(const char *s);
long ft_write(int fd, const void *buff, unsigned long count);
long ft_read(int fd, void *buff, unsigned long count);
char *ft_strcpy(char *dst, const char *src);
int ft_strcmp(const char *s1, const char *s2);
char *ft_strdup(const char *s);

#endif
