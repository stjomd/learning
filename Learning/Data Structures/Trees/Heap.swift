//
//  MaxHeap.swift
//  Learning
//
//  Created by Artem Zhukov on 08.05.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

class Heap<T> {
    
    private let areInIncreasingOrder: (T, T) -> Bool
    private var heap: [T] = []
    
    var tree: BinaryTree<T> {
        let root = BinaryTreeNode<T>(heap[0])
        var count = 0
        var queue = Queue<BinaryTreeNode<T>>()
        queue.enqueue(root)
        var currentNode: BinaryTreeNode<T>? = nil
        for i in 1..<heap.count {
            let node = BinaryTreeNode<T>(heap[i])
            if count == 0 {
                currentNode = queue.dequeue()
            }
            if count == 0 {
                count += 1
                currentNode?.leftChild = node
            } else {
                count = 0
                currentNode?.rightChild = node
            }
            queue.enqueue(node)
        }
        return BinaryTree<T>(root)
    }
    
    var root: T {
        assert(!isEmpty, "The heap is empty")
        return heap[0]
    }
    
    var count: Int {
        heap.count
    }
    
    var isEmpty: Bool {
        heap.count == 0
    }
    
    init(_ comparator: @escaping (T, T) -> Bool) {
        self.areInIncreasingOrder = comparator
    }
    
    init(_ comparator: @escaping (T, T) -> Bool, contentsOf array: [T]) {
        self.heap = array
        self.areInIncreasingOrder = comparator
        for i in stride(from: (array.count - 1)/2, through: 0, by: -1) {
            heapifyDown(i)
        }
    }
    
    func insert(_ item: T) {
        heap.append(item)
        heapifyUp(heap.count - 1)
    }
    
    @discardableResult func removeRoot() -> T {
        assert(!isEmpty, "The heap is empty")
        if count == 1 {
            return heap.removeLast()
        } else {
            let value = root
            heap[0] = heap.removeLast()
            heapifyDown(0)
            return value
        }
    }
    
    @discardableResult func remove(at index: Int) -> T {
        assert(index < heap.count, "Index out of bounds")
        if index != heap.count - 1 {
            heap.swapAt(index, heap.count - 1)
            heapifyDown(index)
            heapifyUp(index)
        }
        return heap.removeLast()
    }
    
    private func heapifyUp(_ index: Int) {
        if index > 0 {
            let j = (index - 1)/2
            if areInIncreasingOrder(heap[index], heap[j]) {
                heap.swapAt(index, j)
                heapifyUp(j)
            }
        }
    }
    
    private func heapifyDown(_ index: Int) {
        let n = heap.count - 1
        let j: Int
        if 2*index + 1 > n {
            return
        } else if 2*index + 1 < n {
            let left = 2*index + 1, right = 2*index + 2
            j = (areInIncreasingOrder(heap[left], heap[right])) ? left : right
        } else {
            j = 2*index + 1
        }
        if areInIncreasingOrder(heap[j], heap[index]) {
            heap.swapAt(j, index)
            heapifyDown(j)
        }
    }
    
}

extension Heap: CustomStringConvertible where T: CustomStringConvertible {
    var description: String {
        return tree.description
    }
}

extension Heap where T: Equatable {
    func firstIndex(of item: T) -> Int? {
        return heap.firstIndex { $0 == item }
    }
    func lastIndex(of item: T) -> Int? {
        return heap.lastIndex { $0 == item }
    }
    @discardableResult func remove(item: T) -> T {
        let index = firstIndex(of: item)
        assert(index != nil, "Item is not present in the heap")
        return remove(at: index!)
    }
}
