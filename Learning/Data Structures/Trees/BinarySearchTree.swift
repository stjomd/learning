//
//  BinarySearchTree.swift
//  Learning
//
//  Created by Artem Zhukov on 29.04.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

class BinaryTreeNode<T: Comparable> {
    
    var key: T
    var leftChild: BinaryTreeNode<T>?
    var rightChild: BinaryTreeNode<T>?
    
    var minimum: BinaryTreeNode<T>? {
        var currentNode: BinaryTreeNode<T>? = self
        while let _ = currentNode?.leftChild {
            currentNode = currentNode?.leftChild
        }
        return currentNode
    }
    
    var maximum: BinaryTreeNode<T>? {
        var currentNode: BinaryTreeNode<T>? = self
        while let _ = currentNode?.rightChild {
            currentNode = currentNode?.rightChild
        }
        return currentNode
    }
    
    init(_ key: T) {
        self.key = key
    }
    
    func add(_ node: BinaryTreeNode<T>) {
        if node.key <= self.key {
            
        }
    }
    
    func search(for key: T) -> BinaryTreeNode<T>? {
        var currentNode: BinaryTreeNode<T>? = self
        while let current = currentNode, current.key != key {
            if current.key <= key {
                currentNode = currentNode?.leftChild
            } else {
                currentNode = currentNode?.rightChild
            }
        }
        return currentNode
    }
    
}

class BinarySearchTree<T: Comparable> {
    
    typealias Node = BinaryTreeNode<T>
    
    var root: Node?
    
    var count = 0
    
    var isEmpty: Bool {
        return count == 0
    }
    
    func add(_ node: Node) {
        guard let root = root else {
            self.root = node
            return
        }
        root.add(node)
        count += 1
    }
    
    func add(_ key: T) {
        let node = Node(key)
        add(node)
    }
    
}
