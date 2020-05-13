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
    
    init(_ value: Element) {
        self.value = value
    }
    
    fileprivate func rotateRight(/*_ node: Node*/) -> Node {
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
