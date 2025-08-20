#ifndef LIBASM_BONUS_H
# define LIBASM_BONUS_H

# include "libasm.h"

int ft_atoi_base(const char *str, const char *base);

typedef struct s_list {
	void *data;
	struct s_list *next;
}	t_list;

int ft_list_size(t_list *begin);
void ft_list_push_front(t_list **begin_list, void *data);
void ft_list_remove_if(
	t_list **begin_list,
	void *data_ref,
	int (*cmp)(void *data, void *data_ref),
	void (*free_fct)(void *)
);

#endif
