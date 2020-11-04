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
	mv ~/popgen/$folder ~/$older; 

done

#compile own ms.microsat 2 genepop program 

echo "Copying and compiling scripts and helper programs"

gcc -o ~/popgen/scripts/ms_usat_conversion ~/popgen/scripts/ms_usat_conversion.c -lm

echo 'Changing permissions for scripts can be executed'

chmod 755 ~/popgen/scripts/*

echo 'Backing up your .bash_profile'

cp ~/.bash_profile ~/.bash_profile_back_up

echo 'Modifying your .bash_profile'
		
echo 'export PATH=/home/$USER/popgen/scripts:$PATH' >> ~/.bash_profile

#Need to load R=modules as well
echo 'module load ms Structure R/4.0.0-foss-2020a \
		GDAL/3.0.4-foss-2020a-Python-3.8.2' >> ~/.bash_profile

echo '~/popgen/scripts/load_libs.r' >> ~/.bash_profile
echo 'ssh pg-node222' >> ~/.bash_profile

echo 'Resourcing your .bash_profile'

source ~/.bash_profile

#R environment

echo 'Setting up the R environment and installing R packages'

mkdir -fp ~/R/x86_64-pc-linux-gnu-library/4.0
echo 'R_LIBS_USER=R/x86_64-pc-linux-gnu-library/4.0' >> ~/.Renviron

source ~/.Renviron

echo 'cat(".Rprofile: Setting R repository:")
repo = getOption("repos") 
# set up the server from which you will download the package.
repo["CRAN"] = "https://mirror.lyrahosting.com/CRAN" 
options(repos = repo)
rm(repo)' >> ~/.Rprofile

source ~/.Rprofile

#install needed R packages

~/scripts/ppg_setup_install_r_packages.r

echo 'DONE!'