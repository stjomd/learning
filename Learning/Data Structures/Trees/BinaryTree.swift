//
//  BinaryTree.swift
//  Learning
//
//  Created by Artem Zhukov on 08.05.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

class BinaryTreeNode<T: Comparable> {
    
    typealias Node = BinaryTreeNode<T>
    
    /// The value of the node.
    var value: T
    /// The left child of the node.
    var leftChild: Node?
    /// The right child of the node.
    var rightChild: Node?
    /// The parent node of the node.
    weak var parent: Node?
    
    /// Creates a node with the given value.
    /// - Parameter key: The value of the node.
    /// - Complexity: O(1)
    init(_ value: T) {
        self.value = value
    }
    
}

class BinaryTree<T: Comparable> {
    
    typealias Node = BinaryTreeNode<T>
    
    /// The root of the binary tree.
    private(set) var root: Node?
    
    /// The amount of elements (nodes) in the binary tree.
    /// - Complexity: O(1)
    private(set) var count = 0
    /// A Boolean value indicating whether the binary tree is empty.
    /// - Complexity: O(1)
    var isEmpty: Bool {
        return count == 0
    }
    
    /// An array of objects traversed in-order.
    ///
    /// In-order traversal first traverses the left subtree, then the root, and then the right subtree.
    /// - Complexity: O(*n*)
    var inOrderTraversal: [T] {
        var array: [T] = []
        traverseInOrder(startingWith: root, action: { array.append($0) })
        return array
    }
    /// An array of objects traversed pre-order.
    ///
    /// Pre-order traversal first traverses the root, then the left subtree, and then the right subtree.
    /// - Complexity: O(*n*)
    var preOrderTraversal: [T] {
        var array: [T] = []
        traversePreOrder(startingWith: root, action: { array.append($0) })
        return array
    }
    /// An array of objects traversed post-order.
    ///
    /// Post-order traversal first traverses the left subtree, then the right subtree, and then the root.
    /// - Complexity: O(*n*)
    var postOrderTraversal: [T] {
        var array: [T] = []
        traversePostOrder(startingWith: root, action: { array.append($0) })
        return array
    }
    
    /// Creates a new binary tree with the specified root.
    ///
    /// You will need a root, a `BinaryTreeNode` object, first. Then you can create a binary tree with it.
    ///
    ///     let root = BinaryTreeNode<Int>(15)
    ///     let tree = BinaryTree(root)
    ///
    /// - Complexity: O(1)
    /// - Parameter root: The root node of the binary tree.
    init(_ root: Node) {
        self.root = root
    }
    
}

extension BinaryTree {
    /// The order in which the tree is traversed.
    enum TraversalOrder {
        /// Pre-order traversal first traverses the root, then the left subtree, and then the right subtree.
        case preOrder
        /// In-order traversal first traverses the left subtree, then the root, and then the right subtree.
        case inOrder
        /// Post-order traversal first traverses the left subtree, then the right subtree, and then the root.
        case postOrder
    }
    /// Traverses the tree in the specified order and performs an action on its elements. By default, the tree is traversed in-order.
    ///
    /// - Parameter order: The order in which the tree is traversed. In-order by default.
    /// - Parameter action: A closure that accepts an element of the tree and is called on every element during traversal.
    /// - Complexity: O(*n*)
    func traverse(_ order: TraversalOrder = .inOrder, action: (T) -> ()) {
        switch order {
            case .preOrder:
                traversePreOrder(startingWith: root, action: action)
            case .inOrder:
                traverseInOrder(startingWith: root, action: action)
            case .postOrder:
                traversePostOrder(startingWith: root, action: action)
        }
    }
    private func traverseInOrder(startingWith node: Node?, action: (T) -> ()) {
        if let node = node {
            traverseInOrder(startingWith: node.leftChild, action: action)
            action(node.value)
            traverseInOrder(startingWith: node.rightChild, action: action)
        }
    }
    private func traversePreOrder(startingWith node: Node?, action: (T) -> ()) {
        if let node = node {
            action(node.value)
            traversePreOrder(startingWith: node.leftChild, action: action)
            traversePreOrder(startingWith: node.rightChild, action: action)
        }
    }
    private func traversePostOrder(startingWith node: Node?, action: (T) -> ()) {
        if let node = node {
            traversePostOrder(startingWith: node.leftChild, action: action)
            traversePostOrder(startingWith: node.rightChild, action: action)
            action(node.value)
        }
    }
}
