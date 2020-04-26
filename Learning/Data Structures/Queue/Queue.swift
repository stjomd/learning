//
//  Queue.swift
//  Learning
//
//  Created by Artem Zhukov on 26.04.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

struct Queue<T> {
    
    var queue: SinglyLinkedList<T>
    
    var count: Int {
        queue.count
    }
    
    var isEmpty: Bool {
        queue.isEmpty
    }
    
    var first: T? {
        queue.head?.value
    }
    
}
