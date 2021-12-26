import cv2
import numpy as np
from scipy.io import loadmat

# Load the image dataset and convert to float32 type for OpenCV compatibility
dataset = loadmat('teapots.mat')['teapotImages'].astype('float32')

# Reshaping into proper dimensions for easy access
data = dataset.reshape((100, 50, 38))

# Applying image transformations to view images properly
data = np.asarray([cv2.rotate(dataset[i], cv2.ROTATE_90_CLOCKWISE) for i in range(len(dataset))])
data = np.asarray([cv2.flip(dataset[i], 1) for i in range(len(dataset))])

# Display the image in the output window with proper resolution
# cv2.namedWindow("Image", cv2.WINDOW_NORMAL)
# cv2.resizeWindow('Image', 500, 380)
# cv2.imshow('Image', img)
# cv2.waitKey(0)
# cv2.destroyAllWindows()

mean = np.mean(dataset)
X = dataset - mean

covariance_matrix = np.cov(X)

V, D = np.linalg.eig(covariance_matrix)

data_sorted = np.sort(D)[::-1]
data_sorted = data_sorted[0:3, :]
print(data_sorted)