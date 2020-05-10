//
//  HeapSort.swift
//  Learning
//
//  Created by Artem Zhukov on 11.05.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

/// Heapsort is an algorithm that sorts an array by converting its unsorted section into a heap, removing the root (the smallest element) from the heap and appending it to the sorted section, repairing the heap, and doing the same thing all over again with the now shorter unsorted section.
///
/// This sorting algorithm is **not** stable.
/// - Complexity: O(*n* log *n*)
struct HeapSort: SortingAlgorithm {
    func sort<T>(_ array: inout Array<T>, by areInIncreasingOrder: @escaping (T, T) -> Bool) {
        buildHeap(&array, areInIncreasingOrder) // O(n)
        for i in 0..<array.count {
            array.swapAt(0, array.count - i - 1)
            heapifyDown(&array, 0, array.count - i - 1, areInIncreasingOrder)
        }
    }
    private func buildHeap<T>(_ array: inout Array<T>, _ areInIncreasingOrder: @escaping (T, T) -> Bool) {
        for i in stride(from: (array.count - 1)/2, through: 0, by: -1) {
            heapifyDown(&array, i, array.count, areInIncreasingOrder)
        }
    }
    private func heapifyDown<T>(_ heap: inout Array<T>, _ index: Int, _ bound: Int, _ areInIncreasingOrder: @escaping (T, T) -> Bool) {
        let n = bound - 1
        let j: Int
        if 2*index + 1 > n {
            return
        } else if 2*index + 1 < n {
            let left = 2*index + 1, right = 2*index + 2
            j = (!areInIncreasingOrder(heap[left], heap[right])) ? left : right
        } else {
            j = 2*index + 1
        }
        if !areInIncreasingOrder(heap[j], heap[index]) {
            heap.swapAt(j, index)
            heapifyDown(&heap, j, bound, areInIncreasingOrder)
        }
    }
}
