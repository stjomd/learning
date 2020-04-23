//
//  Sieve of Eratosthenes.swift
//  Learning
//
//  Created by Artem Zhukov on 23.04.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

/// Encapsulates functions that return an array of prime numbers using the Sieve of Eratosthenes.
///
/// To call one of the functions, type the name of the enumeration, a dot, and the function.
///
///     let primes = SieveOfEratosthenes.primes(2...30)
///
/// - Complexity: O(n log log n)
enum SieveOfEratosthenes {
    
    public static func primes(through upperBound: Int) -> [Int] {
        return primes(from: 2, to: upperBound)
    }
    
    public static func primes(in range: ClosedRange<Int>) -> [Int] {
        return primes(from: range.lowerBound, to: range.upperBound)
    }
    
    public static func primes(in range: Range<Int>) -> [Int] {
        return primes(from: range.lowerBound, to: range.upperBound - 1)
    }
    
    private static func primes(from lowerBound: Int, to upperBound: Int) -> [Int] {
        
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
                for j in stride(from: i*i, through: upperBound, by: i) {
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

