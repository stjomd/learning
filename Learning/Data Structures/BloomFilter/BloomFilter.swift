//
//  BloomFilter.swift
//  Learning
//
//  Created by Artem Zhukov on 16.05.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

class BloomFilter<Element> {
    
    typealias HashFunction = (Element) -> Int
    
    private var mask: [Bool]
    private var hashFunctions: [HashFunction]
    
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
    
    private func bits(_ item: Element) -> [Int] {
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
    private func generatePrimeExponentials(highestExponent: Int) -> [HashFunction] {
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
