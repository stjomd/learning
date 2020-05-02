#  Binary Search
```swift
extension Array where Element: Comparable {
    func binarySearch(for element: Element) -> Int?
}
```
Binary Search is an efficient searching algorithm that can be used on sorted arrays. Instead of usual linear O(*n*) searching time, Binary Search's complexity is logarithmic – O(log *n*).

This algorithm only works on sorted arrays. If the array is unsorted, the result may be unexpected.

Call `binarySearch(for:)` on any array with objects that conform to `Comparable`.
```swift
let array = [1, 2, 4, 5, 7, 9, 11]
let index = array.binarySearch(for: 7)
// index = Optional(4)
```
The method returns an optional – if the element is not present in the array, `nil` is returned.
```swift
index = array.binarySearch(for: 6)
// index = nil
```
