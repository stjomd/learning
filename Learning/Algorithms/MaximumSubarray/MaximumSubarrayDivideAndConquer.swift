//
//  MaximumSubarrayDivideAndConquer.swift
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
    ///     let subMax = array.maximumSubarrayDC()
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
    /// - Complexity: O(*n* log *n*), where *n* is the length of the array. This is **not** the most efficient algorithm for this problem – see the implementation that uses Kadane's algorithm, which is in O(*n*). This implementation uses a divide-and-conquer approach.
    /// - Returns: An `ArraySlice` object that represents the maximum subarray.
    func maximumSubarrayDC() -> ArraySlice<Element> {
        assert(!self.isEmpty, "The array is empty")
        let subarray = maximumSubarrayDC(l: 0, r: count - 1)
        return self[subarray.l...subarray.r]
    }
    private func maximumSubarrayDC(l: Int, r: Int) -> Subarray {
        if l == r { // trivial case, end recursion
            return Subarray(self[l], l: l, r: r)
        }
        let m = l + (r - l)/2   // middle index
        let left  = maximumSubarrayDC(l: l, r: m)   // left half
        let right = maximumSubarrayDC(l: m+1, r: r) // right half
        // crossing sum, left half: build the sum from the middle element leftwards
        var sum: Element = Element.zero
        var suml: Element = self[m]
        var il: Int = m
        for i in stride(from: m, through: l, by: -1) {
            sum += self[i]
            if sum > suml {
                suml = sum
                il = i
            }
        }
        // crossing sum, right half: build the sum from the element after the middle element rightwards
        sum = Element.zero
        var sumr: Element = self[m + 1]
        var ir: Int = m + 1
        for i in stride(from: m + 1, through: r, by: 1) {
            sum += self[i]
            if sum > sumr {
                sumr = sum
                ir = i
            }
        }
        // combine the two halves of the crossing sum, choose the maximum sum
        return Swift.max(left, Subarray(suml + sumr, l: il, r: ir), right)
    }
    private struct Subarray: Comparable {
        let sum: Element
        let l: Int, r: Int
        init(_ sum: Element, l: Int, r: Int) {
            self.sum = sum
            self.l = l; self.r = r
        }
        static func < (lhs: Array<Element>.Subarray, rhs: Array<Element>.Subarray) -> Bool {
            return lhs.sum < rhs.sum
        }
    }
}
