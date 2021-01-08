#!/bin/bash

echo -n Please enter a file to see if you own it
read file


if test -O $file
	then 
		echo yay
	else
		echo nay
fi
