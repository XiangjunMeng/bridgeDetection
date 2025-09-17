import scipy.io
import matplotlib.pyplot as plt
import cv2
import numpy as np

mat_file = '/home/robot/Desktop/bridge detection yolov8/BridgeLabelingJQ.mat'
data = scipy.io.loadmat(mat_file)
print("keys in the MAT file:", data.keys())