import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

dataset=pd.read_csv('/home/jiayi/5moU/data/DL_fromTombo/Tombo_all_avg.csv')



# Attempt https://thedatafrog.com/en/articles/visualizing-datasets/
labels = dataset['label']
signal_var_names = ['avg_mean','avg_std','avg_mdintense','avg_length2']
#target_names = dataset['target_names']
print(signal_var_names)
print(np.unique(labels))
#print(target_names)

data_signal=dataset[['avg_mean','avg_std','avg_mdintense','avg_length2','label']]
import seaborn as sns
fig=sns.pairplot(data_signal, hue="label", palette='bright')
fig.savefig("/home/jiayi/5moU/Results/signal_sns.png")
