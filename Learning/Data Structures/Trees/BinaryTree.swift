//
//  BinaryTree.swift
//  Learning
//
//  Created by Artem Zhukov on 27.04.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

struct BinaryTree<T> {
    
    class BinaryTreeNode<T> {
        var value: T
        var leftChild: BinaryTreeNode<T>?
        var rightChild: BinaryTreeNode<T>?
        init(_ value: T) {
            self.value = value
        }
    }
    typealias Node = BinaryTreeNode<T>
    
    var root: Node?
    
}
