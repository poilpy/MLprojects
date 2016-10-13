from sklearn import tree
features = [[140, 1], [130, 1], [160, 0], [170, 0]]
labels = ['apple', 'apple', 'orange', 'orange']

clf = tree.DecisionTreeClassifier()
clf.fit(features, labels)

print clf.predict([[150, 0]])
