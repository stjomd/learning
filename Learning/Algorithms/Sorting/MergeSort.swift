//
//  MergeSort.swift
//  Learning
//
//  Created by Artem Zhukov on 24.04.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

/// Merge sort is an algorithm that sorts an array by recursively splitting it into halves, sorting each one, and combining them.
///
/// This sorting algorithm is stable.
/// - Complexity: O(*n* log *n*)
struct MergeSort: SortingAlgorithm {
    func sort<T>(_ array: inout Array<T>, by areInIncreasingOrder: (T, T) -> Bool) {
        mergeSort(&array, 0, array.count - 1, by: areInIncreasingOrder)
    }
    private func mergeSort<T>(_ array: inout Array<T>, _ left: Int, _ right: Int, by areInIncreasingOrder: (T, T) -> Bool) {
        if left < right {
            let middle = (left + right) / 2
            mergeSort(&array, left, middle, by: areInIncreasingOrder)
            mergeSort(&array, middle + 1, right, by: areInIncreasingOrder)
            merge(&array, left, middle, right, by: areInIncreasingOrder)
        }
    }
    private func merge<T>(_ array: inout Array<T>, _ left: Int, _ middle: Int, _ right: Int, by areInIncreasingOrder: (T, T) -> Bool) {
        var i = left, j = middle + 1, k = left  // merge from two sorted halves of `array`
        var temporary = array
        while i <= middle && j <= right {   // check the first element in both halves and take the smaller one
            if !areInIncreasingOrder(array[j], array[i]) {  // array[i] <= array[j] (`<` would make the algorithm unstable)
                temporary[k] = array[i]     // taking from the first half
                i += 1
            } else {
                temporary[k] = array[j]     // taking from the second half
                j += 1
            }
            k += 1
        }
        if i > middle {                     // if all elements from the left half have been taken,
            for h in j...right {            // take all from the right
                temporary[k] = array[h]
                k += 1
            }
        } else {                            // if all elements from the right half have been taken,
            for h in i...middle {           // take all from the left
                temporary[k] = array[h]
                k += 1
            }
        }
        for h in left...right {             // copy to the original array
            array[h] = temporary[h]
        }
    }
}
