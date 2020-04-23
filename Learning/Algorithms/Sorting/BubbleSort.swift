//
//  BubbleSort.swift
//  Learning
//
//  Created by Artem Zhukov on 23.04.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

struct BubbleSort: SortingAlgorithm {
    func sort<T: Comparable>(_ array: inout Array<T>, by comparator: (T, T) -> Bool) {
        for i in 0..<array.count {
            for j in 1..<array.count - i {
                if comparator(array[j], array[j - 1]) { // self[j - 1] > self[j]
                    array.swapAt(j, j - 1)
                }
            }
        }
    }
}

