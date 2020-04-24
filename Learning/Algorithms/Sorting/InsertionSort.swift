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
    func sort<T>(_ array: inout Array<T>, by areInIncreasingOrder: (T, T) -> Bool) {
        for i in 1..<array.count {
            let x = array[i]
            var j = i - 1
            while j >= 0 && areInIncreasingOrder(x, array[j]) {
                array[j + 1] = array[j]
                j -= 1
            }
            array[j + 1] = x
        }
    }
}
