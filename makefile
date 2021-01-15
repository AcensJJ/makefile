# Exec #
NAME			=	##TARGETNAME##

# PATH #
# MAIN_DIR		=	main
SRCS_DIR		=	srcs
OBJS_DIR		=	objs
INCS_DIR		=	includes
VPATH			=	$(SRCS_DIR):$(OBJS_DIR):$(INCS_DIR)#:$(MAIN_DIR)

# File with Path #
# MAIN_PATH		=	$(MAIN_DIR)/main.c
SRCS_PATH		=	$(wildcard $(SRCS_DIR)/*.c)
OBJS_PATH		=	$(patsubst $(SRCS_DIR)%,$(OBJS_DIR)%,$(SRCS_PATH:%.c=%.o))
INCS_PATH		=	$(wildcard $(INCS_DIR)/*.h)

# File #
# MAIN			=	main.##file##
SRCS			=	$(patsubst $(SRCS_DIR)/%,%,$(SRCS_PATH))
OBJS			=	$(patsubst $(SRCS_DIR)/%,%,$(OBJS_PATH))
INCS			=	$(patsubst $(INCS_DIR)/%,%,$(INCS_PATH))

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
$(NAME)			:	$(OBJS_PATH) #$(MAIN_DIR)
	$(CALLFLIB) $(OBJS_PATH) -o $(NAME) # || # $(CALLFLIB) $(OBJS_PATH) $(MAIN_PATH) -o $(NAME)

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
