from sklearn.preprocessing import StandardScaler
from sklearn.svm import SVC,LinearSVC
from sklearn.linear_model import SGDClassifier
from sklearn.model_selection import train_test_split,learning_curve
import seaborn as sns
from matplotlib import pyplot as plt
import pandas as pd
from xgboost import XGBClassifier
from sklearn.metrics import accuracy_score, confusion_matrix, roc_curve, roc_auc_score,precision_score,recall_score,f1_score

mod = pd.read_csv('/home/jiayi/5moU/data/5mou/Tombo_5mou/features.feature.tsv',header = None)
mod['label'] = 1
normal = pd.read_csv('/home/jiayi/5moU/data/normal/Tombo_normal/features.feature.tsv',header = None)
normal['label'] = 0

data = mod.append(normal)
data = data[data.columns[1:(data.shape[1])]]
col_v1=['indx','kmer','mean_1','mean_2','mean_3','mean_4','mean_5','std_1','std_2','std_3','std_4','std_5',
       'mdintense_1','mdintense_2','mdintense_3','mdintense_4','mdintense_5','L-1','L-2','L-3','L-4','L-5','label']
data.columns = col_v1
# mean,std,md_intense,length
data['avg_mean']=(data['mean_1']+data['mean_2']+data['mean_3']+data['mean_4']+data['mean_5'])/5
data['avg_std']= (data['std_1']+data['std_2']+data['std_3']+data['std_4']+data['std_5'])/5
data['avg_mdintense']= (data['mdintense_1']+data['mdintense_2']+data['mdintense_3']+data['mdintense_4']+data['mdintense_5'])/5
data['avg_length2']= (data['L-1']+data['L-2']+data['L-3']+data['L-4']+data['L-5'])/5

#data['avg_std']=data[8:12].mean(axis=1)
#data['avg_mdintense']=data[13:17].mean(axis=1)
#data['length']=data[18:22].mean(axis=1)

df=data[['indx','kmer','avg_mean','avg_std','avg_mdintense','avg_length2','label']]
print(df)
df.to_csv('/home/jiayi/5moU/data/DL_fromTombo/Tombo_all_avg.csv',index=False)