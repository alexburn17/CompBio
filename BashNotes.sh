#!/bin/bash
      java -classpath /data/popgen/Trimmomatic-0.33/trimmomatic-0.33.jar org.usadellab.trimmomatic.TrimmomaticPE \
                -threads 1 \
                -phred33 \
                 /data/project_data/fastq/38_6-18_S_2_R1.fq.gz \
                 /data/project_data/fastq/38_6-18_S_2_R2.fq.gz \
                 /data/project_data/fastq/cleanreads/"38_6-18_S_2_R1_clean_paired.fa" \
                 /data/project_data/fastq/cleanreads/"38_6-18_S_2_R1_clean_unpaired.fa" \
                 /data/project_data/fastq/cleanreads/"38_6-18_S_2_R2_clean_paired.fa" \
                 /data/project_data/fastq/cleanreads/"38_6-18_S_2_R2_clean_unpaired.fa" \
                 ILLUMINACLIP:/data/popgen/Trimmomatic-0.33/adapters/TruSeq3-PE.fa:2:30:10 \
                 LEADING:28 \
             TRAILING:28 \
             SLIDINGWINDOW:6:28 \
             HEADCROP:9 \
             MINLEN:35 \



#!/bin/bash
      java -classpath /data/popgen/Trimmomatic-0.33/trimmomatic-0.33.jar org.usadellab.trimmomatic.TrimmomaticPE \
                -threads 1 \
                -phred33 \
                 /data/project_data/fastq/38_6-21_H_0_R1.fq.gz \
                 /data/project_data/fastq/38_6-21_H_0_R2.fq.gz \
                 /data/project_data/fastq/cleanreads/"38_6-21_H_0_R1_clean_paired.fa" \
                 /data/project_data/fastq/cleanreads/"38_6-21_H_0_R1_clean_unpaired.fa" \
                 /data/project_data/fastq/cleanreads/"38_6-21_H_0_R2_clean_paired.fa" \
                 /data/project_data/fastq/cleanreads/"38_6-21_H_0_R2_clean_unpaired.fa" \
                 ILLUMINACLIP:/data/popgen/Trimmomatic-0.33/adapters/TruSeq3-PE.fa:2:30:10 \
                 LEADING:28 \
             TRAILING:28 \
             SLIDINGWINDOW:6:28 \
             HEADCROP:9 \
             MINLEN:35 \
             
             
             
             Save the script by clicking shift + colon    wq

Change settings to get executable run, write, read access:
 





chmod u+x trim_example.sh 



Running the script:
 





./trim_example.sh



Let's take a look in the file.. type  the following and hit tab tab to see what is in it (or go into the cd and then type "ls")

 





cd /data/project_data/fastq/cleanreads/