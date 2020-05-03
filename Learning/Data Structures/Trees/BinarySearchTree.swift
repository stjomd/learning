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
            if current.key > key {
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
    
    private(set) var root: Node?
    
    private(set) var count = 0
    
    var isEmpty: Bool {
        return count == 0
    }
    
    var minimum: T? {
        root?.minimum?.key
    }
    
    var maximum: T? {
        root?.maximum?.key
    }
    
    var inOrderTraversal: [T] {
        var array: [T] = []
        traverseInOrder(startingWith: root, action: { array.append($0) })
        return array
    }
    
    var preOrderTraversal: [T] {
        var array: [T] = []
        traversePreOrder(startingWith: root, action: { array.append($0) })
        return array
    }
    
    var postOrderTraversal: [T] {
        var array: [T] = []
        traversePostOrder(startingWith: root, action: { array.append($0) })
        return array
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
        count += 1
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
        count -= 1
    }
    
    func remove(_ key: T) {
        let node = search(key)
        assert(node != nil, "The key to be removed is not present in the tree")
        remove(node!)
    }
    
}

// MARK: - Traversals
extension BinarySearchTree {
    enum TraversalOrder {
        case preOrder
        case inOrder
        case postOrder
    }
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
            action(node.key)
            traverseInOrder(startingWith: node.rightChild, action: action)
        }
    }
    private func traversePreOrder(startingWith node: Node?, action: (T) -> ()) {
        if let node = node {
            action(node.key)
            traversePreOrder(startingWith: node.leftChild, action: action)
            traversePreOrder(startingWith: node.rightChild, action: action)
        }
    }
    private func traversePostOrder(startingWith node: Node?, action: (T) -> ()) {
        if let node = node {
            traversePostOrder(startingWith: node.leftChild, action: action)
            traversePostOrder(startingWith: node.rightChild, action: action)
            action(node.key)
        }
    }
}
