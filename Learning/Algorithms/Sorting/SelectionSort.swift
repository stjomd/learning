//
//  SelectionSort.swift
//  Learning
//
//  Created by Artem Zhukov on 24.04.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

struct SelectionSort: SortingAlgorithm {
    func sort<T>(_ array: inout Array<T>, by areInIncreasingOrder: (T, T) -> Bool) {
        for i in 0..<array.count-1 {
            var indexOfMinimum = i
            for j in i..<array.count {
                if areInIncreasingOrder(array[j], array[indexOfMinimum]) {
                    indexOfMinimum = j
                }
            }
            array.swapAt(i, indexOfMinimum)
        }
    }
}
