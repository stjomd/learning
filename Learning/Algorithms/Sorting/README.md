#  Sorting algorithms

Every sorting algorithm is an object that conforms to protocol `SortingAlgorithm`. It requires that the following method be implemented:
```swift
func sort<T>(_ array: inout Array<T>, by areInIncreasingOrder: (T, T) -> Bool)
```
where sorting is performed in-place on `array`, and `areInIncreasingOrder` is a closure that returns `true` if the first element should be ordered before the second.

## Usage

Call `customSort(_:)`, `customSorted(_:)` on arrays with objects that conform to `Comparable`, and `customSort(_:by:)`, `customSorted(_:by:)` on all arrays. Pass the sorting algorithm object to the first parameter. The default sorting order is ascending:
```swift
var array = [1, 5, 2, 0, 3]
array.customSort(BubbleSort())
// array = [0, 1, 2, 3, 5]
```
If you wish to sort in descending order, pass the `>` operator to the second parameter on arrays with objects that conform to `Comparable`:
```swift
var array = [1, 5, 2, 0, 3]
print(array.customSorted(BubbleSort(), by: >))
// Prints "[5, 3, 2, 1, 0]"
```
If the objects in the array do not conform to `Comparable`, pass a closure to the second parameter that returns `true` if the first element should be ordered before the second.
```swift
struct Document {
    var name: String
    let id: Int
    init(_ name: String, _ id: Int) {
        self.name = name
        self.id = id
    }
}
var array = [Document("John Appleseed", 183493),
             Document("Max Müller", 182977),
             Document("Ivan Ivanov", 190532)]
print(array.customSorted(InsertionSort(), by: { $0.id < $1.id }))
// Prints "[Document(name: "Max Müller", id: 182977), Document(name: "John Appleseed", id: 183493), Document(name: "Ivan Ivanov", id: 190532)]"
```

## Implemented algorithms

Algorithm | Average performance | Worst-case performance
:---------- | :-----------------------: | :----------------------------:
Bubble Sort | O(*n*^2) | O(*n*^2)
Insertion Sort | O(*n*^2) | O(*n*^2)
Selection Sort | O(*n*^2) | O(*n*^2)
Merge Sort | O(*n* log *n*) | O(*n* log *n*)
Quicksort | O(*n* log *n*) | O(*n*^2)
