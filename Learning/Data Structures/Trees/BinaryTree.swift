//
//  BinaryTree.swift
//  Learning
//
//  Created by Artem Zhukov on 08.05.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

// MARK: - Node
class BinaryTreeNode<T>: BinaryTreeNodePr {
    
    //typealias Node = BinaryTreeNode<T>
    
    /// The value of the node.
    var value: T
    /// The left child of the node.
    var leftChild: BinaryTreeNode<T>?
    /// The right child of the node.
    var rightChild: BinaryTreeNode<T>?
    /// The parent node of the node.
    weak var parent: BinaryTreeNode<T>?
    
    /// Creates a node with the given value.
    /// - Parameter key: The value of the node.
    /// - Complexity: O(1)
    init(_ value: T) {
        self.value = value
    }
    
}

// MARK: - Tree
class BinaryTree<T>: BinaryTreePr {
    
    typealias Node = BinaryTreeNode<T>
    
    // MARK: Properties
    
    /// The root of the binary tree.
    private(set) var root: Node?
    
    /// The amount of elements (nodes) in the binary tree.
    /// - Complexity: O(1)
    var count: Int {
        return inOrderTraversal.count
    }
    
    // MARK: - Initializers
    
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

extension BinaryTreeNode: StringConvertibleBinaryTree where T: CustomStringConvertible {}
extension BinaryTreeNode: CustomStringConvertible where T: CustomStringConvertible {}

extension BinaryTree: CustomStringConvertible where T: CustomStringConvertible {
    var description: String {
        return root?.description ?? "──── nil"
    }
}
