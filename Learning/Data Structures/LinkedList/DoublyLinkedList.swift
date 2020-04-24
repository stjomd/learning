//
//  LinkedList.swift
//  Learning
//
//  Created by Artem Zhukov on 24.04.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

public struct DoublyLinkedList<T>: LinkedList {
    
    typealias Node = LinkedListNode<T>
    class LinkedListNode<T> {
        var value: T
        var next: Node?
        weak var previous: Node?
        init(_ value: T) {
            self.value = value
        }
    }
    
    /// The first node in the list.
    /// - Complexity: O(1)
    private(set) var head: Node?
    
    /// The last node in the list.
    /// - Complexity: O(1)
    private(set) var toe: Node?
    
    /// Returns true if the linked list is empty.
    /// - Complexity: O(1)
    public var isEmpty: Bool {
        return head == nil
    }
    
    /// Returns the amount of nodes in the linked list.
    /// - Complexity: O(1)
    private(set) public var count: Int = 0
    
    
    
    /// Creates a new, empty linked list.
    /// - Complexity: O(1)
    init() {
    }
    
    /// Creates a new linked list with the elements of an array.
    /// - Parameter array: The array to be converted into a linked list.
    /// - Complexity: O(n)
    init(_ array: [T]) {
        for element in array {
            append(element)
        }
    }
    
    /// Creates a new linked list with the parameters passed to the initializer.
    /// - Parameter items: Zero or more items to be added to the new linked list.
    /// - Complexity: O(n)
    init(_ items: T...) {
        self.init(items)
    }
    
    
    
    /// Allows access to the value of a node at a specific index.
    /// Crashes if index is invalid.
    /// - Returns: the item at position `index` in the list.
    /// - Complexity: O(n)
    public subscript(index: Int) -> T {
        get {
            assert(index >= 0 && index < count, "Index out of bounds")
            assert(!isEmpty, "The list is empty")
            return node(at: index)!.value
        }
        set {
            assert(index >= 0 && index < count, "Index out of bounds")
            assert(!isEmpty, "The list is empty")
            if index == 0 {
                head!.value = newValue
            } else if index == count - 1 {
                toe!.value = newValue
            } else {
                let node = self.node(at: index)!
                node.value = newValue
            }
        }
    }
    
    /// Returns the node at a specific index.
    /// Returns nil if index is invalid. (Safe lookup)
    /// - Parameter index: The index of the required node.
    /// - Returns: The node at a given index, or `nil` if `index` is invalid.
    /// - Complexity: O(n)
    func node(at index: Int) -> Node? {
        assert(index >= 0, "Index out of bounds")
        var currentNode = head
        for _ in 0..<index {
            currentNode = currentNode?.next
            if currentNode == nil {
                break
            }
        }
        return currentNode
    }
    
    /// Appends a node to the end of the list.
    /// - Parameter node: The node to be appended.
    /// - Complexity: O(1)
    mutating func append(_ node: Node) {
        let node = node
        if isEmpty {
            head = node
        } else {
            node.previous = toe
            toe?.next = node
        }
        toe = node
        count += 1
    }
    
    /// Appends a node with a specific item to the end of the list.
    /// - Parameter value: The item to be appended.
    /// - Complexity: O(1)
    mutating func append(_ item: T) {
        let node = Node(item)
        append(node)
    }
    
    /// Inserts a new node to the specified position.
    /// - Parameter node: The node to be inserted.
    /// - Parameter index: The position where `node` should be inserted at.
    /// - Complexity: O(n) on average and in worst case, O(1) in best case (inserting at the beginning or the end of the list).
    mutating func insert(_ node: Node, at index: Int) {
        if index == 0 {
            node.next = head
            head?.previous = node
            head = node
        } else if index == count {
            append(node)
            return
        } else {
            guard let current = self.node(at: index) else {
                assertionFailure("Index out of bounds")
                return
            }
            node.next = current
            node.previous = current.previous
            current.previous?.next = node
            current.previous = node
        }
        count += 1
    }
    
    /// Inserts a new item to the specified position.
    /// - Parameter item: The item to be inserted.
    /// - Parameter index: The position where `item` should be inserted at.
    /// - Complexity: O(n) on average and in worst case, O(1) in best case (inserting at the beginning or the end of the list).
    mutating func insert(_ item: T, at index: Int) {
        let node = Node(item)
        insert(node, at: index)
    }
    
    /// Returns and removes the first element in the list.
    /// - Returns: The element that has been removed.
    /// - Complexity: O(1)
    @discardableResult mutating func removeFirst() -> T {
        assert(!isEmpty, "The list is empty")
        let value = head!.value
        head!.next?.previous = nil
        head = head!.next
        count -= 1
        return value
    }
    
    /// Returns and removes the last element in the list.
    /// - Returns: The element that has been removed.
    /// - Complexity: O(1)
    @discardableResult mutating func removeLast() -> T {
        assert(!isEmpty, "The list is empty")
        let value = toe!.value
        toe!.previous?.next = nil
        toe = toe!.previous
        count -= 1
        return value
    }
    
    /// Returns and removes the element in the list at a given position.
    /// - Returns: The element that has been removed.
    /// - Complexity: O(n) on average and in worst case, O(1) in best case (removing the first or the last element).
    @discardableResult mutating func remove(at index: Int) -> T {
        assert(index >= 0 && index < count, "Index out of bounds")
        assert(!isEmpty, "The list is empty")
        if index == 0 {
            return removeFirst()
        } else if index == count - 1 {
            return removeLast()
        } else {
            let currentNode = self.node(at: index)! // O(n)
            let previousNode = currentNode.previous, nextNode = currentNode.next
            previousNode?.next = nextNode
            nextNode?.previous = previousNode
            currentNode.previous = nil
            currentNode.next = nil
            count -= 1
            return currentNode.value
        }
    }
    
    /// Removes all elements in the list.
    /// - Complexity: O(1)
    mutating func removeAll() {
        head = nil
        toe = nil
        count = 0
    }
    
}

extension DoublyLinkedList: CustomStringConvertible {
    public var description: String {
        var string = "["
        var currentNode = head
        for _ in 0..<self.count {
            string += "\(currentNode!.value)"
            currentNode = currentNode?.next
            if currentNode == nil {
                break
            }
            string += ", "
        }
        string += "]"
        return string
    }
}

extension DoublyLinkedList: ExpressibleByArrayLiteral {
    public init(arrayLiteral: T...) {
        self.init(arrayLiteral)
    }
}

/// Custom index type that keeps an index (Int) and a reference to the node with that index in the list.
/// Required for conformance to Collection.
public struct DoublyLinkedListIndex<T>: Comparable {
    let node: DoublyLinkedList<T>.LinkedListNode<T>?
    let index: Int
    public static func == <T>(lhs: DoublyLinkedListIndex<T>, rhs: DoublyLinkedListIndex<T>) -> Bool {
        return (lhs.index == rhs.index)
    }
    public static func < <T>(lhs: DoublyLinkedListIndex<T>, rhs: DoublyLinkedListIndex<T>) -> Bool {
        return (lhs.index < rhs.index)
    }
}
extension DoublyLinkedList: Collection {
    public typealias Index = DoublyLinkedListIndex<T>
    public var startIndex: Index {
        get {
            DoublyLinkedListIndex<T>(node: head, index: 0)
        }
    }
    public var endIndex: Index {
        get {
            if isEmpty {
                return startIndex
            } else {
                return DoublyLinkedListIndex<T>(node: toe?.next, index: count)
            }
        }
    }
    public func index(after i: DoublyLinkedListIndex<T>) -> DoublyLinkedListIndex<T> {
        DoublyLinkedListIndex<T>(node: i.node?.next, index: i.index + 1)
    }
    public subscript(position: Index) -> T {
        get {
            return position.node!.value
        }
    }
}
