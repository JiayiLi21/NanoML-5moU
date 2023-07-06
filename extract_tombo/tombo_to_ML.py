from sklearn.preprocessing import StandardScaler
from sklearn.svm import SVC,LinearSVC
from sklearn.linear_model import SGDClassifier
from sklearn.model_selection import train_test_split,learning_curve
import seaborn as sns
from matplotlib import pyplot as plt
import pandas as pd
from sklearn.linear_model import LogisticRegression
from sklearn.ensemble import RandomForestClassifier
from xgboost import XGBClassifier
from sklearn.neighbors import KNeighborsClassifier
from sklearn.metrics import accuracy_score, confusion_matrix, roc_curve, roc_auc_score,precision_score,recall_score,f1_score

psi = pd.read_csv('/home/jiayi/5moU/data/5mou/Tombo_5mou/features.feature.tsv',header = None)
psi['label'] = 1
normalU = pd.read_csv('/home/jiayi/5moU/data/normal/Tombo_normal/features.feature.tsv',header = None)
normalU['label'] = 0

data = psi.append(normalU)
#data = data[data.columns[3:(data.shape[1])]]
data = data[data.columns[3:(data.shape[1])]]

X_train,X_test,y_train,y_test = train_test_split(data, data['label'],train_size = 0.001,test_size = 0.001)

scaler = StandardScaler()
X_train = scaler.fit_transform(X_train)
X_test = scaler.transform(X_test)

###LR
logreg = LogisticRegression(random_state=16)
logreg.fit(X_train, y_train)

###RF
clf=RandomForestClassifier(n_estimators=100)
clf.fit(X_train,y_train)


### SVM
svc = SVC(probability=True)
svc.fit(X_train,y_train)

###Xgboost
xgboost = XGBClassifier()
xgboost.fit(X_train, y_train)

###knn
knn = KNeighborsClassifier(n_neighbors=5)
knn.fit(X_train, y_train)




### visualization
plt.figure(figsize = (4,4))

#for LR
fpr,tpr,thresh = roc_curve(y_test, logreg.predict(X_test))
auc = roc_auc_score(y_test, logreg.predict(X_test))
print("AUC of LR:"+str(auc))
plt.plot(fpr,tpr,label='LR: AUC %0.4f' % auc, lw = 1.5)

#for RF
fpr,tpr,thresh = roc_curve(y_test, clf.predict(X_test))
auc = roc_auc_score(y_test, clf.predict(X_test))
print("AUC of RF:"+str(auc))
plt.plot(fpr,tpr,label='RF: AUC %0.4f' % auc, lw = 1.5)


#for svm
fpr,tpr,thresh = roc_curve(y_test, svc.predict_proba(X_test)[:,1])
auc = roc_auc_score(y_test, svc.predict(X_test))
print("AUC of SVM:"+str(auc))
plt.plot(fpr,tpr,label='SVM: AUC %0.4f' % auc, lw = 1.5)

#for xgboost
fpr,tpr,thresh = roc_curve(y_test, xgboost.predict(X_test))
auc = roc_auc_score(y_test, xgboost.predict(X_test))
print("AUC of xgboost:"+str(auc))
plt.plot(fpr,tpr,label='xgboost: AUC %0.4f' % auc, lw = 1.5)

#for knn
fpr,tpr,thresh=roc_curve(y_test,knn.predict(X_test))
auc = roc_auc_score(y_test, knn.predict(X_test))
print("AUC of knn:"+str(auc))
plt.plot(fpr,tpr,label='knn: AUC %0.4f' % auc, lw = 1.5)





plt.xlabel('False Positive Rate')
plt.ylabel('True Positive Rate')
plt.title('5mou signal features', size = 18)
plt.legend(loc="lower right")
plt.show()
plt.savefig('/home/jiayi/5moU/Results/5mou_signal_ml_roc.png')