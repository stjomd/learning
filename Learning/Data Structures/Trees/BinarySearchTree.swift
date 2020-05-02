//
//  BinarySearchTree.swift
//  Learning
//
//  Created by Artem Zhukov on 29.04.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

class BinarySearchTree<T: Comparable> {
    
    class TreeNode<T> {
        
        var key: T
        var leftChild: TreeNode<T>?
        var rightChild: TreeNode<T>?
        
        init(_ key: T) {
            self.key = key
        }
        
        func add(_ node: Node) {
//            if node.key < self.key {
//
//            }
        }
        
    }
    typealias Node = TreeNode<T>
    
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
