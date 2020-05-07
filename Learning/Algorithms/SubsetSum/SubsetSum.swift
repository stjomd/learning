//
//  SubsetSum.swift
//  Learning
//
//  Created by Artem Zhukov on 07.05.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

extension Array where Element: AdditiveArithmetic {
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
