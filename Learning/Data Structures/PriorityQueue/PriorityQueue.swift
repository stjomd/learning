//
//  PriorityQueue.swift
//  Learning
//
//  Created by Artem Zhukov on 16.05.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

class PriorityQueue<Element, Priority> {
    
    private typealias Comparator = (ElementWrapper, ElementWrapper) -> Bool
    
    private class ElementWrapper {
        var value: Element
        var priority: Priority
        init(_ value: Element, _ priority: Priority) {
            self.value = value
            self.priority = priority
        }
    }
    
    private let heap: Heap<ElementWrapper>
    
    var count: Int {
        heap.count
    }
    
    var isEmpty: Bool {
        heap.isEmpty
    }
    
    var front: Element? {
        heap.root?.value
    }
    
    init(_ comparator: @escaping (Priority, Priority) -> Bool) {
        let newComparator: Comparator = { a, b in comparator(a.priority, b.priority) }
        self.heap = Heap<ElementWrapper>(newComparator)
    }
    
    init(with array: [Element], defaultPriority priority: Priority, _ comparator: @escaping (Priority, Priority) -> Bool) {
        let newComparator: Comparator = { a, b in comparator(a.priority, b.priority) }
        self.heap = Heap(with: array.map { ElementWrapper($0, priority) }, newComparator)
    }
    
    func enqueue(_ item: Element, priority: Priority) {
        let object = ElementWrapper(item, priority)
        heap.insert(object)
    }
    
    @discardableResult func dequeue() -> Element {
        heap.removeRoot().value
    }
    
}
