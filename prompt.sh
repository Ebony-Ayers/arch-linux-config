#ask the user a question and and allow multiple output such that each matches a set of valid answers
#param 1: question
#param 2+: valid answers
function promptAnswersMulti(){
	#create the propt string
	local promptMessage="$1 (";
	local end=$#
	for arg in ${@:2:$end-2}; do
		promptMessage="$promptMessage$arg, ";
	done
	promptMessage="$promptMessage${!end}): ";

	promptResult=""
	#loop until a valid input
	#flag to determine if the entire input is valid
	local flag=0
	while [ $flag -eq 0 ]
	do
		read -p "$promptMessage" input
		
		for inputArg in $input; do
			#flag to determine if the current input is valid
			local isInputValid=0;
			for arg in ${@:2}; do
				#if the input matches an argument appent it to the result and set the flags
				if [[ $inputArg = $arg ]]
				then
					promptResult="$promptResult $arg";	#append
					flag=1;								#mark that we have a valid output
					isInputValid=1;						#mark that this input is valid
					break;
				fi
			done
			if [ $isInputValid -eq 0 ]
			then
				flag=0;									#if one input is invalid all inputs are invalid
				break;
			fi
		done
		
		#check if the user has made a valid input reset the output and reset the output
		if [ $flag -eq 0 ]
		then
			promptResult=""
			echo "Invalid input."
			echo
		else
			return 0;
		fi
	done
}

#ask the user a question and make the output match a set of valid answers
#param 1: question
#param 2+: valid answers
function promptAnswersSingle(){
	#create the prompt string
	local promptMessage="$1 (";
	local end=$#
	for arg in ${@:2:$end-2}; do
		promptMessage="$promptMessage$arg, ";
	done
	promptMessage="$promptMessage${!end}): ";

	#flag to defermine if the answer is valid
	local flag=0
	#loop until the answer is valid
	while [ $flag -eq 0 ]
	do
		#check the input against all valid inputs
		read -p "$promptMessage" input
		for arg in ${@:2}; do
			if [[ $input = $arg ]]
			then
				promptResult=$arg;
				flag=1;
				break;
			fi
		done
		if [ $flag -eq 0 ]
		then
			echo "Invalid input."
			echo
		else
			return 0;
		fi
	done
}

#simple yes no question with no clarification
#param 1: prompt message. Should not include a trailing space or colons
#param 2: default answer. options are "y" and "n"
function promptYesNo(){
	local input=""
	if [[ $2 = "y" ]]
	then
		read -p "$1 (Y/n): " input
	else
		read -p "$1 (y/N): " input
	fi
	
	#check for both y, n, yes, and no withcase insensative
	if [[ ${input,,} = "y" ]]
	then
		promptResult="y"
	elif [[ ${input,,} = "yes" ]]
	then
		promptResult="y"
	elif [[ ${input,,} = "n" ]]
	then
		promptResult="n"
	elif [[ ${input,,} = "no" ]]
	then
		promptResult="n"
	#default value
	else
		promptResult=$2
	fi
}

#prompt the user for any input then confirm if it is correct
#param 1: prompt message. Should not include a trailing space or colons
function promptConfirm(){
	#flag to determine if the input is valid
	local flag=0
	#loop until valid input
	while [ $flag -eq 0 ]
	do
		local input=""
		read -p "$1: " input
		promptYesNo "Confirm \"$input\"" n
		if [[ $promptResult = "y" ]]
		then
			promptResult=$input;
			flag=1;
			break;
		else
			echo ""
		fi
	done
}

#prompt the user for a file then confirm if it is correct and the file exists
#param 1: prompt message. Should not include a trailing space or colons
function promptFile(){
	#flag to determine if the input is valid
	local flag=0
	#loop until valid input
	while [ $flag -eq 0 ]
	do
		local input=""
		read -p "$1: " input
		#check if the file exists
		if [ -f "$input" ]
		then
			#confirm the result
			promptYesNo "Confirm \"$input\"" n
			if [[ $promptResult = "y" ]]
			then
				promptResult=$input;
				flag=1;
				break;
			else
				echo ""
			fi
		else
			echo "File \"$input\" does not exist."
			echo ""
		fi
	done
}
