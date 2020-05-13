//
//  AVLTree.swift
//  Learning
//
//  Created by Artem Zhukov on 12.05.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

class AVLTreeNode<Element: Comparable>: AnyBinaryTreeNode {
    
    typealias Node = AVLTreeNode<Element>
    
    var value: Element
    
    var leftChild: Node?
    
    var rightChild: Node?
    
    var parent: Node?
    
    var height: Int = 0
    
    var balance: Int {
        return height(rightChild) - height(leftChild)
    }
    
    /// The node with the smallest key in the subtree for which this node is the root.
    ///
    /// In other words, this is the leftmost node in the binary search subtree.
    /// - Complexity: O(log *n*)
    var minimum: Node? {
        var currentNode: Node? = self
        while let _ = currentNode?.leftChild {
            currentNode = currentNode?.leftChild
        }
        return currentNode
    }
    /// The node with the largest key in the subtree for which this node is the root.
    ///
    /// In other words, this is the rightmost node in the binary search subtree.
    /// - Complexity: O(log *n*)
    var maximum: Node? {
        var currentNode: Node? = self
        while let _ = currentNode?.rightChild {
            currentNode = currentNode?.rightChild
        }
        return currentNode
    }
    /// The node with the largest key that is smaller than the key of this node.
    ///
    /// In other words, this is the maximum of the left subtree.
    /// - Complexity: O(log *n*)
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
    /// The node with the smallest key that is larger than the key of this node.
    ///
    /// In other words, this is the minimum of the right subtree.
    /// - Complexity: O(log *n*)
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
    
    init(_ value: Element) {
        self.value = value
    }
    
    func search(for item: Element) -> Node? {
        var currentNode: Node? = self
        while let current = currentNode, current.value != item {
            if current.value > item {
                currentNode = currentNode?.leftChild
            } else {
                currentNode = currentNode?.rightChild
            }
        }
        return currentNode
    }
    
    fileprivate func rotateRight() -> Node {
        let v = self.leftChild!
        self.leftChild = v.rightChild
        v.rightChild = self
        self.height = max(height(self.leftChild), height(self.rightChild)) + 1
        v.height = max(height(v.leftChild), height(v.rightChild)) + 1
        return v
    }
    
    fileprivate func rotateLeft() -> Node {
        let v = self.rightChild!
        self.rightChild = v.leftChild
        v.leftChild = self
        self.height = max(height(self.leftChild), height(self.rightChild)) + 1
        v.height = max(height(v.leftChild), height(v.rightChild)) + 1
        return v
    }
    
    private func height(_ node: Node?) -> Int {
        if let node = node {
            return node.height
        } else {
            return -1
        }
    }
    
}

class AVLTree<Element: Comparable>: AnyBinaryTree {
    
    typealias Node = AVLTreeNode<Element>
    
    private(set) var root: Node?
    private(set) var count: Int = 0
    
    func add(_ item: Element) {
        let node = Node(item)
        add(node, at: &root)
    }
    private func add(_ node: Node, at startingNode: inout Node?) {
        if startingNode != nil {
            if node.value < startingNode!.value {
                add(node, at: &startingNode!.leftChild)
                if startingNode!.balance == -2 {
                    if height(startingNode?.leftChild?.leftChild) >= height(startingNode?.leftChild?.rightChild) {
                        startingNode = startingNode!.rotateRight()
                    } else {
                        startingNode!.leftChild = startingNode!.leftChild?.rotateLeft()
                        startingNode = startingNode!.rotateRight()
                    }
                }
            } else if node.value >= startingNode!.value {
                add(node, at: &startingNode!.rightChild)
                if startingNode!.balance == 2 {
                    if height(startingNode?.rightChild?.rightChild) >= height(startingNode?.rightChild?.leftChild) {
                        startingNode = startingNode!.rotateLeft()
                    } else {
                        startingNode!.rightChild = startingNode!.rightChild?.rotateRight()
                        startingNode = startingNode!.rotateLeft()
                    }
                }
            }
        } else {
            startingNode = node
        }
        startingNode!.height = max(height(startingNode!.leftChild), height(startingNode!.rightChild)) + 1
        count += 1
    }
    
    func search(for item: Element) -> Node? {
        root?.search(for: item)
    }
    
    private func height(_ node: Node?) -> Int {
        if let node = node {
            return node.height
        } else {
            return -1
        }
    }
    
}

extension AVLTreeNode: StringConvertibleBinarySubtree where Element: CustomStringConvertible {}
extension AVLTreeNode: CustomStringConvertible where Element: CustomStringConvertible {}

extension AVLTree: CustomStringConvertible where Element: CustomStringConvertible {
    var description: String {
        root?.description ?? "──── nil"
    }
}
