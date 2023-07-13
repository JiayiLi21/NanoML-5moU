# NanoML-5moU
NanoML-5moU: A Machine Learning framework to detect 5moU modification in IVT direct RNA sequencing data
![Workflow]( https://github.com/JiayiLi21/NanoML-5moU/blob/main/pics/workflow.png "Github logo") 

## Data collection
Data Sources: https://trace.ncbi.nlm.nih.gov/Traces/index.html?view=study&acc=SRP166020

Raw data used in this project:

5moU modified samples-fast5 file :https://sra-pub-src-1.s3.amazonaws.com/SRZ190756/LUC_5mou_dRNA_fast5.tar.gz.1

normal unmodified samples-fast5 file: https://sra-pub-src-1.s3.amazonaws.com/SRZ190757/LUC_normal_dRNA_fast5.tar.gz.1


## Data preprocessing
### Step1: Base-calling

```
#guppy version  Guppy Basecalling Software, (C) Oxford Nanopore Technologies, Limited. Version 3.0.3+7e7b7d0
#Eligos guppy version 2.3.4

./guppy_basecaller \
-i /home/jiayi/5moU/data/normal/guppy_fast5_q/LUC_normal_dRNA_fast5 \
-s /home/jiayi/5moU/data/normal/guppy_fast5_q/LUC_normal_dRNA_fastq \
--flowcell FLO-MIN106 --kit SQK-RNA002 \
--num_callers 4 --fast5_out \
#--device cuda:1
cat *.fastq > normal_guppy_pass.tar.gz
cat *.fastq > 5mou_guppy_fastq.tar.gz
# indentical processing procedure for normal and 5moU modified samples

# convert multiple fastq files to one fasta file
cd /home/jiayi/5moU/data/5mou/guppy_5mou_fast5_q/LUC_5mou_dRNA_fastq
find -maxdepth 5 -name "*.fastq"|xargs -i awk \
'{if(NR%4 == 1){print ">" substr($0, 2)}}{if(NR%4 == 2){print}}' {} |cat > \

```

### Step2: Alignment
```
minimap2 -ax map-ont -uf -t 3 --secondary=no <MMI> <PATH/TO/FASTQ.GZ> > <PATH/TO/SAM> 2>> <PATH/TO/SAM_LOG>
samtools view -Sb <PATH/TO/SAM> | samtools sort -o <PATH/TO/BAM> - &>> <PATH/TO/BAM_LOG>
samtools index <PATH/TO/BAM> &>> <PATH/TO/BAM_INDEX_LOG>

# for normal
minimap2 -ax map-ont -uf -t 3 --secondary=no /home/jiayi/5moU/data/luciferase.fa  /home/jiayi/5moU/data/normal/guppy_fast5_q/LUC_normal_dRNA_fastq/normal_guppy_fastq.tar.gz  > /home/jiayi/5moU/data/normal/SAM.sam 2>> /home/jiayi/5moU/data/normal/SAM_LOG
samtools view -Sb /home/jiayi/5moU/data/normal/SAM.sam | samtools sort -o /home/jiayi/5moU/data/normal/BAM.bam - &>> /home/jiayi/5moU/data/normal/BAM_LOG
samtools index /home/jiayi/5moU/data/normal/BAM.bam &>> /home/jiayi/5moU/data/normal/BAM_INDEX_LOG

# for 5mou
minimap2 -ax map-ont -uf -t 3 --secondary=no /home/jiayi/5moU/data/luciferase.fa  /home/jiayi/5moU/data/5mou/guppy_5mou_fast5_q/LUC_5mou_dRNA_fastq/5mou_guppy_fastq.tar.gz  > /home/jiayi/5moU/data/5mou/SAM.sam 2>> /home/jiayi/5moU/data/5mou/SAM_LOG
samtools view -Sb /home/jiayi/5moU/data/5mou/SAM.sam | samtools sort -o /home/jiayi/5moU/data/5mou/BAM.bam - &>> /home/jiayi/5moU/data/5mou/BAM_LOG
samtools index /home/jiayi/5moU/data/5mou/BAM.bam &>> /home/jiayi/5moU/data/5mou/BAM_INDEX_LOG
```


### Step3: Re-squiggle
The raw signal from direct RNA sequencing reads was normalized using the median shift and median absolute deviation scale parameters. The segmented signal was determined by identifying a large shift in the current level. The most likely matching between the transcript sequence and the signal was determined using the signal assignment algorithm in Tombo.

```
### Tombo resquiggle
python3 ./ont_fast5_api/ont_fast5_api/conversion_tools/multi_to_single_fast5.py -i /home/jiayi/5moU/data/normal/guppy_fast5_q/LUC_normal_dRNA_fastq/workspace -s /home/jiayi/5moU/data/normal/Tombo_normal/normal_single_fast5 -t 40 --recursive

/home/jiayi/miniconda3/envs/Tombo/bin/tombo resquiggle /home/jiayi/5moU/data/normal/Tombo_normal/normal_single_fast5 /home/jiayi/5moU/data/ref.fa --processes 4 --num-most-common-errors 5 --overwrite --fit-global-scale --include-event-stdev --ignore-read-locks

#h5ls /home/jiayi/5moU/data/normal/Tombo_normal/normal_single_fast5/0/00045de2-6946-4bb7-b361-307cfead9654.fast5 Group
tombo preprocess annotate_raw_with_fastqs --fast5-basedir /home/jiayi/5moU/data/normal/guppy_fast5_q/LUC_normal_dRNA_fast5 --fastq-filenames /home/jiayi/5moU/data/normal/guppy_fast5_q/LUC_normal_dRNA_fastq/normal_guppy_fastq.tar.gz
#h5ls /home/jiayi/5moU/data/normal/Tombo_normal/normal_single_fast5/0/00045de2-6946-4bb7-b361-307cfead9654.fast5
#h5ls -r /home/jiayi/5moU/data/normal/Tombo_normal/normal_single_fast5/0/000d9837-df83-4767-9d17-23154a9e8ad4.fast5
#h5ls -r /home/jiayi/5moU/data/normal/Tombo_normal/normal_single_fast5/1/002e8c79-219d-4697-9c70-b8884a695011.fast5

conda activate Tombo
tombo resquiggle /home/jiayi/5moU/data/normal/Tombo_normal/normal_single_fast5 /home/jiayi/5moU/data/ref.fa --overwrite --basecall-group Basecall_1D_000 --processes 40 --fit-global-scale --include-event-stdev
find  /home/jiayi/5moU/data/normal/Tombo_normal/normal_single_fast5 -name "*.fast5" > /home/jiayi/5moU/data/normal/Tombo_normal/normal_fl_fast5.txt


conda activate base
python tombo_extract_df.py --cpu=20  --fl=/home/jiayi/5moU/data/normal/Tombo_normal/normal_fl_fast5.txt -o /home/jiayi/5moU/data/normal/Tombo_normal/features --clip=10
head  /home/jiayi/5moU/data/normal/Tombo_normal/features.feature.tsv
# similar procedure for the modified samples
```
### Step4:Extract feature matrix for machine learning
https://github.com/JiayiLi21/NanoML-5moU/blob/main/extract_tombo_features.py
