//
//  File.swift
//  Learning
//
//  Created by Artem Zhukov on 23.04.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

/// A type that can sort an array of objects.
///
/// Any class that conforms to `SortingAlgorithm` can be used by `Array`'s methods `customSort(_:by:)` and `customSorted(_:by:)`.
///
///     var array = [3, 5, 1, 2, 0]
///     array.customSort(BubbleSort())
///     // array = [0, 1, 2, 3, 5]
///     let newArray = array.customSorted(InsertionSort(), by: >)
///     // newArray = [5, 3, 2, 1, 0]
///
/// To conform to `SortingAlgorithm`, implement the following method:
///
///     func sort<T: Comparable>(_ array: inout Array<T>, by comparator: (T, T) -> Bool)
///
/// `sort(_:by:)` sorts `array` in-place, without copying.
protocol SortingAlgorithm {
    func sort<T: Comparable>(_ array: inout Array<T>, by comparator: (T, T) -> Bool)
}

extension Array where Element: Comparable {
    
    typealias Comparator = (Element, Element) -> Bool
    
    /// Sorts the array in-place using the specified algorithm.
    ///
    /// You do not have to specify the last parameter. By default, the array will be sorted in ascending order (as defined for the respective
    /// type).
    ///
    ///     var array = [3, 1, 8, 2]
    ///     array.customSort(BubbleSort())
    ///     // array = [1, 2, 3, 8]
    ///     array.customSort(InsertionSort(), >)
    ///     // array = [8, 3, 2, 1]
    ///
    /// If you wish to sort in descending order, pass `>` as the second parameter.
    ///
    /// - Complexity: See the documentation for the respective type of `algorithm`.
    /// - Parameter algorithm: The sorting algorithm object to be used for sorting.
    /// - Parameter comparator: A function or closure that returns a Boolean value. It should return `true` if the first element should come
    /// before the second in the sorted array.
    mutating func customSort<SomeSort: SortingAlgorithm>(_ algorithm: SomeSort, by comparator: Comparator = {$0 < $1}) {
        algorithm.sort(&self, by: comparator)
    }
    
    /// Returns a sorted array using the specified algorithm.
    ///
    /// You do not have to specify the last parameter. By default, the array will be sorted in ascending order (as defined for the respective
    /// type).
    ///
    ///     var array = [3, 1, 8, 2]
    ///     array.customSorted(BubbleSort())
    ///     // [1, 2, 3, 8]
    ///     array.customSorted(BubbleSort(), >)
    ///     // [8, 3, 2, 1]
    ///
    /// If you wish to sort in descending order, pass `>` as the second parameter.
    ///
    /// - Complexity: At least Ω(*n*), as the array has to be copied. For more details, see the documentation for the respective type of
    /// `algorithm`.
    /// - Parameter algorithm: The sorting algorithm object to be used for sorting.
    /// - Parameter comparator: A function or closure that returns a Boolean value. It should return `true` if the first element should come
    /// before the second in the sorted array.
    /// - Returns: The sorted array.
    func customSorted<SomeSort: SortingAlgorithm>(_ algorithm: SomeSort, by comparator: Comparator = {$0 < $1}) -> Self {
        var copy = self
        copy.customSort(algorithm, by: comparator)
        return copy
    }
    
}
