#  Deque

```swift
struct Deque<T>: CustomStringConvertible
```

The classic implementation of a deque using a doubly linked list. A singly linked list would make the deque not as efficient (popping the last element would be in O(*n*), as opposed to O(1) with a doubly linked list).

`Deque<T>` will also conform to `Equatable` if the underlying type `T` conforms to it.
