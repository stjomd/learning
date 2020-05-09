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

// MARK: - Miscellaneous
extension BinaryTreeNode: CustomStringConvertible where T: CustomStringConvertible {
    /// A horizontal textual representation of the binary search tree.
    ///
    /// Accessing the property directly is not advised. Apple recommends to use the `String(describing:)` initializer instead. You can also pass the tree object to the `print` function.
    ///
    ///     let tree = BinarySearchTree<Character>("p", "h", "g", "j", "r", "v", "q", "k")
    ///     print(tree)
    ///     // Prints:
    ///     //           ┌─── v
    ///     //      ┌─── r
    ///     //      │    └─── q
    ///     // ──── p
    ///     //      │         ┌─── k
    ///     //      │    ┌─── j
    ///     //      └─── h
    ///     //           └─── g
    ///
    /// The right child in this diagram is always above its parent, and the left child is always below.
    ///
    /// - Complexity: O(*n*^2)
    var description: String {
        var string: [[Character]] = []
        constructString(&string, 0) // O(nlogn)
        clean(string: &string)
        return String(string.joined(separator: "\n"))
        // O(nlogn + n^2) = O(n^2)
    }
    private func constructString(_ str: inout [[Character]], _ indentDepth: Int, _ indent: String = "") { // O(nlogn)
        rightChild?.constructString(&str, indentDepth+1, ((indentDepth != 0) ? String(repeating: "│    ", count: indentDepth) : "") + "┌─── ")
        str += [Array<Character>(indent + self.value.description)] // O(log n)
        leftChild?.constructString(&str,  indentDepth+1, ((indentDepth != 0) ? String(repeating: "│    ", count: indentDepth) : "") + "└─── ")
    }

}
extension BinaryTree: CustomStringConvertible where T: CustomStringConvertible {
    var description: String {
        return root?.description ?? "──── nil"
    }
}
