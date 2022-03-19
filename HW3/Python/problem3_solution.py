from sklearn.svm import SVC
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score
from scipy.io import loadmat
import numpy as np
import matplotlib.pyplot as plt

data = loadmat('dataset.mat')
X, y = data['X'], data['Y']
y = np.where(y==0, -1, 1)

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.5)

score = []
C = [x*0.1 for x in range(1,101)]
print('LINEAR KERNEL ----> Best Estimator:')

for item in C:
    clf = SVC(C=item, kernel='linear')
    clf.fit(X_train, y_train.ravel())
    y_predict = clf.predict(X_test)
    score.append(accuracy_score(y_test, y_predict))

idx = score.index(max(score))
print('C={:.2f}, Accuracy={}'.format(C[idx], score[idx]*100))

fig = plt.figure()
ax = plt.axes()
ax.plot(C, score)
ax.set_xlabel('C')
ax.set_ylabel('Accuracy')


score = []
C = [0.0001, 0.0009, 0.001, 0.01, 0.21, 0.301, 0.49, 1]
degree = list(range(1,9))
print()
print('POLY KERNEL ----> Best Estimator:')

for i in range(len(C)):
    clf = SVC(C=C[i], degree=degree[i], gamma=0.9, kernel='poly')
    clf.fit(X_train, y_train.ravel())
    y_predict = clf.predict(X_test)
    score.append(accuracy_score(y_test, y_predict))

idx = score.index(max(score))
print(
    f'C={C[idx]}, Degree of Polynomial={degree[idx]}, Gamma=0.9, Accuracy={score[idx] * 100}'
)


fig = plt.figure()
ax = plt.axes(projection='3d')
ax.plot_trisurf(C, degree, score, cmap='viridis')
ax.set_xlabel('C')
ax.set_ylabel('Degree of Polynomial')
ax.set_zlabel('Accuracy')

fig = plt.figure()
ax = plt.axes(projection='3d')
dx = np.ones(len(C))
dy = np.ones(len(C))
dz = np.ones(len(C))
score, dz = dz, score
ax.bar3d(C, degree, score, dx, dy, dz, shade=True)
ax.set_xlabel('C')
ax.set_ylabel('Degree of Polynomial')
ax.set_zlabel('Accuracy')


score = []
C = [0.01, 0.1, 0.5, 1, 10, 50, 100]
gamma = [0.1, 0.2, 0.3, 0.4, 0.5, 0.7, 0.9]
print()
print('RBF KERNEL ----> Best Estimator:')

for i in range(len(C)):
    clf = SVC(C=C[i], gamma=gamma[i], kernel='rbf')
    clf.fit(X_train, y_train.ravel())
    y_predict = clf.predict(X_test)
    score.append(accuracy_score(y_test, y_predict))

idx = score.index(max(score))
print(f'C={C[idx]}, Gamma={gamma[idx]}, Accuracy={score[idx] * 100}')

fig = plt.figure()
ax = plt.axes(projection='3d')
ax.plot_trisurf(C, gamma, score, cmap='viridis')
ax.set_xlabel('C')
ax.set_ylabel('Degree of Polynomial')
ax.set_zlabel('Accuracy')

fig = plt.figure()
ax = plt.axes(projection='3d')
dx = np.ones(len(C))
dy = np.ones(len(C))
dz = np.ones(len(C))
score, dz = dz, score
ax.bar3d(C, gamma, score, dx, dy, dz, shade=True)
ax.set_xlabel('C')
ax.set_ylabel('Gamma')
ax.set_zlabel('Accuracy')
plt.show()
