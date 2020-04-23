//
//  File.swift
//  Learning
//
//  Created by Artem Zhukov on 23.04.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

// MARK: - Main Extension
enum SortingAlgorithm {
    // Add a new case for every new sorting algorithm.
    case bubbleSort
}
extension Array where Element: Comparable {
    typealias Comparator = (Element, Element) -> Bool
    mutating func customSort(_ algorithm: SortingAlgorithm, by comparator: Comparator = {$0 < $1}) {
        // Add a new case for every new sorting algorithm inside the switch statement.
        switch algorithm {
        case .bubbleSort:
            bubbleSort(by: comparator)
        }
    }
    func customSorted(_ algorithm: SortingAlgorithm, by comparator: Comparator = {$0 < $1}) -> Self {
        var copy = self
        copy.customSort(algorithm, by: comparator)
        return copy
    }
}


// MARK: - Bubble Sort
extension Array where Element: Comparable {
        
    fileprivate mutating func bubbleSort(by comparator: Comparator = {$0 < $1}) {
        for i in 0..<count {
            for j in 1..<count - i {
                if comparator(self[j], self[j - 1]) { // self[j - 1] > self[j]
                    swapAt(j, j - 1)
                }
            }
        }
    }
    
    fileprivate func bubbleSorted(by comparator: Comparator = {$0 < $1}) -> [Element] {
        var copy = self
        copy.bubbleSort(by: comparator)
        return copy
    }
    
}
