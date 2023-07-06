 #!/usr/bin/env python
# coding: utf-8

# In[1]:


import numpy as np
import pandas as pd

import tensorflow as tf
import datetime

from tensorflow import feature_column
from tensorflow.keras import layers
from sklearn.model_selection import train_test_split
     


# In[ ]:


#get_ipython().run_line_magic('jupyter', 'nbconvert --to script All_TF_Dense.ipynb')


# In[2]:


data=pd.read_csv('/home/jiayi/5moU/data/DL_fromTombo/all_tombo.csv')
#data


# In[3]:


train, test = train_test_split(data, test_size=0.2)
train, val = train_test_split(train, test_size=0.2)
print(len(train), 'train examples')
print(len(val), 'validation examples')
print(len(test), 'test examples')


# In[4]:


# A utility method to create a tf.data dataset from a Pandas Dataframe
def df_to_dataset(data, shuffle=True, batch_size=32):
  data = data.copy()
  labels = data.pop('label')
  ds = tf.data.Dataset.from_tensor_slices((dict(data), labels))
  if shuffle:
    ds = ds.shuffle(buffer_size=len(data))
  ds = ds.batch(batch_size)
  return ds


# In[5]:


# A utility method to create a feature column
# and to transform a batch of data
def demo(feature_column):
  feature_layer = layers.DenseFeatures(feature_column)
  print(feature_layer(example_batch).numpy())


# In[6]:


batch_size = 5 # A small batch sized is used for demonstration purposes
train_ds = df_to_dataset(train, batch_size=batch_size)
val_ds = df_to_dataset(val, shuffle=False, batch_size=batch_size)
test_ds = df_to_dataset(test, shuffle=False, batch_size=batch_size)




# In[7]:


#Understand the input pipeline
#Now that we have created the input pipeline, let's call it to see the format of the data it returns. We have used a small batch size to keep the output readable.
for feature_batch, label_batch in train_ds.take(1):
  print('Every feature:', list(feature_batch.keys()))
  print('A batch of kmer:', feature_batch['kmer'])
  print('A batch of targets:', label_batch )


# In[8]:


# We will use this batch to demonstrate several types of feature columns
example_batch = next(iter(train_ds))[0]


# In[9]:


# A utility method to create a feature column
# and to transform a batch of data
def demo(feature_column):
  feature_layer = layers.DenseFeatures(feature_column)
  print(feature_layer(example_batch).numpy())


# In[10]:


kmer = feature_column.categorical_column_with_vocabulary_list(
      'kmer', data.kmer.unique())
kmer_embedding = feature_column.embedding_column(kmer, dimension=4)
demo(kmer_embedding)


# In[11]:


feature_columns = []
# embedding columns
kmer = feature_column.categorical_column_with_vocabulary_list(
      'kmer', data.kmer.unique())
kmer_embedding = feature_column.embedding_column(kmer, dimension=4)
feature_columns.append(kmer_embedding)

# numeric cols
for header in ['mean_1','mean_2','mean_3','mean_4','mean_5','std_1','std_2','std_3','std_4','std_5',
       'mdintense_1','mdintense_2','mdintense_3','mdintense_4','mdintense_5','L-1','L-2','L-3','L-4','L-5']:
  feature_columns.append(feature_column.numeric_column(header))

demo(feature_columns)


# In[12]:


feature_layer = tf.keras.layers.DenseFeatures(feature_columns)

batch_size = 100
train_ds = df_to_dataset(train, batch_size=batch_size)
val_ds = df_to_dataset(val, shuffle=False, batch_size=batch_size)
test_ds = df_to_dataset(test, shuffle=False, batch_size=batch_size)


### https://stackoverflow.com/questions/56226621/how-to-extract-data-labels-back-from-tensorflow-dataset
val, labels = tuple(zip(*val_ds))


# In[13]:

"""
model = tf.keras.Sequential([
  feature_layer,
  layers.Dense(128, activation='relu'),
  layers.Dense(128, activation='relu'),
  layers.Dropout(.1),
  layers.Dense(1)
])

model.compile(optimizer='adam',
              loss=tf.keras.losses.BinaryCrossentropy(from_logits=True),
              metrics=['accuracy'])

my_callbacks = [
    tf.keras.callbacks.EarlyStopping(patience=2),
    tf.keras.callbacks.ModelCheckpoint(filepath='model.{epoch:02d}-{val_loss:.2f}.h5'),
    tf.keras.callbacks.TensorBoard(log_dir='/home/jiayi/5moU/Code/extract_tombo/log/TF_Dense_logs'),
]


log_dir = "logs/fit/" + datetime.datetime.now().strftime("%Y%m%d-%H%M%S")
tensorboard_callback = tf.keras.callbacks.TensorBoard(log_dir=log_dir, histogram_freq=1)

history=model.fit(train_ds,
          validation_data=val_ds,
          epochs=50,
         callbacks= [tensorboard_callback])



"""



# In[ ]:

"""
from matplotlib import pyplot as plt
history_dict = history.history

acc = history_dict['accuracy']
val_acc = history_dict['val_accuracy']
loss = history_dict['loss']
val_loss = history_dict['val_loss']
epochs = history.epoch

fig = plt.figure(figsize=(18,6))

plt.subplot2grid((1,2),(0,0),colspan=1,rowspan=1)
plt.plot(epochs, acc, 'r', label='training accuracy')
plt.plot(epochs, val_acc, 'b', label='validation accuracy')
plt.title('Training and validation accuracy', size=18)
plt.xlabel('Epochs', size=14)
plt.ylabel('Accuracy')
plt.legend(prop={'size': 14})

plt.subplot2grid((1,2),(0,1),colspan=1,rowspan=1)
plt.plot(epochs, loss, 'r', label='training loss')
plt.plot(epochs, val_loss, 'b', label='validation loss')
plt.title('Training and validation loss', size=18)
plt.xlabel('Epochs', size=14)
plt.ylabel('Loss')
plt.legend(prop={'size': 14})

plt.show()


fig.savefig('/home/jiayi/5moU/Results/all_sig_trainlog.png')


"""




# In[13]:


# https://www.tensorflow.org/tutorials/structured_data/imbalanced_data
from tensorflow import keras

METRICS = [
      keras.metrics.TruePositives(name='tp'),
      keras.metrics.FalsePositives(name='fp'),
      keras.metrics.TrueNegatives(name='tn'),
      keras.metrics.FalseNegatives(name='fn'), 
      keras.metrics.BinaryAccuracy(name='accuracy'),
      keras.metrics.Precision(name='precision'),
      keras.metrics.Recall(name='recall'),
      keras.metrics.AUC(name='auc'),
      keras.metrics.AUC(name='prc', curve='PR'), # precision-recall curve
]


# In[ ]:


model = tf.keras.Sequential([
  feature_layer,
  layers.Dense(128, activation='relu'),
  layers.Dense(128, activation='relu'),
  layers.Dropout(.1),
  layers.Dense(1)
])

model.compile(optimizer='adam',
              loss=tf.keras.losses.BinaryCrossentropy(from_logits=True),
              metrics=METRICS)

my_callbacks = [
    tf.keras.callbacks.EarlyStopping(patience=2),
    tf.keras.callbacks.ModelCheckpoint(filepath='model.{epoch:02d}-{val_loss:.2f}.h5'),
    tf.keras.callbacks.TensorBoard(log_dir='/home/jiayi/5moU/Code/extract_tombo/log/TF_Dense_logs'),
]


log_dir = "logs/fit/" + datetime.datetime.now().strftime("%Y%m%d-%H%M%S")
tensorboard_callback = tf.keras.callbacks.TensorBoard(log_dir=log_dir, histogram_freq=1)

history=model.fit(train_ds,
          validation_data=val_ds,
          epochs=50,
         callbacks= [tensorboard_callback])


# In[ ]:



from matplotlib import pyplot as plt
history_dict = history.history

acc = history_dict['accuracy']
val_acc = history_dict['val_accuracy']
loss = history_dict['loss']
val_loss = history_dict['val_loss']
epochs = history.epoch

fig = plt.figure(figsize=(18,6))

plt.subplot2grid((1,2),(0,0),colspan=1,rowspan=1)
plt.plot(epochs, acc, 'r', label='training accuracy')
plt.plot(epochs, val_acc, 'b', label='validation accuracy')
plt.title('Training and validation accuracy', size=18)
plt.xlabel('Epochs', size=14)
plt.ylabel('Accuracy')
plt.legend(prop={'size': 14})

plt.subplot2grid((1,2),(0,1),colspan=1,rowspan=1)
plt.plot(epochs, loss, 'r', label='training loss')
plt.plot(epochs, val_loss, 'b', label='validation loss')
plt.title('Training and validation loss', size=18)
plt.xlabel('Epochs', size=14)
plt.ylabel('Loss')
plt.legend(prop={'size': 14})

plt.show()


fig.savefig('/home/jiayi/5moU/Results/all_sigseq_trainlog.png')





# In[ ]:

"""

from sklearn.metrics import classification_report, accuracy_score, confusion_matrix,roc_curve,roc_auc_score
val, labels = tuple(zip(*val_ds))
cm = confusion_matrix(labels,model.fit(val_ds))

fig = plt.figure(figsize = (8,8))

ax1 = sns.heatmap(cm,annot=True,fmt='.20g',xticklabels = ['unmoified','modified'] , yticklabels = ['unmodified','modified'])
ax1.set_title('Confusion matrix for neural network model',size = 18)
ax1.set_xlabel('predict')
ax1.set_ylabel('true')

plt.show()

fig.savefig('/home/jiayi/5moU/Results/sigallseq_confusion.png')


"""


# In[ ]:


import matplotlib.pyplot as plt
colors = plt.rcParams['axes.prop_cycle'].by_key()['color']
def plot_metrics(history):
  metrics = ['loss', 'prc', 'precision', 'recall']
  for n, metric in enumerate(metrics):
    name = metric.replace("_"," ").capitalize()
    plt.subplot(2,2,n+1)
    plt.plot(history.epoch, history.history[metric], color=colors[0], label='Train')
    plt.plot(history.epoch, history.history['val_'+metric],
             color=colors[0], linestyle="--", label='Val')
    plt.xlabel('Epoch')
    plt.ylabel(name)
    if metric == 'loss':
      plt.ylim([0, plt.ylim()[1]])
    elif metric == 'auc':
      plt.ylim([0.8,1])
    else:
      plt.ylim([0,1])

    plt.legend()



# In[ ]:


pm=plot_metrics(history)
pm.savefig('/home/jiayi/5moU/Results/all_history.png')


# In[ ]:




