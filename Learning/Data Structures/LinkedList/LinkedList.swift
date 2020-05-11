//
//  LinkedList.swift
//  Learning
//
//  Created by Artem Zhukov on 11.05.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

protocol LinkedListNode {
    associatedtype Element
    associatedtype Node = Self
    var value: Element { get set }
    var next: Node? { get set }
    init(_ value: Element)
}

protocol LinkedList {
    associatedtype Element
    associatedtype Node: LinkedListNode
    var head: Node? { get set }
    var toe: Node? { get set }
    var count: Int { get set }
    var isEmpty: Bool { get }
    func node(at index: Int) -> Node?
    func append(_ node: Node)
    func append(_ item: Element)
    func insert(_ node: Node, at index: Int)
    func insert(_ item: Element, at index: Int)
    func removeFirst() -> Element
    func removeLast() -> Element
    func remove(at index: Int) -> Element
    func removeAll()
}

extension LinkedList {
    var isEmpty: Bool {
        return count == 0
    }
    func node(at index: Int) -> Node? {
        assert(index >= 0, "Index out of bounds")
        var currentNode = head
        for _ in 0..<index {
            currentNode = currentNode?.next as? Node
            if currentNode == nil {
                break
            }
        }
        return currentNode
    }
    func append(_ item: Element) {
        let node = Node(item as! Node.Element)
        append(node)
    }
    func insert(_ item: Element, at index: Int) {
        let node = Node(item as! Node.Element)
        insert(node, at: index)
    }
    mutating func removeAll() {
        head = nil
        toe = nil
        count = 0
    }
}
