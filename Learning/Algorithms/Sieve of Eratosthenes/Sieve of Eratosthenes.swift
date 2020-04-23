//
//  Sieve of Eratosthenes.swift
//  Learning
//
//  Created by Artem Zhukov on 23.04.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

enum SieveOfEratosthenes {
    
    static func primes(in range: ClosedRange<Int>) -> [Int] {
        return primes(from: range.lowerBound, to: range.upperBound)
    }
    
    static func primes(from lowerBound: Int, to upperBound: Int) -> [Int] {
        
        var isPrime = Array(repeating: true, count: max(2, upperBound + 1))
        isPrime[1] = false
        
        for i in stride(from: 4, through: upperBound, by: 2) {  // get rid of even numbers except 2
            isPrime[i] = false
        }
        for i in stride(from: 3, through: upperBound, by: 2) {  // check odd numbers only
            if isPrime[i] {
                if i*i > upperBound {
                    break
                }
                for j in stride(from: 2*i, through: upperBound, by: i) {
                    isPrime[j] = false
                }
            }
        }
        
        var primes: [Int] = []
        for i in stride(from: 2, through: upperBound, by: 1) {
            if isPrime[i] {
                primes.append(i)
            }
        }
        return primes
        
    }
    
}

