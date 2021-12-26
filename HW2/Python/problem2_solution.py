import scipy.io 
import numpy as np 
import matplotlib.pyplot as plt

data = scipy.io.loadmat('data3.mat')
data = data['data']

X = data[:,0:2]
y = data[:,-1]

X = np.hstack((X, np.ones((len(X), 1))))

theta = np.random.rand(3,1)
theta1 = np.ones((3,1)) * 15
eta = 0.4
tol = 0.002

loss =[]
err =[]
itr = []
grad = []

iteration=0
while np.linalg.norm(theta - theta1) > tol:
    iteration += 1
    itr.append(iteration)
    
    f = np.dot(X, theta)
    pLoss = np.zeros(len(f))
    gradient = np.zeros((len(f), 3))
    
    misclassified = 0
    
    for i in range(len(f)):
        if f[i] * y[i] < 0:
            misclassified = misclassified + 1
            pLoss[i] = y[i] * f[i]
            gradient[i] = y[i] * X[i]
    
    loss.append(-1 * (1/len(X)) * sum(pLoss))
    
    gradientFinal = -(1/len(X))*sum(gradient)
    gradientFinal = gradientFinal.reshape((3,1))
    grad.append(gradientFinal)
    
    err.append((1/len(X)) * misclassified)
    
    theta1 = theta
    theta = theta1 - gradientFinal*eta

a = X[:, 0]
b = X[:, 1]

plt.figure()
plt.title('Linear Decision Boundry')
for i in range(len(y)):
    if y[i] == 1:
        plt.scatter(a[i], b[i], color='red')
    else:
        plt.scatter(a[i], b[i], color='blue')

xl = np.linspace(0, 1, 150)
g = (-1*theta[0]/theta[1])*xl - (theta[2]/theta[1])
plt.plot(xl, g)
plt.legend(['Boundary','Y=1', 'Y=-1'])
plt.show()

plt.figure()
plt.xlabel('Iteration')
plt.ylabel('Error')
plt.title('Binary Classification Error')
plt.plot(itr, err)
plt.show()

plt.figure()
plt.xlabel('Iteration')
plt.ylabel('Error')
plt.title('Perceptron Error')
plt.plot(itr, loss)
plt.show()