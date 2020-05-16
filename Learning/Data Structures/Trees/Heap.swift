//
//  MaxHeap.swift
//  Learning
//
//  Created by Artem Zhukov on 08.05.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

/// A binary tree that satisfies a heap property: in a min heap, children of a node are less than or equal to that node; in a max heap, children of a node are greater than or equal to that node.
///
/// A heap can be useful when you need to repeatedly remove the largest (or smallest) item. To create a min heap, pass `<` operator to the initializer, and `>` to create a max heap.
///
///     let minHeap = Heap<Int>(<)
///     let maxHeap = Heap<Int>(with: [3, 0, 2, 8, 5, 1], >)
///
/// This class implements a heap using an array and therefore does not conform to protocol `AnyBinaryTree`, but you can access the `tree` property of a heap that returns a `BinaryTree` object.
///
///     let heapTree: BinaryTree<Int> = maxHeap.tree
///
/// The `tree` property is calculated, i.e. a new binary tree is built every time you access this property.
class Heap<Element> {
    
    // MARK: Properties
    
    private let areInIncreasingOrder: (Element, Element) -> Bool
    private var heap: [Element] = []
    
    /// The binary tree object that represents this heap.
    ///
    /// Accessing this property will build a respective binary tree.
    /// - Complexity: O(*n*)
    var tree: BinaryTree<Element> {
        let root = BinaryTreeNode<Element>(heap[0])
        var count = 0
        var queue = Queue<BinaryTreeNode<Element>>()
        queue.enqueue(root)
        var currentNode: BinaryTreeNode<Element>? = nil
        for i in 1..<heap.count {
            let node = BinaryTreeNode<Element>(heap[i])
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
        return BinaryTree<Element>(root)
    }
    
    /// The root of the heap. In a min heap, this is the smallest, and in a max heap, the largest element.
    var root: Element? {
        return heap.first
    }
    
    /// The amount of elements in the heap.
    var count: Int {
        heap.count
    }
    
    /// A Boolean value indicating whether the heap is empty.
    var isEmpty: Bool {
        heap.isEmpty
    }
    
    // MARK: Initializers
    
    /// Creates a new, empty heap.
    ///
    /// To create a min heap, pass `<` operator to the initializer, and `>` to create a max heap.
    ///
    ///     let minHeap = Heap<Int>(<)
    ///
    /// - Complexity: O(1)
    /// - Parameter comparator: A closure that accepts two elements and returns a Boolean value indicating whether the first element is smaller than the second.
    init(_ comparator: @escaping (Element, Element) -> Bool) {
        self.areInIncreasingOrder = comparator
    }
    
    /// Creates a new heap with the elements of an array.
    ///
    /// To create a min heap, pass `<` operator to the initializer, and `>` to create a max heap.
    ///
    ///     let maxHeap = Heap<Int>(with: [3, 0, 2, 8, 5, 1], >)
    ///     let myHeap  = Heap<Double>(with: [0.5, 1.5, 0.33, 2, 0.98]) { $0*$0 < $1 }
    ///
    /// - Complexity: O(*n*), provided a comparison is done in O(1).
    /// - Parameter array: The array of elements that should be present in the heap.
    /// - Parameter comparator: A closure that accepts two elements and returns a Boolean value indicating whether the first element is smaller than the second.
    init(with array: [Element], _ comparator: @escaping (Element, Element) -> Bool) {
        self.heap = array
        self.areInIncreasingOrder = comparator
        for i in stride(from: (array.count - 1)/2, through: 0, by: -1) {
            heapifyDown(i)
        }
    }
    
    // MARK: Methods
    
    /// Inserts a new element into the heap.
    /// - Complexity: O(log *n*), provided the comparison is done in O(1).
    /// - Parameter item: The item to be inserted into the heap.
    func insert(_ item: Element) {
        heap.append(item)
        heapifyUp(heap.count - 1)
    }
    
    /// Removes and returns the root element.
    ///
    /// In a min heap, this is the smallest, and in a max heap, the largest element.
    /// - Complexity: O(log *n*), provided the comparison is done in O(1).
    /// - Returns: The element that has been removed.
    @discardableResult func removeRoot() -> Element {
        assert(!isEmpty, "The heap is empty")
        if count == 1 {
            return heap.removeLast()
        } else {
            let value = root!
            heap[0] = heap.removeLast()
            heapifyDown(0)
            return value
        }
    }
    
    /// Removes the element with the specific index in the array that represents the heap.
    ///
    /// - Complexity: O(log *n*), provided the comparison is done in O(1).
    /// - Parameter index: The index of the element to be removed.
    /// - Returns: The element that has been removed.
    @discardableResult func remove(at index: Int) -> Element {
        assert(index < heap.count, "Index out of bounds")
        if index != heap.count - 1 {
            heap.swapAt(index, heap.count - 1)
            heapifyDown(index)
            heapifyUp(index)
        }
        return heap.removeLast()
    }
    
    // MARK: Heapify
    
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

// MARK: Search
extension Heap where Element: Equatable {
    /// Returns the first index of the specified element in the array that represents the heap.
    ///
    /// - Complexity: O(*n*)
    /// - Parameter item: The item to be found in the heap array.
    func firstIndex(of item: Element) -> Int? {
        return heap.firstIndex { $0 == item }
    }
    /// Returns the last index of the specified element in the array that represents the heap.
    ///
    /// - Complexity: O(*n*)
    /// - Parameter item: The item to be found in the heap array.
    func lastIndex(of item: Element) -> Int? {
        return heap.lastIndex { $0 == item }
    }
    /// Removes the first occurance of an element in the array that represents the heap.
    ///
    /// - Complexity: O(log *n*), provided the comparison is done in O(1).
    /// - Parameter item: The item to be removed.
    /// - Returns: The item that has been removed.
    @discardableResult func remove(item: Element) -> Element {
        let index = firstIndex(of: item)
        assert(index != nil, "Item is not present in the heap")
        return remove(at: index!)
    }
}


// MARK: - CustomStringConvertible
extension Heap: CustomStringConvertible where Element: CustomStringConvertible {
    var description: String {
        if isEmpty {
            return "──── nil"
        }
        return tree.description
    }
}
