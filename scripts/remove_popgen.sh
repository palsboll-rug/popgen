#!/bin/bash

echo "removing R local environment"
rm .R*
rm -r R

echo "removing course folders"

for folder in $(ls ~ | egrep 'assign*|mini*|prac*');
do
	rm -r ~/$folder;

done

echo "removing popgen folder"

rm -rf popgen

mv ~/.bash_profile_back_up ~/.bash_profile

source .bash_profile
