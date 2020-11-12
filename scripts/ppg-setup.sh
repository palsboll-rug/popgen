#!/bin/bash

echo 'Preparing for "Principles of Population Genetics in Natural Populations" course'

echo 'Removing old directories'

for folder in $(ls ~/popgen | egrep 'assign*|mini*|prac*');
do
	rm -r ~/$folder;

done

echo 'Making directories'

for folder in $(ls ~/popgen | egrep 'assign*|mini*|prac*');
do
	mv ~/popgen/$folder ~/$folder;

done

mkdir practical_01 #empty folder not contained in the git repository

#compile own ms.microsat 2 genepop program

echo "Copying and compiling scripts and helper programs"

gcc -o ~/popgen/scripts/ms_usat_conversion ~/popgen/scripts/ms_usat_conversion.c -lm

echo 'Changing permissions for scripts to enable execution'

chmod 755 ~/popgen/scripts/*

echo 'Backing up your .bash_profile'

cp ~/.bash_profile ~/.bash_profile_back_up

echo 'Modifying your .bash_profile'

echo 'export PATH=/home/$USER/popgen/scripts:$PATH' >> ~/.bash_profile

#adding load modules to .bash_profile

echo 'module load ms Structure R VCFtools' >> ~/.bash_profile

#R environment

echo 'Setting up the R environment and installing R packages'

mkdir -p ~/R/x86_64-pc-linux-gnu-library/4.0
mv ~/popgen/scripts/renviron ~/.Renviron

source .Renviron

mv ~/popgen/scripts/rprofile ~/.Rprofile

source .Rprofile

echo 'Resourcing your .bash_profile'

source .bash_profile

#install needed R packages

echo 'Installing needed R packages'
Rscript ~/popgen/scripts/ppg_setup_install_r_packages.r

#echo 'ssh pg-node222' >> ~/.bash_profile
source .bash_profile

echo 'DONE!'
