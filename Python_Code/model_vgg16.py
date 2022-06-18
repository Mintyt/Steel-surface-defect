# -*- coding: utf-8 -*-
"""
Created on Sun Jun 13 16:49:19 2021

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
#%%
from keras.applications import VGG16
#%%Train文件划分后的数据处理
train_set_base_dir = 'F:\DIP\缺陷库'
validation_set_base_dir = 'F:\DIP\Final_Validation'
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


#%%modelVGG16
#使用VGG16进行预训练
#from keras.applicaions import VGG16
conv_base=VGG16(weights = 'imagenet',
                include_top = False,
                input_shape = (224,224,3))

model = Sequential()
model.add(conv_base)
#分类器
model.add(Flatten())
# dropOut layer
model.add(Dropout(0.2))
model.add(Dense(units=56, activation='relu'))
model.add(Dense(units=11, activation='softmax'))

conv_base.trainable = False #冻结卷积基
#编译
#多分类单标签问题，loss选择的'categorical_crossentropy'
model.compile(loss='categorical_crossentropy', optimizer='rmsprop', metrics=['acc'])

# 打印模型
model.summary()
json_str = model.to_json()
print(json_str)
#%%
history = model.fit_generator(
    generator=train_data_generator,
    steps_per_epoch=100,
    epochs=30,
    validation_data=test_data_generator,
    validation_steps=50)

#保存模型
model.save('F:/MLCourse/model_VGG16_3.h5')

#%%
#绘制训练情况
acc = history.history['acc']
val_acc = history.history['val_acc']
loss = history.history['loss']
val_loss = history.history['val_loss']

epochs = range(1, len(acc) + 1)
plt.plot(epochs, acc, 'bo', label='Training acc')
plt.plot(epochs, val_acc, 'b', label='Validation acc')
plt.title('Training and validation accuracy')
plt.legend()

plt.figure()

plt.plot(epochs, loss, 'bo', label='Training loss')
plt.plot(epochs, val_loss, 'b', label='Validation loss')
plt.title('Training and validation loss')
plt.legend()

plt.show()


#%%评估
scores = model.evaluate(validation_data_generator)
print(scores)
#%%evaluate2
scores2 = model.evaluate(test_data_generator)
print(scores2)

