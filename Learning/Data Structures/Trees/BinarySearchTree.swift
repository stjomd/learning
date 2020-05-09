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
class BinarySearchTreeNode<T: Comparable>: BinaryTreeNodePr {
    
    typealias Node = BinarySearchTreeNode<T>
    
    /// The value according to which the items in the binary search tree are sorted.
    ///
    /// If your type groups several attributes, make it conform to `Comparable` and implement the `<` operator by comparing against the appropriate attribute. This `key` will then contain your entire object, but sorting will be performed by the attribute of your choice.
    var value: T
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
    init(_ value: T) {
        self.value = value
    }
    
    /// Looks up and returns the node with the given key in the subtree for which this node is the root.
    /// - Parameter key: The key to be found.
    /// - Returns: The node with the specified key or `nil` if it's not present.
    /// - Complexity: O(log *n*) on average, O(*n*) in worst case.
    func search(for key: T) -> Node? {
        var currentNode: Node? = self
        while let current = currentNode, current.value != value {
            if current.value > value {
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
class BinarySearchTree<T: Comparable>: BinaryTreePr {
    
    typealias Node = BinarySearchTreeNode<T>
    
    // MARK: Properties
    
    /// The root of the binary search tree.
    private(set) var root: Node?
    
    /// The amount of elements (nodes) in the tree.
    /// - Complexity: O(1)
    private(set) var count = 0
    /// A Boolean value indicating whether the tree is empty.
    /// - Complexity: O(1)
//    var isEmpty: Bool {
//        return count == 0
//    }
    
    /// The smallest element in the tree.
    ///
    /// This element is the leftmost node in the tree.
    /// - Complexity: O(log *n*)
    var minimum: T? {
        root?.minimum?.value
    }
    /// The largest element in the tree.
    ///
    /// This element is the rightmost node in the tree.
    /// - Complexity: O(log *n*)
    var maximum: T? {
        root?.maximum?.value
    }
    
    // MARK: Initializers
    
    /// Creates a new, empty binary search tree.
    /// - Complexity: O(1)
    init() {
    }
    
    /// Creates a new binary search tree and inserts elements from the array (in the respective order) into it.
    /// - Complexity: O(*n* log *n*) on average, O(*n*^2) in worst case.
    init(_ array: [T]) {
        for element in array {
            add(element)
        }
    }
    
    /// Creates a new binary search tree and inserts elements that are passed to the initializer in the same order into the tree.
    /// - Complexity: O(*n* log *n*) on average, O(*n*^2) in worst case.
    convenience init(_ items: T...) {
        self.init(items)
    }
    
    // MARK: Methods
    
    /// Inserts a node to the tree in the appropriate location.
    ///
    /// - Parameter node: The node to be inserted.
    /// - Complexity: O(log *n*) on average, O(*n*) in worst case.
    func add(_ node: Node) {
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
            node.value = r!.value
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

// MARK: - Miscellaneous
//extension BinarySearchTreeNode: CustomStringConvertible where T: CustomStringConvertible {
//    /// A horizontal textual representation of the binary search tree.
//    ///
//    /// Accessing the property directly is not advised. Apple recommends to use the `String(describing:)` initializer instead. You can also pass the tree object to the `print` function.
//    ///
//    ///     let tree = BinarySearchTree<Character>("p", "h", "g", "j", "r", "v", "q", "k")
//    ///     print(tree)
//    ///     // Prints:
//    ///     //           ┌─── v
//    ///     //      ┌─── r
//    ///     //      │    └─── q
//    ///     // ──── p
//    ///     //      │         ┌─── k
//    ///     //      │    ┌─── j
//    ///     //      └─── h
//    ///     //           └─── g
//    ///
//    /// The right child in this diagram is always above its parent, and the left child is always below.
//    ///
//    /// - Complexity: O(*n*^2)
//    var description: String {
//        var string: [[Character]] = []
//        constructString(&string, 0) // O(nlogn)
//        clean(string: &string)
//        return String(string.joined(separator: "\n"))
//        // O(nlogn + n^2) = O(n^2)
//    }
//    private func constructString(_ str: inout [[Character]], _ indentDepth: Int, _ indent: String = "") { // O(nlogn)
//        rightChild?.constructString(&str, indentDepth+1, ((indentDepth != 0) ? String(repeating: "│    ", count: indentDepth) : "") + "┌─── ")
//        str += [Array<Character>(indent + self.value.description)] // O(log n)
//        leftChild?.constructString(&str,  indentDepth+1, ((indentDepth != 0) ? String(repeating: "│    ", count: indentDepth) : "") + "└─── ")
//    }
//
//}
//extension BinarySearchTree: CustomStringConvertible where T: CustomStringConvertible {
//    var description: String {
//        return root?.description ?? "──── nil"
//    }
//}

extension BinarySearchTreeNode: CustomStringConvertible where T: CustomStringConvertible {
}
extension BinarySearchTreeNode: StringConvertibleBinaryTree where T: CustomStringConvertible {
}

extension BinarySearchTree: CustomStringConvertible where T: CustomStringConvertible {
    var description: String {
        return root?.description ?? "──── nil"
    }
}
