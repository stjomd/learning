#  Binary Trees

## Usage
For visualising a binary tree, pass the tree object to the `print` function. The complexity should be O(*n*^2), I might be mistaken though. 
```swift
var tree = BinarySearchTree<Character>()
tree.add("p")
tree.add("h")
tree.add("g")
tree.add("j")
tree.add("r")
tree.add("v")
tree.add("q")
tree.add("k")
```
`print(tree)` would print the following to the console:
```
          ┌─── v
     ┌─── r
     │    └─── q
──── p
     │         ┌─── k
     │    ┌─── j
     └─── h
          └─── g
```

## Implemented binary trees

### [**Binary search tree**](https://github.com/stjomd/learning/blob/master/Learning/Data%20Structures/Trees/BinarySearchTree.swift)
Case | Space | Search | Insertion | Deletion
:---- | :------: | :-------: | :--------: | :--------:
Average | O(*n*) | O(log *n*) | O(log *n*) | O(log *n*)
Worst | O(*n*) | O(*n*) | O(*n*) | O(*n*)
