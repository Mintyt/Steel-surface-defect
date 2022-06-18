# -*- coding: utf-8 -*-
"""
Created on Sun Jun 13 17:10:07 2021

@author: Erutalon
"""


#%%
import shutil
import os
import matplotlib.pyplot as plt
import keras
import tensorflow as tf
from PIL import Image
import numpy as np
from keras.preprocessing.image import ImageDataGenerator
from keras.preprocessing import image
import sys
import numpy as np
from tensorflow.keras import datasets, layers, models
from keras.models import Sequential
from keras.layers import Conv2D, MaxPool2D, Flatten, Dense, Dropout

#%% 
from keras import applications
#%%Train文件划分后的数据处理
train_set_base_dir = 'F:\DIP2\缺陷库'
validation_set_base_dir = 'F:\DIP2\Final_Validation'
#%%
train_datagen = ImageDataGenerator(
    rescale=1. / 255
)
train_data_generator = train_datagen.flow_from_directory(
    directory=train_set_base_dir,
    target_size=(224, 224),
    batch_size=32,
    class_mode='categorical')
#%%

validation_datagen = ImageDataGenerator(
    rescale=1. /255
)

validation_data_generator = validation_datagen.flow_from_directory(
    directory=validation_set_base_dir,
    target_size=(224, 224),
    batch_size=32,
    class_mode='categorical'
)
#%%训练
#模型使用简单四层卷积，加flatten和dense层作为分类器，对其进行分类
model = Sequential()

# layers.conv2D
#此处选择四层二维卷积，并做全局池化
model.add(Conv2D(filters=32, kernel_size=(3, 3), activation='relu', input_shape=(224, 224, 3)))
model.add(MaxPool2D(pool_size=(2, 2), padding='valid'))

model.add(Conv2D(filters=64, kernel_size=(3, 3), activation='relu'))
model.add(MaxPool2D(pool_size=(2, 2), padding='valid'))

model.add(Conv2D(filters=128, kernel_size=(3, 3), activation='relu'))
model.add(MaxPool2D(pool_size=(2, 2), padding='valid'))

model.add(Conv2D(filters=128, kernel_size=(3, 3), activation='relu'))
model.add(MaxPool2D(pool_size=(2, 2), padding='valid'))

#分类器
model.add(Flatten())
# dropOut layer
model.add(Dropout(0.2))
model.add(Dense(units=128, activation='relu'))
model.add(Dense(units=11, activation='softmax'))

#编译
#多分类单标签问题，loss选择的'categorical_crossentropy'
model.compile(loss='categorical_crossentropy', optimizer='rmsprop', metrics=['acc'])

# 打印模型
model.summary()
#%%
json_str = model.to_json()
print(json_str)
history = model.fit_generator(
    generator=train_data_generator,
    steps_per_epoch=100,
    epochs=10,
    validation_data=validation_data_generator,
    validation_steps=50)

#保存模型
model.save('F:/DIP/test/prewitt_10epoch.h5')

#%%
#绘制训练情况
acc = history.history['acc']
val_acc = history.history['val_acc']
loss = history.history['loss']
val_loss = history.history['val_loss']

epochs = range(1, len(acc) + 1)
plt.plot(epochs, acc, label='Training acc')
plt.plot(epochs, val_acc, label='Validation acc')
plt.title('Training and validation accuracy')
plt.legend()

plt.figure()

plt.plot(epochs, loss, label='Training loss')
plt.plot(epochs, val_loss, label='Validation loss')
plt.title('Training and validation loss')
plt.legend()

plt.show()



#%%

scores = model.evaluate(validation_data_generator)
print(scores)