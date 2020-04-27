//
//  QuickSort.swift
//  Learning
//
//  Created by Artem Zhukov on 27.04.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

/// Quicksort is an algorithm that sorts an array by selecting a pivot element, partitioning the other elements into two sub-arrays, one of which only contains elements that are less or greater than the pivot, and the other the rest of the elements; these sub-arrays are then sorted recursively.
///
/// This sorting algorithm is **not** stable.
///
/// This implementation of Quicksort uses the Hoare partition scheme.
/// - Complexity: O(*n* log *n*) on average, O(*n*^2) in worst case. Choosing `median` or `random` pivot selection strategy might help avoid degrading to the worst case performance as often as with other strategies.
struct QuickSort: SortingAlgorithm {
    enum PivotStrategy {
        /// The first element of the array will be chosen as the pivot.
        case first
        /// The middle element of the array will be chosen as the pivot.
        case middle
        /// The last element of the array will be chosen as the pivot.
        case last
        /// An element at a random position in the array will be chosen as the pivot.
        case random
        /// The median of the first, middle and last element of the array will be chosen as the pivot.
        case median
    }
    private(set) var strategy: PivotStrategy
    /// Creates a sorting algorithm object.
    ///
    /// This sorting algorithm object uses Quicksort. By default, the median of the first, middle and last element of the array will be chosen as the pivot. To choose a different strategy, pass a `QuickSort.PivotStrategy` value to the initializer.
    init() {
        strategy = .median
    }
    init(pivot: PivotStrategy) {
        strategy = pivot
    }
    func sort<T>(_ array: inout Array<T>, by areInIncreasingOrder: (T, T) -> Bool) {
        quickSort(&array, left: 0, right: array.count - 1, by: areInIncreasingOrder)
    }
    private func quickSort<T>(_ array: inout Array<T>, left: Int, right: Int, by areInIncreasingOrder: (T, T) -> Bool) {
        if left < right {
            let partitionAt = divide(&array, left: left, right: right, by: areInIncreasingOrder) // divide into two sub-arrays at this index
            quickSort(&array, left: left, right: partitionAt, by: areInIncreasingOrder)          // sort the left sub-array
            quickSort(&array, left: partitionAt + 1, right: right, by: areInIncreasingOrder)     // sort the right sub-array
        }
    }
    private func divide<T>(_ array: inout Array<T>, left: Int, right: Int, by areInIncreasingOrder: (T, T) -> Bool) -> Int {
        let pivot: T
        switch strategy { // choose a pivot element
            case .first:
                pivot = array[left]
            case .middle:
                pivot = array[left + (right - left)/2]
            case .last:
                pivot = array[right - 1]
            case .random:
                pivot = array[Int.random(in: left..<right)]
            case .median: // choose the median as pivot, and also sort the three elements in the array
                let middle = left + (right - left)/2
                if areInIncreasingOrder(array[middle], array[left]) {
                    array.swapAt(middle, left)
                }
                if areInIncreasingOrder(array[right], array[left]) {
                    array.swapAt(right, left)
                }
                if areInIncreasingOrder(array[middle], array[right]) {
                    array.swapAt(middle, right)
                }
                pivot = array[right]
        }
        var i = left - 1, j = right + 1     // Hoare partition scheme
        while true {                        // Two indices (i & j) move towards each other, until an inversion is detected:
            repeat {                        // e.g. i < pivot but array[i] > array[pivot], etc.
                i += 1
            } while areInIncreasingOrder(array[i], pivot)
            repeat {
                j -= 1
            } while areInIncreasingOrder(pivot, array[j])
            if i >= j {                     // When the indices meet, stop and
                return j                    // return the final index.
            }
            array.swapAt(i, j)              // The inverted elements are swapped.
        }
    }
}
