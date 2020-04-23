//
//  InsertionSort.swift
//  Learning
//
//  Created by Artem Zhukov on 23.04.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

/// Insertion sort is an algorithm that sorts an array by building the sorted version one item at a time.
///
/// This sorting algorithm is stable.
/// - Complexity: O(*n*^2)
struct InsertionSort: SortingAlgorithm {
    func sort<T: Comparable>(_ array: inout Array<T>, by comparator: (T, T) -> Bool) {
        var i = 1
        while i < array.count {
            let x = array[i]
            var j = i - 1
            while j >= 0 && comparator(x, array[j]) {
                array[j + 1] = array[j]
                j -= 1
            }
            array[j + 1] = x
            i += 1
        }
    }
}
