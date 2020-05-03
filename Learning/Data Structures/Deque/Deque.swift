//
//  Deque.swift
//  Learning
//
//  Created by Artem Zhukov on 26.04.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

/// A collection that supports appending and removing elements from two sides only.
///
/// A deque, or a double-ended queue, is a basic data structure that allows appending and removing elements from both sides.
///
/// Once you have a deque, you can add – `push` – or remove – `pop` – an element.
///
///     var deque = Deque<Int>()
///     deque.push(1, to: .back)
///     deque.push(2, to: .back)
///     deque.push(3, to: .front)
///     print(deque.pop(from: .front))
///     // Prints "3"
///     print(deque.pop(from: .back))
///     // Prints "2"
///
/// You can also peek at the front and back element without removing it.
///
///     deque.push(0, to: .front)
///     print(deque.front)
///     // Prints "Optional(0)"
///     print(deque.back)
///     // Prints "Optional(1)"
///
/// This implementation of a deque uses a doubly linked list.
struct Deque<T> {
    
    /// The side of the deque.
    enum DequeSide {
        case front, back
    }
    
    private var deque: DoublyLinkedList<T>
    
    /// The number of elements in the deque.
    /// - Complexity: O(1)
    var count: Int {
        deque.count
    }
    
    /// A Boolean value indicating whether the deque is empty.
    /// - Complexity: O(1)
    var isEmpty: Bool {
        deque.isEmpty
    }
    
    /// The element at the front of the deque.
    /// - Complexity: O(1)
    var front: T? {
        deque.head?.value
    }
    
    /// The element at the back of the deque.
    /// - Complexity: O(1)
    var back: T? {
        deque.toe?.value
    }
    
    /// Creates a new, empty queue.
    /// - Complexity: O(1)
    init() {
        deque = DoublyLinkedList<T>()
    }
    
    /// Adds a new element to the deque.
    /// - Parameter item: The item to add to the deque.
    /// - Parameter side: The side where `item` should be added.
    /// - Complexity: O(1)
    mutating func push(_ item: T, to side: DequeSide) {
        switch side {
        case .front:
            deque.insert(item, at: 0)
        case .back:
            deque.append(item)
        }
    }
    
    /// Removes and returns the element from a given side of the deque. The deque must not be empty.
    /// - Returns: The element that has been removed.
    /// - Complexity: O(1)
    @discardableResult mutating func pop(from side: DequeSide) -> T {
        switch side {
        case .front:
            return deque.removeFirst()
        case .back:
            return deque.removeLast()
        }
    }
    
}

extension Deque: CustomStringConvertible {
    var description: String {
        return "⇄\(deque.description)⇄"
    }
}

extension Deque: Equatable where T: Equatable {
    static func == (lhs: Deque<T>, rhs: Deque<T>) -> Bool {
        return lhs.deque == rhs.deque
    }
}
