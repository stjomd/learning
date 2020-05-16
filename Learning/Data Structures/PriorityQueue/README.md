#  Priority Queue

```swift
class PriorityQueue<Element, Priority>
```
Priority Queue is a data structure that is convenient and efficient when it's necessary to repeatedly retrieve an element with the highest (or lowest) priority.

To create a priority queue, you need to specify the type of the element that is stored, as well as the type of the priority (usually an `Int` or `Double`, but can be any type). You also need to pass a closure that takes two objects of the priority type and returns a value indicating if the first priority is "more important" than the second.
```swift
var a = PriorityQueue<String, Int>(<)
a.enqueue("Hello", priority: 1)
a.enqueue("world", priority: 2)
a.enqueue("sup", priority: 3)
print(a.dequeue())
// Prints "Hello"
var b = PriorityQueue<String, Int>(>)
b.enqueue("Hello", priority: 1)
b.enqueue("world", priority: 2)
b.enqueue("sup", priority: 3)
print(b.dequeue())
// Prints "sup"
```
This priority queue is a wrapper for a heap. The same behaviour can be achieved on a heap data structure, however this class hides unnecessary methods that are not relevant for situations when a priority queue is.

To change priority of an element, call `changePriority(at:to:)`. You need to know the index of the element in the heap. If the element type conforms to `Equatable`, another method becomes available: `changePriority(of:to:)`, which finds the element in the heap and changes the priority.
