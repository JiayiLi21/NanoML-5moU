from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
import pandas as pd
import numpy as np
from xgboost import XGBClassifier
from sklearn.model_selection import cross_validate
from sklearn import metrics
from sklearn.metrics import accuracy_score, confusion_matrix, roc_curve, roc_auc_score
import joblib
import os
import csv
import re
import warnings
warnings.filterwarnings('ignore')



def train_model(motif,data):
    motif_data = data.loc[data['kmer']==motif,:]

    """
    X_train, X_test, y_train, y_test = train_test_split(motif_data.iloc[:,2:motif_data.shape[1]-1],
                                                        motif_data['label'],
                                                        train_size=0.9, test_size=0.1)

    """
    X= motif_data.iloc[:,2:motif_data.shape[1]-1]
    y= motif_data['label']


    scaler = StandardScaler()
    #X_train = scaler.fit_transform(X_train)
    #X_test = scaler.transform
    X=scaler.fit_transform(X)

    xgboost = XGBClassifier(learning_rate=0.01,
                      n_estimators=10,           # 树的个数-10棵树建立xgboost
                      max_depth=4,               # 树的深度
                      min_child_weight = 1,      # 叶子节点最小权重
                      gamma=0.,                  # 惩罚项中叶子结点个数前的参数
                      subsample=1,               # 所有样本建立决策树
                      colsample_btree=1,         # 所有特征建立决策树
                      scale_pos_weight=1,        # 解决样本个数不平衡的问题
                      random_state=27,           # 随机数
                      slient = 0)
    xgboost.fit(X_train, y_train)

    #cross_val_score(xgboost, X, y, cv=5, scoring='recall_macro')
    # https://scikit-learn.org/stable/modules/model_evaluation.html
    scores = {  'AUC': 'roc_auc',
               'Accuracy': make_scorer(accuracy_score),
                'Precision': 'precision',
                'Recall': 'recall',
                'F1':'f1'}


    cv_results=cross_val_score(xgboost, X, y, cv=10, scoring=scores)

    #auc = roc_auc_score(y_test, xgboost.predict(X_test))
    #Acc= metrics.accuracy_score(y_test, xgboost.predict(X_test))


    return(auc,xgboost,scaler)


#data = pd.read_csv('/home/jiayi/5moU/data/DL_fromTombo/Tombo_all_avg.csv')
data=pd.read_csv('/home/jiayi/5moU/data/DL_fromTombo/all_tombo.csv')
print(data)
df = data.groupby(['kmer','label']).agg(coverage = ('indx','count'))
df.to_csv('/home/jiayi/5moU/Code/DL5mou/DeepRead/motif_count.csv')
df = pd.read_csv('/home/jiayi/5moU/Code/DL5mou/DeepRead/motif_count.csv')
df1 = df.loc[df['label']==1,:]
motifs1 = df1.loc[df1['coverage'] > 50,'kmer']
df0 = df.loc[df['label']==0,:]
motifs2 = df0.loc[df0['coverage'] > 50,'kmer']

motifs = np.intersect1d(motifs1,motifs2)

file = open('/home/jiayi/5moU/data/DL_fromTombo/all_xgb_perf.csv','w',encoding = 'UTF-8')
csv_writer = csv.writer(file)
csv_writer.writerow(['motif','auc'])
for motif in motifs:
    try:
        auc,model,scaler = train_model(motif,data)
        joblib.dump(model, '/home/jiayi/5moU/Code/DL5mou/DeepRead/all_xgb_model/' + motif + '.joblib')
        joblib.dump(scaler,'/home/jiayi/5moU/Code/DL5mou/DeepRead/all_xgb_scaler/' + motif + '.joblib')
        csv_writer.writerow([motif,auc])
    except Exception as e:
        print(str(e))
        continue

file.close()
