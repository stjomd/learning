//
//  File.swift
//  Learning
//
//  Created by Artem Zhukov on 23.04.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

//  MARK: - Protocol

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
    func sort<T>(_ array: inout Array<T>, by comparator: (T, T) -> Bool)
}

//  MARK: - Extension for all types
extension Array {
    
    typealias Comparator = (Element, Element) -> Bool
    
    /// Sorts the array in-place using the specified algorithm.
    ///
    /// If the objects in the array don't conform to `Comparable`, pass a closure to the second parameter that returns true when the first element should be ordered before the second.
    ///
    ///     struct Document {
    ///         let idNumber: Int;
    ///         init(_ id: Int) { idNumber = id }
    ///     }
    ///     var array = [Document(1664672), Document(1623511), Document(1892732)]
    ///     array.customSort(InsertionSort(), by: {
    ///         $0.idNumber < $1.idNumber
    ///     })
    ///     // array = [Document(1623511), Document(1664672), Document(1892732)]
    ///
    /// - Complexity: See the documentation for the respective type of `algorithm`.
    /// - Parameter algorithm: The sorting algorithm object to be used for sorting.
    /// - Parameter comparator: A closure that returns a Boolean value. It should return `true` if the first element should be ordered before the second in the array.
    mutating func customSort<SomeSort: SortingAlgorithm>(_ algorithm: SomeSort, by comparator: Comparator) {
        algorithm.sort(&self, by: comparator)
    }
    
    /// Returns a sorted array using the specified algorithm.
    ///
    /// If the objects in the array don't conform to `Comparable`, pass a closure to the second parameter that returns true when the first element should be ordered before the second.
    ///
    ///     struct PersonalDocument {
    ///         let idNumber: Int;
    ///         init(_ id: Int) { idNumber = id }
    ///     }
    ///     var array = [Document(1664672), Document(1623511), Document(1892732)]
    ///     array.customSorted(InsertionSort(), by: {
    ///         $0.idNumber > $1.idNumber
    ///     })
    ///     // [Document(1892732), Document(1664672), Document(1623511)]
    ///
    /// - Complexity: At least Ω(*n*), as the array has to be copied. For more details, see the documentation for the respective type of
    /// `algorithm`.
    /// - Parameter algorithm: The sorting algorithm object to be used for sorting.
    /// - Parameter comparator: A closure that returns a Boolean value. It should return `true` if the first element should be ordered before the second in the sorted array.
    /// - Returns: The sorted array.
    func customSorted<SomeSort: SortingAlgorithm>(_ algorithm: SomeSort, by comparator: Comparator) -> Self {
        var copy = self
        copy.customSort(algorithm, by: comparator)
        return copy
    }
    
}

//  MARK: - Extension for comparables
extension Array where Element: Comparable {
    
    /// Sorts the array in-place using the specified algorithm.
    ///
    /// You can sort any array of objects that conform to `Comparable`. The default order is ascending.
    ///
    ///     var array = [3, 1, 8, 2]
    ///     array.customSort(BubbleSort())
    ///     // array = [1, 2, 3, 8]
    ///
    /// If you wish to sort in descending order, pass `>` as the second parameter.
    ///
    ///     array.customSort(InsertionSort(), >)
    ///     // array = [8, 3, 2, 1]
    ///
    /// - Complexity: See the documentation for the respective type of `algorithm`.
    /// - Parameter algorithm: The sorting algorithm object to be used for sorting.
    mutating func customSort<SomeSort: SortingAlgorithm>(_ algorithm: SomeSort) {
        algorithm.sort(&self, by: <)
    }
    
    /// Returns a sorted array using the specified algorithm.
    ///
    /// You can sort any array of objects that conform to `Comparable`. The default order is ascending.
    ///
    ///     var array = [3, 1, 8, 2]
    ///     array.customSorted(BubbleSort())
    ///     // [1, 2, 3, 8]
    ///
    /// If you wish to sort in descending order, pass `>` as the second parameter.
    ///
    ///     array.customSorted(BubbleSort(), >)
    ///     // [8, 3, 2, 1]
    ///
    /// - Complexity: At least Ω(*n*), as the array has to be copied. For more details, see the documentation for the respective type of
    /// `algorithm`.
    /// - Parameter algorithm: The sorting algorithm object to be used for sorting.
    /// - Returns: The sorted array.
    func customSorted<SomeSort: SortingAlgorithm>(_ algorithm: SomeSort) -> Self {
        var copy = self
        copy.customSort(algorithm, by: <)
        return copy
    }
    
}
