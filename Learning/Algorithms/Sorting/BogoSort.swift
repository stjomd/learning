//
//  BogoSort.swift
//  Learning
//
//  Created by Artem Zhukov on 23.05.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

/// Bogosort is a very inefficient sorting algorithm that sorts an array by shuffling it until it becomes sorted.
///
/// This sorting algorithm is **not** stable.
/// - Complexity: O(*n*!*n*)
struct BogoSort: SortingAlgorithm {
    func sort<T>(_ array: inout Array<T>, by areInIncreasingOrder: @escaping (T, T) -> Bool) {
        while !isSorted(&array, by: areInIncreasingOrder) {
            array.shuffle()
        }
    }
    private func isSorted<T>(_ array: inout [T], by areInIncreasingOrder: @escaping (T, T) -> Bool) -> Bool {
        for i in 0..<array.count - 1 {
            if areInIncreasingOrder(array[i+1], array[i]) {
                return false
            }
        }
        return true
    }
}
