#!/bin/bash

# if no url was passed in, error out
if [ -z $1 ];
then 
	echo "provide the url you want to minify"
else
	result=`curl --silent https://tinyurl.com/api-create.php?url=$1`
	echo $result | xclip -select clipboard

	echo "$result was copied to your clipboard"
	
fi


