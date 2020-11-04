#!/bin/bash

echo 'Preparing for "Principles of Population Genetics in Natural Populations" course'

echo 'Retrieving files from GitHub'

rm -r popgen
git clone https://github.com/palsboll-rug/popgen.git

echo 'Making directories'

rm -r 	/home/$USER/practical_01 /home/$USER/practical_02 \
		/home/$USER/practical_03 /home/$USER/practical_04 \
		/home/$USER/practical_05 /home/$USER/practical_06 \
		/home/$USER/practical_07 \
		/home/$USER/assignment_01 /home/$USER/assignment_02 \
		/home/$USER/scripts		


mkdir 	-p /home/$USER/practical_01 /home/$USER/practical_02 \
		/home/$USER/practical_03 /home/$USER/practical_04/data \
		/home/$USER/practical_05/data /home/$USER/practical_06 \
		/home/$USER/practical_07 \
		/home/$USER/assignment_01 /home/$USER/assignment_02/data \
		/home/$USER/scripts
		

#Need to copy data to practicals and assignments

echo 'Copying data to relevant folders'

cp ~/popgen/assignement_02/* ~/assignment_02/data/
cp ~/popgen/practical_04/* ~/practical_04/data/
cp ~/popgen/practical_05/* ~/practical_05/data/


#compile own ms.microsat 2 genepop program 

gcc -o ~/scripts/microsat_convert ~/popgen/ms_usat_conversion.c -lm

cd ~
echo 'Backing up your .bash_profile'

cp ~/.bash_profile ~/.bash_profile_back_up

echo 'Modifying your .bash_profile'
		
echo 'export PATH=/home/$USER/scripts:$PATH' >> ~/.bash_profile

#Need to load R=modules as well
echo 'module load ms Structure R/4.0.0-foss-2020a \
		GDAL/3.0.4-foss-2020a-Python-3.8.2' >> >> ~/.bash_profile

echo 'ssh pg-node222' >> >> ~/.bash_profile

echo 'Resourcing your .bash_profile'

source ~/.bash_profile

echo "Copying and compiling scripts and helper programs"

cp ~/popgen/scripts/ppg_setup_install_r_packages.r ~/scripts/ppg_setup_install_r_packages.r
gcc -o ~/scripts/ms_usat_conversion ~/popgen/scripts/ms_usat_conversion.c -lm

echo 'Changing permissions for scripts can be executed'

chmod 755 ~scripts/*

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
