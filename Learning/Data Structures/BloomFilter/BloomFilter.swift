//
//  BloomFilter.swift
//  Learning
//
//  Created by Artem Zhukov on 16.05.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

// MARK: - Standard Bloom Filter

/// A probabilistic data structure that can be used to check if an element is not contained in a set.
///
/// When an element is added to a bloom filter, its hash values are calculated by several functions, which return positions in a bit mask. These positions are then set to 1.
///
/// When checking if an element is contained in the set, it's hash values (positions in a bit mask) are calculated again. If at least one bit at these positions is 0, then it's guaranteed that the element is not present in the set. If all bits are 1, it's not clear if the element is in the set or not (as these bits could be set to 1 when adding some other elements).
///
///     var filter = BloomFilter<Int>(length: 35, highestHashPrime: 100)
///     filter.add(15)
///     filter.add(78)
///     print(filter.definitelyNotContains(78))
///     // Prints "false", as 78 is in the set.
///     print(filter.definitelyNotContains(84))
///     // Prints "true": 84 is definitely not contained in the set.
///     print(filter.definitelyNotContains(99))
///     // Prints "false": 99 might or might not be in the set.
///
/// Bloom filters are therefore great for speeding up the `contains` operation (especially when it requires a lot of computing time), as this operation must only be called when the bloom filter is indecisive.
class BloomFilter<Element> {
    
    typealias HashFunction = (Element) -> Int
    
    /// The bit mask that the bloom filter is using.
    ///
    /// Represented as an array of Boolean values.
    fileprivate(set) var mask: [Bool]
    /// The array of hash functions that are used to calculate positions in the bit mask.
    fileprivate(set) var hashFunctions: [HashFunction]
    /// The amount of elements that have been added to the bloom filter.
    fileprivate(set) var count: Int = 0
    /// The length of the bit mask.
    var length: Int {
        return mask.count
    }
    /// The amount of hash functions used.
    var functionsCount: Int {
        return hashFunctions.count
    }
    /// Creates a new bloom filter with a bit mask of given length and specified hash functions.
    ///
    /// The `length` cannot be changed at a later time. Hash functions cannot be added or removed later either.
    /// - Complexity: O(*n*), where *n* is the length of the bit mask.
    /// - Parameter length: The length of the bit mask.
    /// - Parameter hashFunctions: An array of hash functions that will be used to calculate positions in the bit mask. The functions (closures) have to return an integer value. That value can be larger than `length`.
    init(length: Int, hashFunctions: [HashFunction]) {
        self.mask = Array(repeating: false, count: length)
        self.hashFunctions = hashFunctions
    }
    /// Add an element to the bloom filter.
    ///
    /// This will call all hash functions and set the appropriate bits in the bit mask to 1.
    /// - Complexity: O(*m*), where *m* is the amount of hash functions, provided each hash function calculates the hash value in O(1).
    /// - Parameter item: The element to be added.
    func add(_ item: Element) {
        let positions = bits(item)
        for i in positions {
            mask[i] = true
        }
        count += 1
    }
    /// A Boolean value that indicates if it's guaranteed the element is not contained in the bloom filter.
    ///
    /// This will call all hash functions and check the appropriate bits. If at least one of them is 0, the element is guaranteed to have never been added to the bloom filter.
    /// - Complexity: O(*m*), where *m* is the amount of hash functions, provided each hash function calculates the hash value in O(1).
    /// - Parameter item: The element to be checked.
    /// - Returns: `true` if the element is definitely **not** contained in the set, and `false` whether it's not clear.
    func definitelyNotContains(_ item: Element) -> Bool {
        let positions = bits(item)
        for i in positions {
            if !mask[i] {
                return true
            }
        }
        return false
    }
    
    fileprivate func bits(_ item: Element) -> [Int] {
        var positions = [Int]()
        for function in hashFunctions {
            let bit = function(item) % mask.count
            positions.append(bit)
        }
        return positions
    }
    
}

extension BloomFilter where Element == Int {
    /// Creates a new bloom filter with a bit mask of given length and exponential hash functions.
    ///
    /// The hash functions in question are `f(x) = p^x mod m`, where `p` is a prime constant and `m` the length of the bit mask. This constructor will generate π(`highestHashPrime`) functions, where π is a prime-counting function.
    /// - Complexity: O(*n* + *m* log log *m*), where *n* is the length of the bit mask, and *m* is the second argument (`highestHashPrime`).
    /// - Parameter length: The length of the bit mask.
    /// - Parameter highestHashPrime: The upper boundary for prime exponents.
    convenience init(length: Int, highestHashPrime: Int) {
        self.init(length: length, hashFunctions: [])
        self.hashFunctions = generatePrimeExponentials(highestExponent: highestHashPrime)
    }
    fileprivate func generatePrimeExponentials(highestExponent: Int) -> [HashFunction] {
        var fs = [HashFunction]()
        let primes = SieveOfEratosthenes.primes(through: highestExponent)
        for e in primes {
            let f: (Element) -> Int = { x in
                var hash = 1
                for _ in 0..<x {
                    hash = (e * hash) % self.mask.count
                }
                return hash
            }
            fs.append(f)
        }
        return fs
    }
}



// MARK: - Counting Bloom Filter
/// A bloom filter that supports removal of elements.
class CountingBloomFilter<Element>: BloomFilter<Element> {
    
    private var counters: [Int]
    
    override init(length: Int, hashFunctions: [HashFunction]) {
        self.counters = Array(repeating: 0, count: length)
        super.init(length: length, hashFunctions: hashFunctions)
    }
    
    override func add(_ item: Element) {
        for i in bits(item) {
            mask[i] = true
            counters[i] += 1
        }
        count += 1
    }
    
    /// Remove an element from the bloom filter.
    ///
    /// This will call all bit functions and reduce counters at appropriate positions.
    /// - Precondition: The element has been added before or its bits were set to 1 by a combination of other elements.
    /// - Complexity: O(*m*), where *m* is the amount of hash functions, provided each hash function calculates the hash value in O(1).
    /// - Parameter item: The element to be removed.
    func remove(_ item: Element) {
        let positions = bits(item)
        for i in positions where counters[i] == 0 {
            assertionFailure("The item being removed is not present")
        }
        for i in positions {
            counters[i] -= 1
            if counters[i] == 0 {
                mask[i] = false
            }
        }
        count -= 1
    }
    
}

extension CountingBloomFilter where Element == Int {
    /// Creates a new bloom filter with a bit mask of given length and exponential hash functions.
    ///
    /// The hash functions in question are `f(x) = p^x mod m`, where `p` is a prime constant and `m` the length of the bit mask. This constructor will generate π(`highestHashPrime`) functions, where π is a prime-counting function.
    /// - Complexity: O(*n* + *m* log log *m*), where *n* is the length of the bit mask, and *m* is the second argument (`highestHashPrime`).
    /// - Parameter length: The length of the bit mask.
    /// - Parameter highestHashPrime: The upper boundary for prime exponents.
    convenience init(length: Int, highestHashPrime: Int) {
        self.init(length: length, hashFunctions: [])
        self.hashFunctions = generatePrimeExponentials(highestExponent: highestHashPrime)
    }
}
