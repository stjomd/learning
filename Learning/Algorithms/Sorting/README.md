#  Sorting algorithms

All sorting algorithms have to be located in the file `Sorting.swift`. Only one function with the following signature has to be implemented, for clarity in an extension:
```swift
extension Array where Element: Comparable {
    fileprivate mutating func algorithmName(by comparator: Comparator) {
        ...
    }
}
```
This function will not be directly accessible. To try the sorting algorithm out, use `customSort` or `customSorted` methods. The first parameter defines the sorting algorithm to be used. The second parameter is optional (refer to the documentation for more details). By default, the array is sorted in ascending order:
```swift
var array = [1, 5, 2, 9, 4, 3]
array.customSort(.bubbleSort)
// array = [1, 2, 3, 4, 5, 9]
```
To sort it in descending order, pass `>` operator as the second parameter.
```swift
var array = [1, 5, 2, 9, 4, 3].customSorted(.insertionSort, >)
// array = [9, 5, 4, 3, 2, 1]
```

## Implemented algorithms

Algorithm | Average complexity
:---------- | :---------------------:
Bubble Sort | O(*n*^2)
Insertion Sort | O(*n*^2)
