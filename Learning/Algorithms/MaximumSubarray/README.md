#  Maximum Subarray Problem

Given an array, find the contiguous subarray with the largest possible sum.

Call the method on an array to get an `ArraySlice` object that represents this subarray.
```swift
let array = [1, -6, 3, -5, -9, 2, 10, 3, 0, 5, 0, 12, -2, 1]
let sub = array.maximumSubarray()
// sub = [2, 10, 3, 0, 5, 0, 12]
```
The objects in the array must conform to `AdditiveArithmetic` and `Comparable`. The array must not be empty.

This directory includes a divide-and-conquer implementation – `maximumSubarrayDC()`, which is in O(*n* log *n*), as well as the Kadane's algorithm – `maximumSubarray()`, which is in O(*n*). Both return the same `ArraySlice` object.

To get the valid indices of the subarray, access the `indices` property.
```swift
for i in sub.indices {
    print("i: \(i), A[i]: \(array[i])")
}
// Prints:
// i: 5, A[i]: 2
// i: 6, A[i]: 10
// i: 7, A[i]: 3
// i: 8, A[i]: 0
// i: 9, A[i]: 5
// i: 10, A[i]: 0
// i: 11, A[i]: 12
print(sub.indices.first!)
// Prints "5"
print(sub.indices.last!)
// Prints "11"
```
The methods don't return the actual largest sum. Use a loop or `reduce` to do that.
```swift
var sum = 0
for element in sub {
    sum += element
}
// sum = 32
sum = sub.reduce(0) { $0 + $1 }
// sum = 32
```
