//
//  MaximumSubarrayKadane.swift
//  Learning
//
//  Created by Artem Zhukov on 02.05.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

extension Array where Element: AdditiveArithmetic & Comparable {
    /// Returns a sliced contiguous subarray of the original array with the largest possible sum. The array must not be empty.
    ///
    /// Call this method on any array with objects that conform to `AdditiveArithmetic` and `Comparable`. Types such as `Int`, `Double`, and some others conform to those protocols.
    ///
    ///     let array  = [4, -5, 1, 3, -3, 2, 5, -1]
    ///     let subMax = array.maximumSubarray()
    ///     // subMax = [1, 3, -3, 2, 5]
    ///
    /// The method returns an `ArraySlice` object. To get the indices of the maximum subarray in context of the original array, access `indices` property on the slice.
    ///
    ///     let range = subMax.indices
    ///     // range = 2..<7
    ///     let lowerIndex = range.first!, upperIndex = range.last!
    ///     // lowerIndex = 2; upperIndex = 6
    ///
    /// The method does not return the actual maximum sum. To calculate it, use a loop or `reduce` method.
    ///
    ///     var sum = 0
    ///     for element in subMax {
    ///         sum += element
    ///     }
    ///     // sum = 8
    ///     sum = subMax.reduce(0) { $0 + $1 }
    ///     // sum = 8
    ///
    /// - Complexity: O(*n*), where *n* is the length of the array.
    /// - Returns: An `ArraySlice` object that represents the maximum subarray.
    func maximumSubarray() -> ArraySlice<Element> {
        assert(!self.isEmpty, "The array is empty")
        var bestSum = Element.zero, currentSum = Element.zero
        var bestStart = 0, bestEnd = 0, currentStart = 0
        for i in 0..<self.count {
            if self[i] > currentSum + self[i] {
                currentStart = i
                currentSum = self[i]
            } else {
                currentSum += self[i]
            }
            if currentSum > bestSum {
                bestSum = currentSum
                bestStart = currentStart
                bestEnd = i
            }
        }
        return self[bestStart...bestEnd]
    }
}
