# Exec #
NAME			=	exec

# PATH #
SRCS_DIR		=	srcs
OBJS_DIR		=	objs
INCS_DIR		=	includes
VPATH			=	$(SRCS_DIR):$(OBJS_DIR):$(INCS_DIR)

# File with Path #
SRCS_PATH		=	$(wildcard $(SRCS_DIR)/*.c)
OBJS_PATH		=	$(patsubst $(SRCS_DIR)%,$(OBJS_DIR)%,$(SRCS_PATH:%.c=%.o))
INCS_PATH		=	$(wildcard $(INCS_DIR)/*.h)

# File #
SRCS			=	$(notdir $(SRCS_PATH))
OBJS			=	$(notdir $(OBJS_PATH))
INCS			=	$(notdir $(INCS_PATH))

# Compile #
CC				=	gcc
CFLAGS			=	-Wall -Wextra -Werror
# CVERSION		=
LFLAGS  		=	-I $(INCS_DIR)
CALLF			=	$(CC) $(CFLAGS) $(CVERSION)
CALLFLIB		=	$(CC) $(CFLAGS) $(CVERSION) $(LFLAGS)

# Defauilt Make #
all				:	directories $(NAME)

# Stuff #
$(NAME)			:	$(OBJS_PATH)
	$(CALLFLIB) $(OBJS_PATH) -o $(NAME)

$(OBJS_DIR)/%.o	:	%.c $(INCS)
	$(CALLFLIB) -c $< -o $@

# Make the Directories #
directories		:
	@mkdir -p $(OBJS_DIR)

# Clean obj #
clean			:
	@rm -f $(OBJS_PATH)
	$(info Build done! Cleaning object files...)

# Clean all #
fclean			:	clean
	@rm -rf $(OBJS_DIR)
	@rm -f $(NAME)
	$(info Build done! Cleaning $(NAME) exec...)

re				:	fclean all

.PHONY			:	all fclean clean re directories
