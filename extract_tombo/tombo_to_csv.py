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
data = data[data.columns[3:(data.shape[1])]]

X_train,X_test,y_train,y_test = train_test_split(data, data['label'],train_size = 0.001,test_size = 0.001)

scaler = StandardScaler()
X_train = scaler.fit_transform(X_train)
X_test = scaler.transform(X_test)

svc = SVC(probability=True)
svc.fit(X_train,y_train)

xgboost = XGBClassifier()
xgboost.fit(X_train, y_train)





plt.figure(figsize = (4,4))

fpr,tpr,thresh = roc_curve(y_test, svc.predict_proba(X_test)[:,1])
auc = roc_auc_score(y_test, svc.predict(X_test))
print("AUC of SVM:"+str(auc))
plt.plot(fpr,tpr,label='SVM: AUC %0.4f' % auc, lw = 1.5)

fpr,tpr,thresh = roc_curve(y_test, xgboost.predict(X_test))
auc = roc_auc_score(y_test, xgboost.predict(X_test))
print("AUC of xgboost:"+str(auc))
plt.plot(fpr,tpr,label='xgboost: AUC %0.4f' % auc, lw = 1.5)


plt.xlabel('False Positive Rate')
plt.ylabel('True Positive Rate')
plt.title('5mou signal features', size = 18)
plt.legend(loc="lower right")
plt.show()
plt.savefig('/home/jiayi/5moU/Results/5mou_signal_ml_roc.png')