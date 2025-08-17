NAME = libasm.a
SRC =	ft_strlen.s \
		ft_write.s \
		ft_read.s \
		ft_strcpy.s \
		ft_strcmp.s \
		ft_strdup.s \
		ft_list_size.s \
		ft_list_push_front.s \
		ft_atoi_base.s \
		includes/ft_set_errno.s
OBJ = $(SRC:.s=.o)

CC = gcc
AS = nasm
ASFLAGS = -f elf64 -I includes/

.PHONY: all clean fclean re

all: $(NAME)

$(NAME): $(OBJ)
	ar rcs $@ $^

%.o: %.s
	$(AS) $(ASFLAGS) $< -o $@

clean:
	rm -f $(OBJ)

fclean: clean
	rm -f $(NAME)

re: fclean all
