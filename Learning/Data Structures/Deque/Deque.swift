//
//  Deque.swift
//  Learning
//
//  Created by Artem Zhukov on 26.04.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

struct Deque<T> {
    
    enum DequeSide {
        case front, back
    }
    
    private var deque: DoublyLinkedList<T>
    
    var count: Int {
        deque.count
    }
    
    var isEmpty: Bool {
        deque.isEmpty
    }
    
    var front: T? {
        deque.head?.value
    }
    
    var back: T? {
        deque.toe?.value
    }
    
    init() {
        deque = DoublyLinkedList<T>()
    }
    
    mutating func push(_ item: T, to side: DequeSide) {
        switch side {
        case .front:
            deque.insert(item, at: 0)
        case .back:
            deque.append(item)
        }
    }
    
    @discardableResult mutating func pop(from side: DequeSide) -> T {
        switch side {
        case .front:
            return deque.removeFirst()
        case .back:
            return deque.removeLast()
        }
    }
    
}
