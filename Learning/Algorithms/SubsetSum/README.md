#  Subset sum problem

```swift
extension Array where Element: AdditiveArithmetic {
    func subset(sum: Element) -> [Element]
    func subsets(sum: Element) -> [[Element]]
    func hasSubset(sum: Element) -> Bool
}
```

Given an array of numbers, find such a subset of this array that its elements sum to a given value.

The methods can be called on any array with elements that support addition (i.e. elements that conform to `AdditiveArithmetic`).
