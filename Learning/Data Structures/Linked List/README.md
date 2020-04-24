#  Linked List

```swift
public struct LinkedList<T>: Collection, ExpressibleByArrayLiteral, CustomStringConvertible
```

This particular implementation is of a doubly linked list (every node keeps a reference to the previous and to the next node).

## Usage

```swift
let emptyList = LinkedList<Int>()
let listFromInit = LinkedList<Int>(1, 2, 3, 4, 5)
let listFromArray = LinkedList<Int>([1, 2, 3, 4, 5])
```
Since `LinkedList` conforms to `ExpressibleByArrayLiteral`, it can also be initialized as follows:
```swift
let listFromArrayLiteral: LinkedList<Int> = [1, 2, 3, 4, 5]
```
This requires an explicit type annotation.

`LinkedList` can be looped through (thanks to conformance to `Collection`):
```swift
for element in list {
    print(element, terminator: " ")
}
// Prints "1 2 3 4 5 "
```

Elements can be accessed with a subscript. This, however, is not recommended, as it's an O(*n*) operation on average (as opposed to O(1) for arrays). If accessing the first or the last element, it's an O(1) operation as well.
```swift
list[0]
/// 1
```
