#  Queue

```swift
struct Queue<T>: CustomStringConvertible
```

The classic implementation of a queue (using a singly linked list). `Queue<T>` will also conform to `Equatable` if the underlying type `T` conforms to it.
Enqueueing and dequeueing is done in O(1).
