//
//  main.c
//  ms_usat_conversion
//
//  Created by Per Palsboll on 24/09/2019.
//  Copyright © 2019 Per Palsbøll. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

int main(int argc, const char * argv[]) {
        
    int     i, j, k, l, n_pops, *n_sub_samples,
            n_tot_samples, n_loci, **genotypes,
            allele_size_offset;
    
    n_pops = atoi(argv[3]);
    n_tot_samples = atoi(argv[1]);
    if (fmod(n_tot_samples, 2) != 0) {
        fprintf(stdout, "\n\tUneven number of total samples - Exiting program");
        fflush(stdout);
        exit(9);
    }
    else {
        n_tot_samples /= 2;
    };

    n_loci = atoi(argv[2]);
    n_sub_samples = (int*)malloc(n_pops*sizeof(int));
    genotypes = (int**)malloc(n_loci*sizeof(int*));
    for(i = 0; i < n_loci; i++) {
        genotypes[i] = (int*)malloc( (2*n_tot_samples)*sizeof(int));
    }
    for(i = 0; i < n_pops; i++) {
        n_sub_samples[i] = atoi(argv[i+4]);
        if (fmod(n_sub_samples[i], 2) != 0) {
            fprintf(stdout, "\n\tUneven number of sample in population %d - Exiting program", i);
            fflush(stdout);
            exit(9);
        }
        else {
            n_sub_samples[i] /= 2;
        };
    }

    for(i = 0; i < n_loci; i++) {
        for(j = 0; j < 2 * n_tot_samples; j++) {
            scanf("%d", &genotypes[i][j]);
            fflush(stdin);
        }
        scanf("\n");
        fflush(stdin);
    }

    for(i = allele_size_offset = 0; i < n_loci; i++) {
        for(j = 0; j < n_tot_samples * 2; j++) {
            if(genotypes[i][j] < allele_size_offset) {
                allele_size_offset = genotypes[i][j];
            }
            else;
        }
    }

    if(allele_size_offset == 0)
        allele_size_offset++;
    else if (allele_size_offset < 0) {
        allele_size_offset *= -1;
        allele_size_offset++;
    }
    else;

    if(strcmp(argv[4 + n_pops], "genepop") == 0) {
        fprintf(stdout,"genepop file produced from ms microsat data\n");
        fflush(stdout);
        for(i = 0; i < n_loci; i++) {
            fprintf(stdout, "locus_%d", i+1);
            if(i < n_loci-1) fprintf(stdout, ",");
            else;
            fflush(stdout);
        }

        for(i = 0, k = 0; i < n_pops; i++) {
            fprintf(stdout, "\nPop");
            fflush(stdout);
            for(j = 0; j < n_sub_samples[i]; j++, k++) {
                fprintf(stdout, "\nPop_%d_sample_%d\t,", i+1, j+1);
                fflush(stdout);
                for(l = 0; l < n_loci; l++) {
                    if( (genotypes[l][k*2] + allele_size_offset) < 10) {
                        fprintf(stdout,"\t00%d", genotypes[l][k*2] + allele_size_offset );
                        fflush(stdout);
                    }
                    else if (   (genotypes[l][k*2] + allele_size_offset) >= 10 &&
                             (genotypes[l][k*2] + allele_size_offset) < 100) {
                        fprintf(stdout,"\t0%d", genotypes[l][k*2] + allele_size_offset);
                        fflush(stdout);
                    }
                    else {
                        fprintf(stdout,"\t%d", genotypes[l][k*2] + allele_size_offset);
                        fflush(stdout);
                    }
                    
                    if( (genotypes[l][(k*2)+1] + allele_size_offset) < 10) {
                        fprintf(stdout,"00%d", genotypes[l][(k*2)+1] + allele_size_offset);
                        fflush(stdout);
                    }
                    else if(    (genotypes[l][(k*2)+1] + allele_size_offset) >= 10 &&
                                (genotypes[l][(k*2)+1] + allele_size_offset) < 100) {
                        fprintf(stdout,"0%d", genotypes[l][(k*2)+1] + allele_size_offset);
                        fflush(stdout);
                    }
                    else {
                        fprintf(stdout,"%d", genotypes[l][(k*2)+1] + allele_size_offset);
                        fflush(stdout);
                    }
                }
            }
        }
    }
    
    if(strcmp(argv[4 + n_pops], "structure") == 0) {

        for(i = 0, k = 0; i < n_pops; i++) {
            for(j = 0; j < n_sub_samples[i]; j++, k++) {
                if(i == 0 && j == 0) {
                    fprintf(stdout, "Pop_%d_sample_%d\t%d\t", i+1, j+1, i+1);
                    fflush(stdout);
                }
                else {
                    fprintf(stdout, "\nPop_%d_sample_%d\t%d\t", i+1, j+1, i+1);
                    fflush(stdout);
                }
                for(l = 0; l < n_loci; l++) {
                        fprintf(stdout,"\t%d", genotypes[l][k*2] + allele_size_offset );
                        fflush(stdout);
                        fprintf(stdout,"\t%d", genotypes[l][(k*2)+1] + allele_size_offset);
                        fflush(stdout);
                }
            }
        }
    }
    

    return 0;
}
