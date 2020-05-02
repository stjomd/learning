//
//  BinarySearch.swift
//  Learning
//
//  Created by Artem Zhukov on 02.05.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

extension Array where Element: Comparable {
    /// Looks up a given element in a sorted array.
    ///
    /// Correctness is only guaranteed on sorted arrays. Using this method on an unsorted array may return unexpected results.
    /// - Complexity: O(log *n*) on average, where *n* is the length of the array; O(1) in best case.
    /// - Parameter element: The element to be looked up in the array.
    /// - Returns: The index of `element` in the array, or `nil` if it's not present there.
    func binarySearch(for element: Element) -> Int? {
        var l = 0, r = count - 1
        while l <= r {
            let m = l + (r - l)/2
            if self[m] < element {
                l = m + 1
            } else if self[m] > element {
                r = m - 1
            } else {
                return m
            }
        }
        return nil
    }
}
