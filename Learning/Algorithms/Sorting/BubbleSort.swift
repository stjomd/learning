//
//  BubbleSort.swift
//  Learning
//
//  Created by Artem Zhukov on 23.04.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

/// Bubble sort is a classic algorithm that sorts an array by comparing adjacent elements and swapping them if they are in the wrong order.
///
/// This sorting algorithm is stable.
/// - Complexity: O(*n*^2)
struct BubbleSort: SortingAlgorithm {
    func sort<T>(_ array: inout Array<T>, by areInIncreasingOrder: (T, T) -> Bool) {
        for i in 0..<array.count {
            for j in 1..<array.count - i {
                if areInIncreasingOrder(array[j], array[j - 1]) { // self[j - 1] > self[j]
                    array.swapAt(j, j - 1)
                }
            }
        }
    }
}

