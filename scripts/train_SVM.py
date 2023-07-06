from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
import pandas as pd
import numpy as np
#from xgboost import XGBClassifier
from sklearn import svm
from sklearn.metrics import accuracy_score, confusion_matrix, roc_curve, roc_auc_score
import joblib
import os
import csv
import re
import warnings
warnings.filterwarnings('ignore')


def train_SVM(motif,data):
    motif_data = data.loc[data['kmer']==motif,:]

    X_train, X_test, y_train, y_test = train_test_split(motif_data.iloc[:,2:motif_data.shape[1]-1],
                                                        motif_data['label'],
                                                        train_size=0.9, test_size=0.1)

    scaler = StandardScaler()
    X_train = scaler.fit_transform(X_train)
    X_test = scaler.transform(X_test)

    #xgboost = XGBClassifier()
    #xgboost.fit(X_train, y_train)

    clf = svm.SVC(probability=True)  # choices kernel{‘linear’, ‘poly’, ‘rbf’, ‘sigmoid’, ‘precomputed’} or callable, default=’rbf’

    # Train the model using the training sets
    clf.fit(X_train, y_train)

    # Predict the response for test dataset
    y_pred = clf.predict(X_test)

    #SVM = svm.SVC(probability=True)
    #SVM.fit(X_train, y_train)

    auc = roc_auc_score(y_test,clf.predict(X_test))

    return(auc,clf,scaler)


#data = pd.read_csv('/home/jiayi/5moU/data/DL_fromTombo/Tombo_all_avg.csv')
#data=pd.read_csv('/home/jiayi/5moU/data/DL_fromTombo/all_tombo.csv')
#data=pd.read_csv('/home/jiayi/5moU/data/DL_fromTombo/mid_tombo.csv')
data = pd.read_csv('/home/jiayi/5moU/data/DL_fromTombo/all_01.csv')
print(data)
df = data.groupby(['kmer','label']).agg(coverage = ('indx','count'))
df.to_csv('/home/jiayi/5moU/Code/DL5mou/DeepRead/motif_count.csv')
df = pd.read_csv('/home/jiayi/5moU/Code/DL5mou/DeepRead/motif_count.csv')
df1 = df.loc[df['label']==1,:]
motifs1 = df1.loc[df1['coverage'] > 50,'kmer']
df0 = df.loc[df['label']==0,:]
motifs2 = df0.loc[df0['coverage'] > 50,'kmer']

motifs = np.intersect1d(motifs1,motifs2)

file = open('/home/jiayi/5moU/data/DL_fromTombo/mid01_SVM_perf.csv','w',encoding = 'UTF-8')
csv_writer = csv.writer(file)
csv_writer.writerow(['motif','auc'])
for motif in motifs:
    try:
        auc,clf,scaler = train_SVM(motif,data)
        joblib.dump(clf, '/home/jiayi/5moU/Code/DL5mou/DeepRead/mid01_SVM_model/' + motif + '.joblib')
        joblib.dump(scaler,'/home/jiayi/5moU/Code/DL5mou/DeepRead/mid01_SVM_scaler/' + motif + '.joblib')
        csv_writer.writerow([motif,auc])
    except Exception as e:
        print(str(e))
        continue

file.close()
