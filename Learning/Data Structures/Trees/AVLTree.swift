//
//  AVLTree.swift
//  Learning
//
//  Created by Artem Zhukov on 12.05.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

// TODO: Investigate this. Bug occurs on deletion only, all properties are set correctly before deleting.
//let l = 15
//var avl = AVLTree<Int>()
//
//var fff = [5, 13, 2, 6, 14, 3, 12, 7, 10, 4, 11, 8, 9, 15, 1]
//
//for i in fff {
//    avl.add(i)
//}
//print(avl)
//print("@@@@@@@@@@@@@\n\n\n")
//
//for i in stride(from: avl.count, to: avl.count/2, by: -1) {
//    print("Deleting \(i)")
//    avl.remove(i)
//    print(avl)
//    print("///////\n\n")
//}
//
//for j in 1...avl.count {
//    let g = avl.search(for: j)!
//    let p1 = g.parent?.value ?? -1
//    let pOK = avl.correctParent(of: g)?.value ?? -1
//    assert(p1 == pOK, "nnn")
//    print("\(j)'s parent: \(p1)\t\t(\((pOK == p1) ? "GOOD" : "WRONG, parent = \(pOK)"))")
//}

// MARK: - Node
class AVLTreeNode<Element: Comparable>: AnyBinaryTreeNode {
    
    typealias Node = AVLTreeNode<Element>
    
    // MARK: Properties
    
    var value: Element
    
    var leftChild: Node? {
        willSet {
            newValue?.parent = self
        }
    }
    
    var rightChild: Node? {
        willSet {
            newValue?.parent = self
        }
    }
    
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
    
    // MARK: Methods
    
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

// MARK: - Tree
class AVLTree<Element: Comparable>: AnyBinaryTree {
    
    typealias Node = AVLTreeNode<Element>
    
    private(set) var root: Node?
    private(set) var count: Int = 0
    
    func add(_ item: Element) {
        let node = Node(item)
        add(node, at: &root)
        root?.parent = nil
        count += 1
    }
    private func add(_ node: Node, at startingNode: inout Node?) {
        if var _ = startingNode {
            if node.value < startingNode!.value {
                add(node, at: &startingNode!.leftChild)
                rebalance(&startingNode!)
            } else if node.value >= startingNode!.value {
                add(node, at: &startingNode!.rightChild)
                rebalance(&startingNode!)
            }
        } else {
            startingNode = node
        }
        startingNode!.height = max(height(startingNode!.leftChild), height(startingNode!.rightChild)) + 1
    }
    
    func search(for item: Element) -> Node? {
        root?.search(for: item)
    }
    
    func remove(_ item: Element) {
        assert(!isEmpty, "The AVL tree is empty")
        guard let node = search(for: item) else {
            assertionFailure("The item is not present in the AVL tree")
            return
        }
        remove(node)
        count -= 1
    }
    private func remove(_ node: Node) {
        if node.leftChild == nil && node.rightChild == nil {
            if let parent = node.parent {
                if parent.leftChild === node {
                    node.parent?.leftChild = nil
                } else if parent.rightChild === node {
                    node.parent?.rightChild = nil
                } else {
                    assertionFailure("Invalid tree")
                }
                rebalance(&node.parent!)
            } else {
                root = nil
            }
        } else {
            if let predecessor = node.predecessor {
                node.value = predecessor.value
                remove(predecessor)
            } else if let successor = node.successor {
                node.value = successor.value
                remove(successor)
            }
        }
    }
    
    private func rebalance(_ node: inout Node) {
        if node.balance == -2 {
            if height(node.leftChild?.leftChild) >= height(node.leftChild?.rightChild) {
                node = node.rotateRight()
            } else {
                node.leftChild = node.leftChild?.rotateLeft()
                node = node.rotateRight()
            }
        } else if node.balance == 2 {
            if height(node.rightChild?.rightChild) >= height(node.rightChild?.leftChild) {
                node = node.rotateLeft()
            } else {
                node.rightChild = node.rightChild?.rotateRight()
                node = node.rotateLeft()
            }
        }
    }
    
    private func height(_ node: Node?) -> Int {
        if let node = node {
            return node.height
        } else {
            return -1
        }
    }
    
    func correctParent(of node: Node) -> Node? {
        var prev: Node? = nil
        var currentNode: Node? = root
        while let current = currentNode, current.value != node.value {
            prev = currentNode
            if current.value > node.value {
                currentNode = currentNode?.leftChild
            } else {
                currentNode = currentNode?.rightChild
            }
        }
        return prev
    }
    
}


// MARK: - CustomStringConvertible
extension AVLTreeNode: StringConvertibleBinarySubtree where Element: CustomStringConvertible {}
extension AVLTreeNode: CustomStringConvertible where Element: CustomStringConvertible {}

extension AVLTree: CustomStringConvertible where Element: CustomStringConvertible {
    var description: String {
        root?.description ?? "──── nil"
    }
}
