//
//  SinglyLinkedList.swift
//  Learning
//
//  Created by Artem Zhukov on 24.04.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

public struct SinglyLinkedList<T> {
    
    class LinkedListNode<T> {
        var value: T
        var next: LinkedListNode?
        init(_ value: T) {
            self.value = value
        }
    }
    typealias Node = LinkedListNode<T>
    
    /// The first node in the list.
    /// - Complexity: O(1)
    var head: Node?
    
    /// The last node in the list.
    /// - Complexity: O(1)
    var toe: Node?
    
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
        assert(index >= 0 && index < count, "Index out of bounds")
        assert(!isEmpty, "The list is empty")
        return node(at: index)!.value
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
        if isEmpty {
            head = node
        } else {
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
            head = node
        } else if index == count {
            append(node)
            return
        } else {
            guard let previous = self.node(at: index - 1), let current = previous.next else {
                assertionFailure("Index out of bounds")
                return
            }
            previous.next = node
            node.next = current
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
        head = head!.next
        count -= 1
        return value
    }
    
    /// Returns and removes the last element in the list.
    /// - Returns: The element that has been removed.
    /// - Complexity: O(*n*)
    @discardableResult mutating func removeLast() -> T {
        assert(!isEmpty, "The list is empty")
        let value = toe!.value
        let newToe = node(at: count - 2)
        newToe?.next = nil
        toe = newToe
        count -= 1
        return value
    }
    
    /// Returns and removes the element in the list at a given position.
    /// - Returns: The element that has been removed.
    /// - Complexity: O(*n*) on average and in worst case, O(1) in best case (removing the first element).
    @discardableResult mutating func remove(at index: Int) -> T {
        assert(index >= 0 && index < count, "Index out of bounds")
        assert(!isEmpty, "The list is empty")
        if index == 0 {
            return removeFirst()
        } else if index == count - 1 {
            return removeLast()
        } else {
            let previous = self.node(at: index - 1)!
            let newNext  = previous.next!.next
            let value    = previous.next!.value
            previous.next = newNext
            count -= 1
            return value
        }
    }
    
    /// Removes all elements in the list.
    /// - Complexity: O(1)
    mutating func removeAll() {
        head = nil
        toe = head
        count = 0
    }
    
}
