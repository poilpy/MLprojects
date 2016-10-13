import numpy as np
from sklearn.datasets import load_iris
from sklearn import tree
iris = load_iris()

testIdx = [0, 50, 100]

# training data
trainY = np.delete(iris.target, testIdx)
trainX = np.delete(iris.data, testIdx, axis=0)

# testing data
testY = iris.target[testIdx]
testX = iris.data[testIdx]

# training with decision tree
clf = tree.DecisionTreeClassifier()
clf.fit(trainX, trainY)

# test
print testY
print clf.predict(testX)


# pdf visualization 
import pydotplus
dot_data = tree.export_graphviz(clf, out_file=None) 
graph = pydotplus.graph_from_dot_data(dot_data) 
graph.write_pdf("iris.pdf") 

from IPython.display import Image
dot_data = tree.export_graphviz(clf, out_file=None, 
                         feature_names=iris.feature_names,  
                         class_names=iris.target_names,  
                         filled=True, rounded=True,  
                         special_characters=True)  
graph = pydotplus.graph_from_dot_data(dot_data)  
Image(graph.create_png())  