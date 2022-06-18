# -*- coding: utf-8 -*-
"""
Created on Sun Jun 13 16:42:00 2021

@author: Erutalon
"""




#划分训练集和测试集
#随机选择一定比例的方式(选择80%训练，20%测试)

import os
import random
import shutil
path = 'F:\DIP2\缺陷库'
dirs = []
split_percentage = 0.2
for dirpath, dirnames, filenames in os.walk(path, topdown=False):
   for dirname in dirnames:
       fullpath = os.path.join(dirpath, dirname)
       fileCount = len([name for name in os.listdir(fullpath) if os.path.isfile(os.path.join(fullpath, name))])
       files = os.listdir(fullpath)
       for index in range((int)(split_percentage * fileCount)):
           newIndex = random.randint(0, fileCount - 1)
           fullFilePath = os.path.join(fullpath, files[newIndex])
           newFullFilePath = fullFilePath.replace('缺陷库', 'Final_Validation')
           base_new_path = os.path.dirname(newFullFilePath)
           if not os.path.exists(base_new_path):
               os.makedirs(base_new_path)
           # move the file
           try:
               shutil.move(fullFilePath, newFullFilePath)
           except IOError as error:
               print('skip moving from %s => %s' % (fullFilePath, newFullFilePath))