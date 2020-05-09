//
//  AnyBinaryTree.swift
//  Learning
//
//  Created by Artem Zhukov on 09.05.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

//protocol BinaryTreeNodePr {
//    associatedtype T
//    associatedtype Node = Self
//    var value: T { get set }
//    var leftChild: Node? { get set }
//    var rightChild: Node? { get set }
//    var parent: Node? { get set }
//    //init(_ value: T)
//}
//
//enum TraversalOrder {
//    /// Pre-order traversal first traverses the root, then the left subtree, and then the right subtree.
//    case preOrder
//    /// In-order traversal first traverses the left subtree, then the root, and then the right subtree.
//    case inOrder
//    /// Post-order traversal first traverses the left subtree, then the right subtree, and then the root.
//    case postOrder
//}
//protocol BinaryTreePr {
//    associatedtype T
//    associatedtype Node where Node: BinaryTreeNodePr
//    //associatedtype TraversalOrder
//    var root: Node? { get }
//    var count: Int { get }
//    var isEmpty: Bool { get }
//    var inOrderTraversal: [T] { get }
//    var preOrderTraversal: [T] { get }
//    var postOrderTraversal: [T] { get }
//    func traverse(_ order: TraversalOrder, action: (T) -> ())
//}
//extension BinaryTreePr {
//    var isEmpty: Bool {
//        return count == 0
//    }
//    var inOrderTraversal: [T] {
//        var array: [T] = []
//        traverseInOrder(startingWith: root, action: { array.append($0) })
//        return array
//    }
//    var preOrderTraversal: [T] {
//        var array: [T] = []
//        traversePreOrder(startingWith: root, action: { array.append($0) })
//        return array
//    }
//    var postOrderTraversal: [T] {
//        var array: [T] = []
//        traversePostOrder(startingWith: root, action: { array.append($0) })
//        return array
//    }
//}
//extension BinaryTreePr {
//    func traverse(_ order: TraversalOrder, action: (T) -> ()) {
//        switch order {
//            case .preOrder:
//                traversePreOrder(startingWith: root, action: action)
//            case .inOrder:
//                traverseInOrder(startingWith: root, action: action)
//            case .postOrder:
//                traversePostOrder(startingWith: root, action: action)
//        }
//    }
//    private func traverseInOrder(startingWith node: Node?, action: (T) -> ()) {
//        if let node = node {
//            traverseInOrder(startingWith: node.leftChild as? Node, action: action)
//            action(node.value as! T)
//            traverseInOrder(startingWith: node.rightChild as? Node, action: action)
//        }
//    }
//    private func traversePreOrder(startingWith node: Node?, action: (T) -> ()) {
//        if let node = node {
//            action(node.value as! T)
//            traversePreOrder(startingWith: node.leftChild as? Node, action: action)
//            traversePreOrder(startingWith: node.rightChild as? Node, action: action)
//        }
//    }
//    private func traversePostOrder(startingWith node: Node?, action: (T) -> ()) {
//        if let node = node {
//            traversePostOrder(startingWith: node.leftChild as? Node, action: action)
//            traversePostOrder(startingWith: node.rightChild as? Node, action: action)
//            action(node.value as! T)
//        }
//    }
//}
