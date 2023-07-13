### download data from Eligos
cd /home/jiayi/5moU/data/normal
wget https://sra-pub-src-1.s3.amazonaws.com/SRZ190757/LUC_normal_dRNA_fast5.tar.gz.1

cd /home/jiayi/5moU/data/5mou
wget https://sra-pub-src-1.s3.amazonaws.com/SRZ190756/LUC_5mou_dRNA_fast5.tar.gz.1

# Parallelizing Downloads with wget
# tar the files to directory
# wrong :tar -czvf filename.tar.gz /path/to/dir1
# list content tar -tf archive.tar.gz
tar -tf LUC_5mou_dRNA_fast5.tar.gz
tar -tf LUC_normal_dRNA_fast5.tar.gz
#tar -zxvf pro.tar.gz -C /home/wwwroot/project
tar -zxvf LUC_normal_dRNA_fast5.tar.gz  -C /home/jiayi/5moU/data/normal/IVT_normalU_fast5
tar -zxvf LUC_5mou_dRNA_fast5.tar.gz -C /home/jiayi/5moU/data/5mou/IVT_5mou_fast5




### basecall using guppy
#guppy version  Guppy Basecalling Software, (C) Oxford Nanopore Technologies, Limited. Version 3.0.3+7e7b7d0
#Eligos guppy version 2.3.4

"""
2023-03-18 10:16:27.341139 [guppy/message] ONT Guppy basecalling software version 3.0.3+7e7b7d0
config file:        /home/yuxin/ont-guppy-cpu/data/rna_r9.4.1_70bps_hac.cfg
model file:         /home/yuxin/ont-guppy-cpu/data/template_rna_r9.4.1_70bps_hac.jsn
input path:         /home/jiayi/5moU/data/normal/guppy_fast5_q/LUC_normal_dRNA_fast5
save path:          /home/jiayi/5moU/data/normal/guppy_fast5_q/LUC_normal_dRNA_fastq
chunk size:         1000
chunks per runner:  1000
records per file:   4000
num basecallers:    4
cpu mode:           ON
threads per caller: 1

****[guppy/error] main: Exception thrown in ParallelCaller worker thread: Exception thrown in BasecallWriter worker thread:
Basecall data read-id does not match any assigned to this object.


"""

/home/yuxin/ont-guppy-cpu/bin/guppy_basecaller
/home/yuxin/ont-guppy-cpu/bin/guppy_basecaller \
-i /home/jiayi/5moU/data/normal/guppy_fast5_q/LUC_normal_dRNA_fast5 \
-s /home/jiayi/5moU/data/normal/guppy_fast5_q/LUC_normal_dRNA_fastq \
--flowcell FLO-MIN106 --kit SQK-RNA002 \
--num_callers 4 --fast5_out \
#--device cuda:1
#tar -zcvf FASTQ2.tar.gz /data/yuxin/benchmark/test_data/IVT/IVT_Psi/IVT_pseudoU_fastq/pass
cat *.fastq > normal_guppy_pass.tar.gz
cat *.fastq > 5mou_guppy_fastq.tar.gz

"""
Align to transcriptome:
minimap2 -ax map-ont -uf -t 3 --secondary=no <MMI> <PATH/TO/FASTQ.GZ> > <PATH/TO/SAM> 2>> <PATH/TO/SAM_LOG>
samtools view -Sb <PATH/TO/SAM> | samtools sort -o <PATH/TO/BAM> - &>> <PATH/TO/BAM_LOG>
samtools index <PATH/TO/BAM> &>> <PATH/TO/BAM_INDEX_LOG>


Resquiggle using nanopolish eventalign function
nanopolish index -d <PATH/TO/FAST5_DIR> <PATH/TO/FASTQ_FILE>
nanopolish eventalign --reads <PATH/TO/FASTQ_FILE> \
--bam <PATH/TO/BAM_FILE> \
--genome <PATH/TO/FASTA_FILE \
--signal-index \
--scale-events \
--summary <PATH/TO/summary.txt> \
--threads 32 > <PATH/TO/eventalign.txt>

"""

# for normal
minimap2 -ax map-ont -uf -t 3 --secondary=no /home/jiayi/5moU/data/luciferase.fa  /home/jiayi/5moU/data/normal/guppy_fast5_q/LUC_normal_dRNA_fastq/normal_guppy_fastq.tar.gz  > /home/jiayi/5moU/data/normal/SAM.sam 2>> /home/jiayi/5moU/data/normal/SAM_LOG
samtools view -Sb /home/jiayi/5moU/data/normal/SAM.sam | samtools sort -o /home/jiayi/5moU/data/normal/BAM.bam - &>> /home/jiayi/5moU/data/normal/BAM_LOG
samtools index /home/jiayi/5moU/data/normal/BAM.bam &>> /home/jiayi/5moU/data/normal/BAM_INDEX_LOG

# for 5mou
minimap2 -ax map-ont -uf -t 3 --secondary=no /home/jiayi/5moU/data/luciferase.fa  /home/jiayi/5moU/data/5mou/guppy_5mou_fast5_q/LUC_5mou_dRNA_fastq/5mou_guppy_fastq.tar.gz  > /home/jiayi/5moU/data/5mou/SAM.sam 2>> /home/jiayi/5moU/data/5mou/SAM_LOG
samtools view -Sb /home/jiayi/5moU/data/5mou/SAM.sam | samtools sort -o /home/jiayi/5moU/data/5mou/BAM.bam - &>> /home/jiayi/5moU/data/5mou/BAM_LOG
samtools index /home/jiayi/5moU/data/5mou/BAM.bam &>> /home/jiayi/5moU/data/5mou/BAM_INDEX_LOG
#nanopolish version 0.13.2



# for normal
nanopolish index -d /home/jiayi/5moU/data/normal/guppy_fast5_q/LUC_normal_dRNA_fast5 /home/jiayi/5moU/data/normal/nanopolish/normal_reads.fasta
nanopolish eventalign --reads /home/jiayi/5moU/data/normal/nanopolish/normal_reads.fasta  \
 --bam /home/jiayi/5moU/data/normal/BAM.bam \
 --genome /home/jiayi/5moU/data/luciferase.fa \
 --signal-index \
 --scale-events \
 --summary /home/jiayi/5moU/data/normal/nanopolish/summary.txt \
 --threads 4 > /home/jiayi/5moU/data/normal/nanopolish/eventalign.txt




# for 5mou
/home/yuxin/ont-guppy-cpu/bin/guppy_basecaller \
-i /home/jiayi/5moU/data/5mou/guppy_5mou_fast5_q/LUC_5mou_dRNA_fast5 \
-s /home/jiayi/5moU/data/5mou/guppy_5mou_fast5_q/LUC_5mou_dRNA_fastq \
--flowcell FLO-MIN106 --kit SQK-RNA002 \
--num_callers 4 --fast5_out \
#--device cuda:1


nanopolish index -d /home/jiayi/5moU/data/5mou/guppy_5mou_fast5_q/LUC_5mou_dRNA_fast5 /home/jiayi/5moU/data/5mou/nanopolish/5mou_reads.fasta

nanopolish eventalign --reads /home/jiayi/5moU/data/5mou/nanopolish/5mou_reads.fasta  \
 --bam /home/jiayi/5moU/data/5mou/BAM.bam \
 --genome /home/jiayi/5moU/data/luciferase.fa \
 --signal-index \
 --scale-events \
 --summary /home/jiayi/5moU/data/5mou/nanopolish/summary.txt \
 --threads 4 > /home/jiayi/5moU/data/5mou/nanopolish/eventalign.txt

# convert multiple fastq files to one fasta file
#cd /data/yuxin/benchmark/test_data/IVT/IVT_Psi/IVT_normalU_fastq/pass
cd /home/jiayi/5moU/data/5mou/guppy_5mou_fast5_q/LUC_5mou_dRNA_fastq
find -maxdepth 5 -name "*.fastq"|xargs -i awk \
'{if(NR%4 == 1){print ">" substr($0, 2)}}{if(NR%4 == 2){print}}' {} |cat > \
/home/jiayi/5moU/data/5mou/nanopolish/5mou_reads.fasta
#/home/jiayi/5moU/data/normal/nanopolish/normal_reads.fasta
#/data/jiayi/nanopolishIVT/IVT_normalU/normalU_reads.fasta



#cp [/data/yuxin/benchmark/test_data/IVT/IVT_ref.fa] [/data/jiayi/nanopolishIVT/IVT_normalU]
tar -zcvf FASTQ2.tar.gz /data/yuxin/benchmark/test_data/IVT/IVT_Psi/IVT_pseudoU_fastq/pass

#https://xpore.readthedocs.io/en/latest/preparation.html




### Tombo resquiggle
python3 /home/jiayi/ont_fast5_api/ont_fast5_api/conversion_tools/multi_to_single_fast5.py -i /home/jiayi/5moU/data/normal/guppy_fast5_q/LUC_normal_dRNA_fastq/workspace -s /home/jiayi/5moU/data/normal/Tombo_normal/normal_single_fast5 -t 40 --recursive

/home/jiayi/miniconda3/envs/Tombo/bin/tombo resquiggle /home/jiayi/5moU/data/normal/Tombo_normal/normal_single_fast5 /home/jiayi/5moU/data/ref.fa --processes 4 --num-most-common-errors 5 --overwrite --fit-global-scale --include-event-stdev --ignore-read-locks



h5ls /home/jiayi/5moU/data/normal/Tombo_normal/normal_single_fast5/0/00045de2-6946-4bb7-b361-307cfead9654.fast5 Group
tombo preprocess annotate_raw_with_fastqs --fast5-basedir /home/jiayi/5moU/data/normal/guppy_fast5_q/LUC_normal_dRNA_fast5 --fastq-filenames /home/jiayi/5moU/data/normal/guppy_fast5_q/LUC_normal_dRNA_fastq/normal_guppy_fastq.tar.gz
h5ls /home/jiayi/5moU/data/normal/Tombo_normal/normal_single_fast5/0/00045de2-6946-4bb7-b361-307cfead9654.fast5
h5ls -r /home/jiayi/5moU/data/normal/Tombo_normal/normal_single_fast5/0/000d9837-df83-4767-9d17-23154a9e8ad4.fast5
h5ls -r /home/jiayi/5moU/data/normal/Tombo_normal/normal_single_fast5/1/002e8c79-219d-4697-9c70-b8884a695011.fast5
tombo resquiggle /home/jiayi/5moU/data/normal/Tombo_normal/normal_single_fast5 /home/jiayi/5moU/data/ref.fa --overwrite --basecall-group Basecall_1D_000 --processes 40 --fit-global-scale --include-event-stdev
conda activate Tombo
tombo resquiggle /home/jiayi/5moU/data/normal/Tombo_normal/normal_single_fast5 /home/jiayi/5moU/data/ref.fa --overwrite --basecall-group Basecall_1D_000 --processes 40 --fit-global-scale --include-event-stdev
find  /home/jiayi/5moU/data/normal/Tombo_normal/normal_single_fast5 -name "*.fast5" > /home/jiayi/5moU/data/normal/Tombo_normal/normal_fl_fast5.txt
cp /home/jiayi/extract_tombo /home/jiayi/5moU/Code
cp -r /home/jiayi/extract_tombo /home/jiayi/5moU/Code
cd /home/jiayi/5moU/Code/extract_tombo
python tombo_extract_df.py --cpu=20  --fl=/home/jiayi/5moU/data/normal/Tombo_normal/normal_fl_fast5.txt -o /home/jiayi/5moU/data/normal/Tombo_normal/features --clip=10
conda activate base
python tombo_extract_df.py --cpu=20  --fl=/home/jiayi/5moU/data/normal/Tombo_normal/normal_fl_fast5.txt -o /home/jiayi/5moU/data/normal/Tombo_normal/features --clip=10
head  /home/jiayi/5moU/data/normal/Tombo_normal/features.feature.tsv


## for 5moU modified samples
python3 /home/jiayi/ont_fast5_api/ont_fast5_api/conversion_tools/multi_to_single_fast5.py -i /home/jiayi/5moU/data/5mou/guppy_5mou_fast5_q/LUC_5mou_dRNA_fastq/workspace -s /home/jiayi/5moU/data/5mou/Tombo_5mou/5mou_single_fast5-t 40 --recursive
python3 /home/jiayi/ont_fast5_api/ont_fast5_api/conversion_tools/multi_to_single_fast5.py -i /home/jiayi/5moU/data/5mou/guppy_5mou_fast5_q/LUC_5mou_dRNA_fastq/workspace -s /home/jiayi/5moU/data/5mou/Tombo_5mou/5mou_single_fast5 -t 40 --recursive
tombo preprocess annotate_raw_with_fastqs --fast5-basedir /home/jiayi/5moU/data/5mou/guppy_5mou_fast5_q/LUC_5mou_dRNA_fast5  --fastq-filenames /home/jiayi/5moU/data/5mou/guppy_5mou_fast5_q/LUC_5mou_dRNA_fastq/5mou_guppy_fastq.tar.gz
h5ls /home/jiayi/5moU/data/5mou/Tombo_5mou/5mou_single_fast5/0/000cecc8-5382-443b-8e10-26ecc99ecf2e.fast5
h5ls -r /home/jiayi/5moU/data/5mou/Tombo_5mou/5mou_single_fast5/0/000cecc8-5382-443b-8e10-26ecc99ecf2e.fast5
conda activate Tombo
tombo resquiggle /home/jiayi/5moU/data/5mou/Tombo_5mou/5mou_single_fast5 /home/jiayi/5moU/data/ref.fa --overwrite --basecall-group Basecall_1D_000 --processes 40 --fit-global-scale --include-event-stdev
find  /home/jiayi/5moU/data/5mou/Tombo_5mou/5mou_single_fast5 -name "*.fast5" > /home/jiayi/5moU/data/5mou/Tombo_5mou/5mou_fl_fast5.txt
conda activate base
cd /home/jiayi/5moU/Code/extract_tombo
python tombo_extract_df.py --cpu=20  --fl=/home/jiayi/5moU/data/5mou/Tombo_5mou/5mou_fl_fast5.txt -o /home/jiayi/5moU/data/5mou/Tombo_5mou/features --clip=10
python tombo_to_csv.py



