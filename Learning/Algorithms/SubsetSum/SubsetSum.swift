//
//  SubsetSum.swift
//  Learning
//
//  Created by Artem Zhukov on 07.05.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

extension Array where Element: AdditiveArithmetic {
    /// Returns one possible subset of the original array the elements of which sum to a given value.
    ///
    /// It's not guaranteed this method returns the simplest possible solution.
    ///
    ///     var a = [12, 5, 3, -2, 8, -1]
    ///     print(a.subset(sum: 5))
    ///     // Prints "[-2, 8, -1]"
    ///
    ///     var b = [12, 8, 3, -2, 5, -1]
    ///     print(b.subset(sum: 5))
    ///     // Prints "[5]"
    ///
    /// - Complexity: O(*n*2^*n*)
    /// - Parameter sum: The value to which the elements of the subset must sum.
    /// - Returns: An array with some elements of the original array that sum to `sum`. When the passed `sum` is `0`, an empty array is returned.
    func subset(sum: Element) -> [Element] {
        if sum == Element.zero {
            return []
        }
        var mask = Array<Bool>.init(bitCount: count)
        var ones: Int
        repeat {
            ones = 0
            var currentSum = Element.zero
            var summands: [Element] = []
            for i in 0..<self.count where mask[i] {
                currentSum += self[i]
                summands.append(self[i])
                ones += 1
            }
            if currentSum == sum {
                return summands
            }
            mask.advance()
        } while ones != 0
        return []
    }
    /// Returns all possible subsets of the original array the elements of which sum to a given value.
    ///
    ///     var a = [12, 5, 3, -2, 8, -1]
    ///     print(a.subset(sum: 5))
    ///     // Prints "[[-2, 8, -1], [5], [5, 3, -2, -1]]"
    ///
    /// - Complexity: O(*n*2^*n*)
    /// - Parameter sum: The value to which the elements of the subsets must sum.
    /// - Returns: An array of all possible arrays, each of which contains some elements of the original array that sum to `sum`.
    func subsets(sum: Element) -> [[Element]] {
        var ans: [[Element]] = []
        var mask = Array<Bool>.init(bitCount: count)
        var ones: Int
        repeat {
            ones = 0
            var currentSum = Element.zero
            var summands: [Element] = []
            for i in 0..<self.count where mask[i] {
                currentSum += self[i]
                summands.append(self[i])
                ones += 1
            }
            if currentSum == sum {
                ans.append(summands)
            }
            mask.advance()
        } while ones != 0
        return ans
    }
    /// Returns `true` if there is at least one subset of the original array the elements of which sum to a given value.
    ///
    /// If you don't need to know what the subset itself is, but rather if it only exists, use this more efficient method instead of using `subset(sum:).isEmpty`.
    ///
    ///     var a = [12, 5, 3, -2, 8, -1]
    ///     a.hasSubset(sum: 5)
    ///     // true
    ///
    /// - Complexity: O(2^*n*)
    /// - Parameter sum: The value to which the elements of a subset must sum.
    /// - Returns: `true` if such a subset exists, and `false` otherwise.
    func hasSubset(sum: Element) -> Bool {
        return hasSubset(sum: sum, r: self.count - 1)
    }
    private func hasSubset(sum: Element, r: Index) -> Bool {
        if sum == Element.zero {
            return true
        } else if r == 0 {
            return false
        }
        return hasSubset(sum: sum, r: r - 1) || hasSubset(sum: sum - self[r - 1], r: r - 1)
    }
}

extension Array where Element == Bool {
    fileprivate init(bitCount: Int) {
        self.init(repeating: false, count: bitCount)
        self[bitCount - 1] = true
    }
    mutating fileprivate func advance() {
        for i in stride(from: self.count - 1, through: 0, by: -1) {
            if self[i] {
                self[i] = false
            } else {
                self[i] = true
                break
            }
        }
    }
}
