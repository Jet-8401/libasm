#ifndef LIBASM_H
# define LIBASM_H

# include <stddef.h>
# include <unistd.h>

size_t ft_strlen(const char *s);
ssize_t ft_write(int fd, const void *buff, size_t count);
ssize_t ft_read(int fd, void *buff, size_t count);
char *ft_strcpy(char *dst, const char *src);
int ft_strcmp(const char *s1, const char *s2);
char *ft_strdup(const char *s);

typedef struct s_list {
	void *data;
	struct s_list *next;
}	t_list;

int ft_list_size(t_list *begin);
void ft_list_push_front(t_list **begin_list, void *data);

#endif
