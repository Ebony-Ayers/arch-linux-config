echo -n "$1 ("
end=$#
for arg in ${@:2:$end-2}; do
	echo -n "$arg, "
done
echo -n "${!end}): ";
flag=0
while [ $flag -eq 0 ]
do
	read input
	for arg in ${@:2}; do
		if [[ $input = $arg ]]
		then
			echo $arg
			flag=1
			break;
		fi
	done
	if [ $flag -eq 0 ]
	then
		echo -n "Invalid input, try again: "
	else
		break
	fi
done
