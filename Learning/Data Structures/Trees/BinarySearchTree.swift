//
//  BinarySearchTree.swift
//  Learning
//
//  Created by Artem Zhukov on 29.04.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

// MARK: - Node
/// A node in the binary search tree.
///
/// A node in a binary search tree contains a key – a special value according to which the elements are sorted. Therefore the type of the key should conform to `Comparable`. Apart from that, a node keeps links to its left and right child, as well as the parent node.
///
/// You can create a tree yourself just using objects of this class, however you'll have to manage addition and deletion yourself. To avoid that, create a `BinarySearchTree` object. That class is a wrapper for this class and manages addition and deletion.
class BinarySearchTreeNode<T: Comparable> {
    
    typealias Node = BinarySearchTreeNode<T>
    
    /// The value according to which the items in the binary search tree are sorted.
    ///
    /// If your type groups several attributes, make it conform to `Comparable` and implement the `<` operator by comparing against the appropriate attribute. This `key` will then contain your entire object, but sorting will be performed by the attribute of your choice.
    var key: T
    /// The left child of this node.
    var leftChild: Node?
    /// The right child of this node.
    var rightChild: Node?
    /// The parent node of this node.
    weak var parent: Node?
    
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
    
    /// Creates a binary search tree node with the given key.
    /// - Parameter key: The key of the node.
    /// - Complexity: O(1)
    init(_ key: T) {
        self.key = key
    }
    
    /// Looks up and returns the node with the given key in the subtree for which this node is the root.
    /// - Parameter key: The key to be found.
    /// - Returns: The node with the specified key or `nil` if it's not present.
    /// - Complexity: O(log *n*) on average, O(*n*) in worst case.
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

// MARK: - Tree
/// A binary tree that stores its elements in such a way that all elements smaller than the root are stored in the left subtree, and all elements larger or equal to the root in the right subtree.
///
/// This tree does not rebalance itself, therefore the order in which elements are added is important. If elements are inserted in sorted order, the tree degrades to a doubly linked list.
class BinarySearchTree<T: Comparable> {
    
    typealias Node = BinarySearchTreeNode<T>
    
    /// The root of the binary search tree.
    private(set) var root: Node?
    
    /// The amount of elements (nodes) in the tree.
    /// - Complexity: O(1)
    private(set) var count = 0
    /// A Boolean value indicating whether the tree is empty.
    /// - Complexity: O(1)
    var isEmpty: Bool {
        return count == 0
    }
    
    /// The smallest element in the tree.
    ///
    /// This element is the leftmost node in the tree.
    /// - Complexity: O(log *n*)
    var minimum: T? {
        root?.minimum?.key
    }
    /// The largest element in the tree.
    ///
    /// This element is the rightmost node in the tree.
    /// - Complexity: O(log *n*)
    var maximum: T? {
        root?.maximum?.key
    }
    
    /// An array of objects traversed in-order. For a binary search tree this is also a sorted array of all objects in the tree.
    ///
    /// In-order traversal first traverses the left subtree, then the root, and then the right subtree.
    /// - Complexity: O(*n*)
    var inOrderTraversal: [T] {
        var array: [T] = []
        traverseInOrder(startingWith: root, action: { array.append($0) })
        return array
    }
    /// An array of objects traversed pre-order.
    ///
    /// Pre-order traversal first traverses the root, then the left subtree, and then the right subtree.
    /// - Complexity: O(*n*)
    var preOrderTraversal: [T] {
        var array: [T] = []
        traversePreOrder(startingWith: root, action: { array.append($0) })
        return array
    }
    /// An array of objects traversed post-order.
    ///
    /// Post-order traversal first traverses the left subtree, then the right subtree, and then the root.
    /// - Complexity: O(*n*)
    var postOrderTraversal: [T] {
        var array: [T] = []
        traversePostOrder(startingWith: root, action: { array.append($0) })
        return array
    }
    
    /// Creates a new, empty binary search tree.
    /// - Complexity: O(1)
    init() {
    }
    
    /// Inserts a node to the tree in the appropriate location.
    ///
    /// - Parameter node: The node to be inserted.
    /// - Complexity: O(log *n*) on average, O(*n*) in worst case.
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
    /// Inserts an element to the tree in the appropriate location.
    ///
    /// - Parameter key: The element to be inserted.
    /// - Complexity: O(log *n*) on average, O(*n*) in worst case.
    func add(_ key: T) {
        let node = Node(key)
        add(node)
    }
    
    /// Looks up and returns the node with the given key in the subtree for which this node is the root.
    /// - Parameter key: The key to be found.
    /// - Returns: The node with the specified key or `nil` if it's not present.
    /// - Complexity: O(log *n*) on average, O(*n*) in worst case.
    func search(_ key: T) -> Node? {
        root?.search(for: key)
    }
    
    /// Removes a node from the tree.
    /// - Parameter node: The node to be removed from the tree.
    /// - Complexity: O(log *n*) on average, O(*n*) in worst case.
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
    /// Removes an element from the tree.
    /// - Parameter node: The element to be removed from the tree.
    /// - Complexity: O(log *n*) on average, O(*n*) in worst case.
    func remove(_ key: T) {
        let node = search(key)
        assert(node != nil, "The key to be removed is not present in the tree")
        remove(node!)
    }
    
}

// MARK: - Traversals
extension BinarySearchTree {
    /// The order in which the tree is traversed.
    enum TraversalOrder {
        /// Pre-order traversal first traverses the root, then the left subtree, and then the right subtree.
        case preOrder
        /// In-order traversal first traverses the left subtree, then the root, and then the right subtree.
        case inOrder
        /// Post-order traversal first traverses the left subtree, then the right subtree, and then the root.
        case postOrder
    }
    /// Traverses the tree in the specified order and performs an action on its elements. By default, the tree is traversed in-order.
    ///
    /// - Parameter order: The order in which the tree is traversed. In-order by default.
    /// - Parameter action: A closure that accepts an element of the tree and is called on every element during traversal.
    /// - Complexity: O(*n*)
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

// MARK: - Miscellaneous
extension BinarySearchTreeNode: CustomStringConvertible where T: CustomStringConvertible {
    var description: String {
        var str: [[Character]] = []
        printTree(&str, 0)
        for line in 0..<str.count {
            let first = str[line][0]
            if first != "│" && first != "┌" && first != "└" {
                str[line] = "──── " + str[line]
            } else {
                str[line] = "     " + str[line]
            }
        }
        for col in stride(from: 0, to: 100, by: 5) {
            var removing = true
            for row in 0..<str.count {
                if col >= str[row].count {
                    removing = true
                    continue
                }
                if str[row][col] == "┌" {
                    removing = false
                }
                if removing && str[row][col] == "│" {
                    str[row][col] = " "
                } else if removing {
                    removing = false
                }
                if str[row][col] == "└" {
                    removing = true
                }
            }
        }
        return String(str.joined(separator: ""))
    }
    func printTree(_ str: inout [[Character]], _ k: Int, _ indent: String = "") {
        rightChild?.printTree(&str, k+1,
                              /*(k != 0 ? "│" : "") +*/ ((k != 0) ? String(repeating: "│    ", count: k) : "") + "┌─── ")
        
        str += [Array<Character>(indent + self.key.description + "\n")]
        
        leftChild?.printTree(&str, k+1,
                             /*(k != 0 ? "│" : "") +*/ ((k != 0) ? String(repeating: "│    ", count: k) : "") + "└─── ")
    }

}
extension BinarySearchTree: CustomStringConvertible where T: CustomStringConvertible {
    var description: String {
        return root?.description ?? "──── nil"
    }
}
