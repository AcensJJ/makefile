#!bin/sh

read -i 'template' -p "What name for your repo?" name
while true;
do
	read -p "What type of file?" ANS
	down=`echo $ANS | tr '[A-Z]' '[a-z]' `
	case $down in 
    'c') 
       file=c
       break;
    'cpp') 
       file=cpp  
       break;
	'c++') 
       file=cpp  
       break;
    *) 
    echo "Wrong type, try again";
	esac
done
read -i 'no' -p "Do you want it with an main?" ANS
main=`echo $ANS | tr '[A-Z]' '[a-z]' `
read -i '.' -p "Where do you want it?" dir
while true;
do
	read -p "It is for be an exec or be a lib?" ANS
	down=`echo $ANS | tr '[A-Z]' '[a-z]' `
	case $down in 
    'lib') 
       compilation=lib
       break;
    'exec') 
       compilation=exec  
       break;
    *) 
    echo "Wrong aswer, try again";
	esac
done

mkdir $name
cp .gitignore-template $name/.gitignore
cp makefile-template $name/makefile

if [ "$compilation" = "lib"]
then
	sed -i 's/##TARGETNAME##/'$name'.a/g' $name/.gitignore
	sed -i 's/##TARGETNAME##/'$name'.a/g' $name/makefile
else
	sed -i 's/##TARGETNAME##/'$name'/g' $name/.gitignore
	sed -i 's/##TARGETNAME##/'$name'/g' $name/makefile
fi

if [ "$file" = "c"]
then
	sed -i 's/##file##/.c/g' $name/makefile
	sed -i 's/##header##/.h/g' $name/makefile
	sed -i 's/##CC##/gcc/g' $name/makefile
else
	sed -i 's/##file##/.cpp/g' $name/makefile
	sed -i 's/##header##/.hpp/g' $name/makefile
	sed -i 's/##CC##/clang++/g' $name/makefile
fi

if [ "$main" = "y" || "$main" = "yes"]
then
	mkdir $name/main
	touch $name/main/main.$file
	rule="$(CALLFLIB) $(OBJS_PATH) $(MAIN_PATH) -o $(NAME)"
	sed -i 's/##MAIN##//g' $name/makefile
	sed -i 's/##MAIN-Y/n##/:$(MAIN_DIR)/g' $name/makefile
else
	rule="$(CALLFLIB) $(OBJS_PATH) $(MAIN_PATH) -o $(NAME)"
	sed -i 's/##MAIN##/#/g' $name/makefile
	sed -i 's/##MAIN-Y/n##//g' $name/makefile
fi

if [ "$compilation" = "lib"]
then
	sed -i 's/##RULENAME##/ar rc $(NAME) $(OBJ); ranlib $(NAME)/g' $name/makefile
else
	sed -i 's/##RULENAME##/'$rule'/g' $name/makefile
fi

# check other .git

mv -rf $name $dir
