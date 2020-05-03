//
//  BinarySearchTree.swift
//  Learning
//
//  Created by Artem Zhukov on 29.04.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

class BinarySearchTreeNode<T: Comparable> {
    
    typealias Node = BinarySearchTreeNode<T>
    
    var key: T
    var leftChild: Node?
    var rightChild: Node?
    
    weak var parent: Node?
    
    var minimum: Node? {
        var currentNode: Node? = self
        while let _ = currentNode?.leftChild {
            currentNode = currentNode?.leftChild
        }
        return currentNode
    }
    
    var maximum: Node? {
        var currentNode: Node? = self
        while let _ = currentNode?.rightChild {
            currentNode = currentNode?.rightChild
        }
        return currentNode
    }
    
    var predecessor: Node? {
        if let subtree = self.leftChild {
            return subtree.maximum
        } else {
            var p = self
            var q: Node? = p.parent
            while let current = q, p === current.leftChild {
                p = current
                q = q?.parent
            }
            return q
        }
    }
    
    var successor: Node? {
        if let subtree = self.rightChild {
            return subtree.minimum
        } else {
            var p = self
            var q: Node? = p.parent
            while let current = q, p === current.rightChild {
                p = current
                q = q?.parent
            }
            return q
        }
    }
    
    init(_ key: T) {
        self.key = key
    }
    
    func search(for key: T) -> Node? {
        var currentNode: Node? = self
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
    
    typealias Node = BinarySearchTreeNode<T>
    
    var root: Node?
    
    var count = 0
    
    var isEmpty: Bool {
        return count == 0
    }
    
    func add(_ node: Node) {
        var r: Node? = nil, p = root
        while let pp = p {
            r = p
            if node.key < pp.key {
                p = pp.leftChild
            } else {
                p = pp.rightChild
            }
        }
        node.parent = r
        node.leftChild = nil
        node.rightChild = nil
        if let rr = r {
            if node.key < rr.key {
                rr.leftChild = node
            } else {
                rr.rightChild = node
            }
        } else {
            root = node
        }
    }
    
    func add(_ key: T) {
        let node = Node(key)
        add(node)
    }
    
    func search(_ key: T) -> Node? {
        root?.search(for: key)
    }
    
    func remove(_ node: Node) {
        var r: Node?
        if node.leftChild == nil || node.rightChild == nil {
            r = node
        } else {
            r = node.successor
            node.key = r!.key
        }
        var p: Node?
        if r?.leftChild != nil {
            p = r?.leftChild
        } else {
            p = r?.rightChild
        }
        if let pp = p {
            pp.parent = r?.parent
        }
        if r?.parent == nil {
            root = p
        } else {
            if r === r?.parent?.leftChild {
                r?.parent?.leftChild = p
            } else {
                r?.parent?.rightChild = p
            }
        }
    }
    
}
