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


test = pd.read_csv('/home/jiayi/5moU/data/DL_fromTombo/avg_tombo.csv')
#test = test.iloc[:,0:6]

test['prediction']='0'
test['prob']='0'

print(test)
df = pd.read_csv('/home/jiayi/5moU/data/DL_fromTombo/avg_xgb_perf.csv')
motifs = df['motif']

for motif in motifs:
        model = joblib.load('/home/jiayi/5moU/Code/DL5mou/DeepRead/avg_xgb_model/' + motif + '.joblib')
        scaler = joblib.load('/home/jiayi/5moU/Code/DL5mou/DeepRead/avg_xgb_scaler/' + motif + '.joblib')
        feature = scaler.transform(test.loc[test['kmer'] == motif].iloc[:,2:test.shape[1]-3])
        test.loc[test['kmer'] == motif, 'prob'] = model.predict_proba(feature)[:, 1]
        test.loc[test['kmer'] == motif, 'prediction'] = model.predict(feature)


test = test.loc[:,['indx','kmer','avg_mean','avg_std','avg_mdintense','avg_length2','label','prediction','prob']]

test.to_csv('/home/jiayi/5moU/data/DL_fromTombo/avg_xgb_pred.csv',index = 0)
