NAME = libasm.a
SRC =	ft_strlen.s \
		ft_write.s \
		ft_read.s \
		ft_strcpy.s \
		ft_strcmp.s \
		ft_strdup.s \
		includes/ft_set_errno.s

OBJ = $(SRC:.s=.o)

BONUS_SRC = ft_list_size_bonus.s \
		    ft_list_push_front_bonus.s \
		    ft_list_remove_if_bonus.s \
			ft_atoi_base_bonus.s

BONUS_OBJ = $(BONUS_SRC:.s=.o)

CC = gcc
AS = nasm
ASFLAGS = -f elf64 -I includes/

.PHONY: all clean fclean re

all: $(NAME)

bonus: $(OBJ) $(BONUS_OBJ)
	ar rcs $(NAME) $^

$(NAME): $(OBJ)
	ar rcs $@ $^

%.o: %.s
	$(AS) $(ASFLAGS) $< -o $@

clean:
	rm -f $(OBJ) $(BONUS_OBJ)

fclean: clean
	rm -f $(NAME)

re: fclean all
