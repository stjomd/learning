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
    
}
