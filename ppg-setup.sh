#!/bin/bash

echo 'Preparing for "Principles of Population Genetics in Natural Populations" course'

echo 'Retrieving files from GitHub'

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

gcc -o ~scripts/microsat_convert ~popgen/microsat_convert.c -lm

cd ~
echo 'Backing up your .bash_profile'

cp ~/.bash_profile ~/.bash_profile_back_up

echo 'Modifying your .bash_profile'
		
echo 'export PATH=/home/$USER/scripts:$PATH' >> ~/.bash_profile

#Need to load R=modules as well
echo 'module load ms Seq-Gen Structure' >> >> ~/.bash_profile

echo 'Resourcing your .bash_profile'

source ~/.bash_profile

echo 'Making certain all scripts can be executed'

chmod 755 ~scripts/*.sh

echo 'DONE!'
