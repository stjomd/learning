//
//  File.swift
//  Learning
//
//  Created by Artem Zhukov on 23.04.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

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
    ///     array.customSort(.bubbleSort)
    ///     // array = [1, 2, 3, 8]
    ///     array.customSort(.bubbleSort, >)
    ///     // array = [8, 3, 2, 1]
    ///
    /// If you wish to sort in descending order, pass `>` as the second parameter.
    ///
    /// For available algorithms, see `SortingAlgorithm`.
    /// - Complexity: See the documentation for the passed `algorithm` variable.
    /// - Parameter algorithm: The algorithm to be used for sorting.
    /// - Parameter comparator: A function or closure that returns a Boolean value. It should return `true` if the first element should come
    /// before the second in the sorted array.
    mutating func customSort<T: SortingAlgorithm>(_ algorithm: T, by comparator: Comparator = {$0 < $1}) {
        // Add a new case for every new sorting algorithm inside the switch statement.
        algorithm.sort(&self, by: comparator)
    }
    
    /// Returns a sorted array using the specified algorithm.
    ///
    /// You do not have to specify the last parameter. By default, the array will be sorted in ascending order (as defined for the respective
    /// type).
    ///
    ///     var array = [3, 1, 8, 2]
    ///     array.customSorted(.bubbleSort)
    ///     // [1, 2, 3, 8]
    ///     array.customSorted(.bubbleSort, >)
    ///     // [8, 3, 2, 1]
    ///
    /// If you wish to sort in descending order, pass `>` as the second parameter.
    ///
    /// For available algorithms, see `SortingAlgorithm`.
    /// - Complexity: At least Ω(*n*), as the array has to be copied. For more details, see the documentation for the passed `algorithm` variable.
    /// - Parameter algorithm: The algorithm to be used for sorting.
    /// - Parameter comparator: A function or closure that returns a Boolean value. It should return `true` if the first element should come
    /// before the second in the sorted array.
    /// - Returns: The sorted array.
    func customSorted<T: SortingAlgorithm>(_ algorithm: T, by comparator: Comparator = {$0 < $1}) -> Self {
        var copy = self
        copy.customSort(algorithm, by: comparator)
        return copy
    }
    
}
