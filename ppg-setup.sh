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


mkdir 	/home/$USER/practical_01 /home/$USER/practical_02 \
		/home/$USER/practical_03 /home/$USER/practical_04 \
		/home/$USER/practical_05 /home/$USER/practical_06 \
		/home/$USER/practical_07 \
		/home/$USER/assignment_01 /home/$USER/assignment_02 \
		/home/$USER/scripts
		

#Need to copy data to practicals

gcc -o ~scripts/microsat_convert ~popgen/ms_usat_conversion.c -lm

cd ~
echo 'Backing up your .bash_profile'

cp ~/.bash_profile ~/.bash_profile_back_up

echo 'Modifying your .bash_profile'
		
echo 'export PATH=/home/$USER/scripts:$PATH' >> ~/.bash_profile

#Need to load R=modules as well
echo 'module load ms Seq-Gen Structure R' >> >> ~/.bash_profile
echo 'pg-node222' >> >> ~/.bash_profile

echo 'Resourcing your .bash_profile'

source ~/.bash_profile

echo 'Making certain all scripts can be executed'

chmod 755 ~scripts/*.sh

#R environment

mkdir ~/R/x86_64-pc-linux-gnu-library/4.0
echo 'R_LIBS_USER=R/x86_64-pc-linux-gnu-library/4.0' >> ~/.Renviron

source ~/.Renviron

echo 'cat(".Rprofile: Setting R repository:")
repo = getOption("repos") 
# set up the server from which you will download the package.
repo["CRAN"] = "https://mirror.lyrahosting.com/CRAN" 
options(repos = repo)
rm(repo)' >> ~/.Rprofile

source ~/.Rprofile

echo 'DONE!'
