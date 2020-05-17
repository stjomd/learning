//
//  BloomFilter.swift
//  Learning
//
//  Created by Artem Zhukov on 16.05.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

// MARK: - Standard Bloom Filter
class BloomFilter<Element> {
    
    typealias HashFunction = (Element) -> Int
    
    fileprivate(set) var mask: [Bool]
    fileprivate(set) var hashFunctions: [HashFunction]
    
    fileprivate(set) var count: Int = 0
    
    var length: Int {
        return mask.count
    }
    
    var functionsCount: Int {
        return hashFunctions.count
    }
    
    init(length: Int, hashFunctions: [HashFunction]) {
        self.mask = Array(repeating: false, count: length)
        self.hashFunctions = hashFunctions
    }
    
    func add(_ item: Element) {
        let positions = bits(item)
        for i in positions {
            mask[i] = true
        }
        count += 1
    }
    
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
    convenience init(length: Int, highestHashPrime: Int) {
        self.init(length: length, hashFunctions: [])
        self.hashFunctions = generatePrimeExponentials(highestExponent: highestHashPrime)
    }
}
