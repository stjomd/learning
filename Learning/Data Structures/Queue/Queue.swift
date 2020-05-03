//
//  Queue.swift
//  Learning
//
//  Created by Artem Zhukov on 26.04.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

/// A FIFO (first in, first out) collection.
///
/// A queue is a basic data structure that allows appending elements to one end and removing elements from the other.
///
/// You can only create an empty queue. From then on, you can add – `enqueue` – or remove – `dequeue` – an element.
///
///     var queue = Queue<Int>()
///     queue.enqueue(1)
///     queue.enqueue(2)
///     queue.enqueue(3)
///     print(queue.dequeue())
///     // Prints "1"
///
/// You can also peek at the front and back element without removing it.
///
///     print(queue.front)
///     // Prints "Optional(2)"
///     print(queue.back)
///     // Prints "Optional(3)"
///
/// This implementation of a queue uses a singly linked list.
struct Queue<T> {
    
    private var queue: SinglyLinkedList<T>
    
    /// The number of elements in the queue.
    /// - Complexity: O(1)
    var count: Int {
        queue.count
    }
    
    /// A Boolean value indicating whether the queue is empty.
    /// - Complexity: O(1)
    var isEmpty: Bool {
        queue.isEmpty
    }
    
    /// The element at the front of the queue.
    /// - Complexity: O(1)
    var front: T? {
        queue.head?.value
    }
    
    /// The element at the back of the queue (i.e. the element that was added most recently).
    /// - Complexity: O(1)
    var back: T? {
        queue.toe?.value
    }
    
    /// Creates a new, empty queue.
    /// - Complexity: O(1)
    init() {
        queue = SinglyLinkedList<T>()
    }
    
    /// Adds a new element to the back of the queue.
    /// - Parameter item: The item to add to the back of the queue.
    /// - Complexity: O(1)
    mutating func enqueue(_ item: T) {
        queue.append(item)
    }
    
    /// Removes and returns the element at the front of the queue. The queue must not be empty.
    /// - Returns: The element that has been removed.
    /// - Complexity: O(1)
    @discardableResult mutating func dequeue() -> T {
        return queue.removeFirst()
    }
    
}

extension Queue: CustomStringConvertible {
    var description: String {
        return "<\(queue.description)<"
    }
}

extension Queue: Equatable where T: Equatable {
    static func == (lhs: Queue<T>, rhs: Queue<T>) -> Bool {
        return lhs.queue == rhs.queue
    }
}
