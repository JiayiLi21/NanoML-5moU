from itertools import product
import pandas as pd
data=pd.read_csv('/home/jiayi/5moU/data/DL_fromTombo/Tombo_all_avg.csv')

kmer_df=data['kmer']
kmer_list=list(kmer_df)
mod = pd.read_csv('/home/jiayi/5moU/data/5mou/Tombo_5mou/features.feature.tsv',header = None)
mod_kmerlist=list(mod['kmer'])
normal = pd.read_csv('/home/jiayi/5moU/data/normal/Tombo_normal/features.feature.tsv',header = None)
normal_kmerlist=list(normal['kmer'])



#all_kmer="[ACGT][ACGT]T[ACGT][ACGT]"
#kmer=list(product(all_kmer))
#occur = data.groupby([kmer]).size()

# display occurrences of combined columns
#display(occur)

#kmer_df.to_csv('/home/jiayi/5moU/data/DL_fromTombo/Tombo_kmerlist.csv',index=False)