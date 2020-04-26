//
//  Queue.swift
//  Learning
//
//  Created by Artem Zhukov on 26.04.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

struct Queue<T> {
    
    private var queue: SinglyLinkedList<T>
    
    var count: Int {
        queue.count
    }
    
    var isEmpty: Bool {
        queue.isEmpty
    }
    
    var front: T? {
        queue.head?.value
    }
    
    var back: T? {
        queue.toe?.value
    }
    
    init() {
        queue = SinglyLinkedList<T>()
    }
    
    mutating func enqueue(_ item: T) {
        queue.append(item)
    }
    
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
