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
    
    var height: Int {
        return 0
        // TODO: stored property
    }
    
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
    
    init(_ value: Element) {
        self.value = value
    }
    
}

class AVLTree<Element: Comparable>: AnyBinaryTree {
    
    typealias Node = AVLTreeNode<Element>
    
    private(set) var root: Node?
    private(set) var count: Int = 0
    
    func add(_ item: Element) {
        let node = Node(item)
        add(node)
        //balance(child) TODO: rebalancing
    }
    private func add(_ node: Node) {
        var r: Node? = nil, p = root
        while let pp = p {
            r = p
            if node.value < pp.value {
                p = pp.leftChild
            } else {
                p = pp.rightChild
            }
        }
        node.parent = r
        node.leftChild = nil
        node.rightChild = nil
        if let rr = r {
            if node.value < rr.value {
                rr.leftChild = node
            } else {
                rr.rightChild = node
            }
        } else {
            root = node
        }
        count += 1
    }
    
}

extension AVLTreeNode: StringConvertibleBinarySubtree where Element: CustomStringConvertible {}
extension AVLTreeNode: CustomStringConvertible where Element: CustomStringConvertible {}

extension AVLTree: CustomStringConvertible where Element: CustomStringConvertible {
    var description: String {
        root?.description ?? "──── nil"
    }
}
