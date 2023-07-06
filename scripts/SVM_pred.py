from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
import pandas as pd
import numpy as np
from xgboost import XGBClassifier
from sklearn.metrics import accuracy_score, confusion_matrix, roc_curve, roc_auc_score
import joblib
import os
import csv
import re
import warnings
warnings.filterwarnings('ignore')


test = pd.read_csv('/home/jiayi/5moU/data/DL_fromTombo/all_tombo.csv')
#test = test.iloc[:,0:6]

test['prediction']='0'
test['prob']='0'

print(test)
df = pd.read_csv('/home/jiayi/5moU/data/DL_fromTombo/all_SVM_perf.csv')
motifs = df['motif']

for motif in motifs:
        model = joblib.load('/home/jiayi/5moU/Code/DL5mou/DeepRead/all_SVM_model/' + motif + '.joblib')
        scaler = joblib.load('/home/jiayi/5moU/Code/DL5mou/DeepRead/all_SVM_scaler/' + motif + '.joblib')
        feature = scaler.transform(test.loc[test['kmer'] == motif].iloc[:,2:test.shape[1]-3])
        test.loc[test['kmer'] == motif, 'prob'] = model.predict_proba(feature)[:, 1]
        test.loc[test['kmer'] == motif, 'prediction'] = model.predict(feature)


test = test.loc[:,['indx','kmer','mean_1','mean_2','mean_3','mean_4','mean_5','std_1','std_2','std_3','std_4','std_5',
       'mdintense_1','mdintense_2','mdintense_3','mdintense_4','mdintense_5','L-1','L-2','L-3','L-4','L-5','label','prediction','prob']]

test.to_csv('/home/jiayi/5moU/data/DL_fromTombo/all_SVM_pred.csv',index = 0)
