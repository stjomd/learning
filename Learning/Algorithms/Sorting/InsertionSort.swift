//
//  InsertionSort.swift
//  Learning
//
//  Created by Artem Zhukov on 23.04.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

extension Array where Element: Comparable {
    fileprivate mutating func insertionSort(by comparator: Comparator) {
        var i = 1
        while i < count {
            let x = self[i]
            var j = i - 1
            while j >= 0 && comparator(x, self[j]) {
                self[j + 1] = self[j]
                j -= 1
            }
            self[j + 1] = x
            i += 1
        }
    }
}
