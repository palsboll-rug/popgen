#!/bin/bash

echo "removing R local environment"
rm .R*
rm -r R

echo "removing course folders"

for folder in $(ls ~/popgen | egrep 'assign*|mini*|prac*');
do
	rm -r ~/$folder;

done

echo "removing popgen folder"

rm -r popgen

mv ~/.bash_profile_back_up ~/.bash_profile

source .bash_profile
