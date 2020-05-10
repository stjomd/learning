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
The right child is always above, and the left always below, its parent in this diagram.

## Implemented binary trees

### [**Binary Tree**](https://github.com/stjomd/learning/blob/master/Learning/Data%20Structures/Trees/BinaryTree.swift)
Case | Space | Search | Insertion | Deletion
:---- | :------: | :-------: | :--------: | :--------:
Average | O(*n*) | O(*n*) | O(1)* | O(1)*
Worst | O(*n*) | O(*n*) | O(1)* | O(1)*

* Insertion and deletion on the wrapper (`BinaryTree` class) is not supported – children have to be explicitly assigned to nodes.

### [**Binary Search Tree**](https://github.com/stjomd/learning/blob/master/Learning/Data%20Structures/Trees/BinarySearchTree.swift)
Case | Space | Search | Insertion | Deletion
:---- | :------: | :-------: | :--------: | :--------:
Average | O(*n*) | O(log *n*) | O(log *n*) | O(log *n*)
Worst | O(*n*) | O(*n*) | O(*n*) | O(*n*)

### [**Binary Heap**](https://github.com/stjomd/learning/blob/master/Learning/Data%20Structures/Trees/Heap.swift)
Case | Space | Search | Insertion | Deletion
:---- | :------: | :-------: | :--------: | :--------:
Best | O(*n*) | O(1) | O(1) | O(1)
Average | O(*n*) | O(*n*) | O(log *n*) | O(log *n*)
Worst | O(*n*) | O(*n*) | O(log *n*) | O(log *n*)

Does not conform to `AnyBinaryTree`, but has a `tree` property that returns a `BinaryTree` object.
