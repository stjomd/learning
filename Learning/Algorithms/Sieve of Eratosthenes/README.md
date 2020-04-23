#  Sieve of Eratosthenes

Used to get an array of prime numbers.
Example:
```swift
SieveOfEratosthenes.primes(in: 0..<29)
// [2, 3, 5, 7, 11, 13, 17, 19, 23]
SieveOfEratosthenes.primes(in: 0...29)
// [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
SieveOfEratosthenes.primes(through: 30)
// [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
SieveOfEratosthenes.primes(through: 0)
// []
SieveOfEratosthenes.primes(through: -5)
// []
```
The complexity is O(n log log n).
