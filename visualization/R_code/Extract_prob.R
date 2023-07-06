all_mod<- read.csv("/Users/lijiayi/Desktop/NanoML-5mou/temp_code/Mod_prob.csv",header=T,sep=',')
AGTTC_mod <-  all_mod[all_mod$kmer == 'AGTTC',]
AGTTC_mod_prob <- write.csv(AGTTC_mod,file  = "AGTTC_mod_prob.csv")


TGTGC_mod <-  all_mod[all_mod$kmer == 'TGTGC',]


#sample_TGTGC_mod_prob <- TGTGC_mod[sample(nrow(df), 300), ]
sample_TGTGC_mod_prob <-TGTGC_mod[sample(1:nrow(TGTGC_mod), 300), ]
sample_TGTGC_mod_prob <- write.csv(sample_TGTGC_mod_prob,file  = "sample_TGTGC_mod_prob.csv")


TGTGC_mod_prob <- write.csv(TGTGC_mod,file  = "TGTGC_mod_prob.csv")


                            
all_normal<- read.csv("/Users/lijiayi/Desktop/NanoML-5mou/temp_code/Normal_prob.csv",header=T,sep=',')
AGTTC_normal <-  all_normal[all_normal$kmer == 'AGTTC',]
sample_AGTTC_normal_prob <-AGTTC_normal[sample(1:nrow(AGTTC_normal), 315), ]
sample_AGTTC_normal_prob <- write.csv(sample_AGTTC_normal_prob,file  = "sample_AGTTC_normal_prob.csv")
AGTTC_normal_prob <- write.csv(AGTTC_normal,file  = "AGTTC_normal_prob.csv")




TGTGC_normal <-  all_normal[all_normal$kmer == 'TGTGC',]
sample_TGTGC_normal_prob <-TGTGC_normal[sample(1:nrow(TGTGC_normal), 300), ]
sample_TGTGC_normal_prob <- write.csv(sample_TGTGC_normal_prob,file  = "sample_TGTGC_normal_prob.csv")

TGTGC_normal_prob <- write.csv(TGTGC_normal,file  = "TGTGC_normal_prob.csv")

                               