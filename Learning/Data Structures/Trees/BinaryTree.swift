//
//  BinaryTree.swift
//  Learning
//
//  Created by Artem Zhukov on 08.05.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

// MARK: - Node
class BinaryTreeNode<Element>: AnyBinaryTreeNode {
    
    typealias Node = BinaryTreeNode<Element>
        
    /// The value of the node.
    var value: Element
    /// The left child of the node.
    var leftChild: Node? {
        willSet {
            newValue?.parent = self
        }
    }
    /// The right child of the node.
    var rightChild: Node? {
        willSet {
            newValue?.parent = self
        }
    }
    /// The parent node of the node.
    weak var parent: Node?
    
    /// Creates a node with the given value.
    /// - Parameter key: The value of the node.
    /// - Complexity: O(1)
    init(_ value: Element) {
        self.value = value
    }
    
}

// MARK: - Tree
class BinaryTree<Element>: AnyBinaryTree {
    
    typealias Node = BinaryTreeNode<Element>
    
    // MARK: Properties
    
    /// The root of the binary tree.
    private(set) var root: Node?
    
    /// The amount of elements (nodes) in the binary tree.
    /// - Complexity: O(1)
    var count: Int {
        return inOrderTraversal.count
    }
    
    // MARK: Initializers
    
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

extension BinaryTreeNode: StringConvertibleBinarySubtree where Element: CustomStringConvertible {}
extension BinaryTreeNode: CustomStringConvertible where Element: CustomStringConvertible {}

extension BinaryTree: CustomStringConvertible where Element: CustomStringConvertible {
    var description: String {
        return root?.description ?? "──── nil"
    }
}
