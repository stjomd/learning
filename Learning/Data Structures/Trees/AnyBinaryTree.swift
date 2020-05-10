//
//  AnyBinaryTree.swift
//  Learning
//
//  Created by Artem Zhukov on 09.05.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

// MARK: - Node
protocol AnyBinaryTreeNode {
    associatedtype Element
    associatedtype Node = Self
    var value: Element { get set }
    var leftChild: Node? { get set }
    var rightChild: Node? { get set }
    var parent: Node? { get set }
}

// MARK: - Tree
protocol AnyBinaryTree {
    associatedtype Element
    associatedtype Node where Node: AnyBinaryTreeNode
    var root: Node? { get }
    var count: Int { get }
    var isEmpty: Bool { get }
    var inOrderTraversal: [Element] { get }
    var preOrderTraversal: [Element] { get }
    var postOrderTraversal: [Element] { get }
    func traverse(_ order: TraversalOrder, action: (Element) -> ())
}
// MARK: Property implementations
extension AnyBinaryTree {
    var isEmpty: Bool {
        return count == 0
    }
    var inOrderTraversal: [Element] {
        var array: [Element] = []
        traverseInOrder(startingWith: root, action: { array.append($0) })
        return array
    }
    var preOrderTraversal: [Element] {
        var array: [Element] = []
        traversePreOrder(startingWith: root, action: { array.append($0) })
        return array
    }
    var postOrderTraversal: [Element] {
        var array: [Element] = []
        traversePostOrder(startingWith: root, action: { array.append($0) })
        return array
    }
}
// MARK: Method implementations
extension AnyBinaryTree {
    func traverse(_ order: TraversalOrder, action: (Element) -> ()) {
        switch order {
            case .preOrder:
                traversePreOrder(startingWith: root, action: action)
            case .inOrder:
                traverseInOrder(startingWith: root, action: action)
            case .postOrder:
                traversePostOrder(startingWith: root, action: action)
        }
    }
    private func traverseInOrder(startingWith node: Node?, action: (Element) -> ()) {
        if let node = node {
            traverseInOrder(startingWith: node.leftChild as? Node, action: action)
            action(node.value as! Element)
            traverseInOrder(startingWith: node.rightChild as? Node, action: action)
        }
    }
    private func traversePreOrder(startingWith node: Node?, action: (Element) -> ()) {
        if let node = node {
            action(node.value as! Element)
            traversePreOrder(startingWith: node.leftChild as? Node, action: action)
            traversePreOrder(startingWith: node.rightChild as? Node, action: action)
        }
    }
    private func traversePostOrder(startingWith node: Node?, action: (Element) -> ()) {
        if let node = node {
            traversePostOrder(startingWith: node.leftChild as? Node, action: action)
            traversePostOrder(startingWith: node.rightChild as? Node, action: action)
            action(node.value as! Element)
        }
    }
}
enum TraversalOrder {
    /// Pre-order traversal first traverses the root, then the left subtree, and then the right subtree.
    case preOrder
    /// In-order traversal first traverses the left subtree, then the root, and then the right subtree.
    case inOrder
    /// Post-order traversal first traverses the left subtree, then the right subtree, and then the root.
    case postOrder
}

// MARK: - Printability
protocol StringConvertibleBinarySubtree: CustomStringConvertible where Self: AnyBinaryTreeNode, Self.Element: CustomStringConvertible {
}
extension StringConvertibleBinarySubtree {
    /// A horizontal textual representation of the binary search tree.
    ///
    /// Accessing the property directly is not advised. Apple recommends to use the `String(describing:)` initializer instead. You can also pass the tree object to the `print` function.
    ///
    ///     let tree = BinarySearchTree<Character>("p", "h", "g", "j", "r", "v", "q", "k")
    ///     print(tree)
    ///     // Prints:
    ///     //           ┌─── v
    ///     //      ┌─── r
    ///     //      │    └─── q
    ///     // ──── p
    ///     //      │         ┌─── k
    ///     //      │    ┌─── j
    ///     //      └─── h
    ///     //           └─── g
    ///
    /// The right child in this diagram is always above its parent, and the left child is always below.
    ///
    /// - Complexity: O(*n*^2)
    var description: String {
        var string: [[Character]] = []
        constructString(self, &string, 0) // O(nlogn)
        var maxLineLength = 0
        for line in 0..<string.count {  // indent all lines (for a e s t h e t i c s) O(n^2)
            let first = string[line][0]
            if first != "│" && first != "┌" && first != "└" {
                string[line] = "──── " + string[line] // O(n)
            } else {
                string[line] = "     " + string[line] // O(n)
            }
            maxLineLength = max(maxLineLength, string[line].count)
        }
        for col in stride(from: 0, to: maxLineLength, by: 5) { // O(n^2)
            var removing = true
            for row in 0..<string.count {
                if col >= string[row].count {
                    removing = true
                    continue
                }
                let character = string[row][col]
                if col > 0 && character != "│" && character != "┌" && character != "└" && string[row][col-1] != " " {
                    removing = true
                    continue
                }
                if character == "┌" {
                    removing = false
                }
                if removing && character == "│" {
                    string[row][col] = " "
                } else if removing {
                    removing = false
                }
                if character == "└" {
                    removing = true
                }
            }
        }
        return String(string.joined(separator: "\n"))
        // O(nlogn + n^2) = O(n^2)
    }
    private func constructString(_ node: Self?, _ str: inout [[Character]], _ indentDepth: Int, _ indent: String = "") { // O(nlogn)
        if let node = node {
            constructString(node.rightChild as? Self, &str, indentDepth+1, ((indentDepth != 0) ? String(repeating: "│    ", count: indentDepth) : "") + "┌─── ")
            str += [Array<Character>(indent + node.value.description)] // O(log n)
            constructString(node.leftChild as? Self, &str,  indentDepth+1, ((indentDepth != 0) ? String(repeating: "│    ", count: indentDepth) : "") + "└─── ")
        }
    }
}
