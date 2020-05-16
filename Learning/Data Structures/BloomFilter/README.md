#  Bloom filter

```swift
class BloomFilter<Element>
```

A Bloom filter is a probabilistic data structure that is used to determine if an element is *definitely not* contained in a set.

```swift
let bloom = BloomFilter<Int>(length: length, highestHashPrime: 10)
print(bloom.definitelyNotContains(12))
// Prints "true" – 12 is definitely not in the set
bloom.add(12)
print(bloom.definitelyNotContains(12))
// Prints "false" – 12 might be in the set, or might not be
bloom.add(22)
bloom.add(45)
bloom.add(85)
print(bloom.definitelyNotContains(99))
// Prints "false" – 99 might be in the set, or might not be
print(bloom.definitelyNotContains(115))
// Prints "true" – 115 is definitely not in the set
```
