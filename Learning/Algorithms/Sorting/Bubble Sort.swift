//
//  Bubble Sort.swift
//  Learning
//
//  Created by Artem Zhukov on 23.04.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

extension Array where Element: Comparable {
    
    typealias Comparator = (Element, Element) -> Bool
    
    mutating func bubbleSort(by comparator: Comparator = {$0 < $1}) {
        for i in 0..<count {
            for j in 1..<count - i {
                if comparator(self[j], self[j - 1]) { // self[j - 1] > self[j]
                    swapAt(j, j - 1)
                }
            }
        }
    }
    
    func bubbleSorted(by comparator: Comparator = {$0 < $1}) -> [Element] {
        var copy = self
        copy.bubbleSort(by: comparator)
        return copy
    }
    
}
