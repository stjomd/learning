//
//  AVLTree.swift
//  Learning
//
//  Created by Artem Zhukov on 12.05.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

class AVLTreeNode<T>: BinarySearchTreeNode<T> where T: Comparable {
    var balance: Int {
        var leftHeight = 0, rightHeight = 0
        var currentNode = leftChild
        while let _ = currentNode?.leftChild {
            leftHeight += 1
            currentNode = currentNode?.leftChild
        }
        currentNode = rightChild
        while let _ = currentNode?.rightChild {
            rightHeight += 1
            currentNode = currentNode?.rightChild
        }
        return rightHeight - leftHeight
    }
}

class AVLTree<Element: Comparable>: AnyBinaryTree {
    
    typealias Node = AVLTreeNode<Element>
    
    private(set) var root: Node?
    private(set) var count: Int = 0
    
    func add(_ item: Element) {
        //
    }
    
}
