//
//  Sieve of Eratosthenes.swift
//  Learning
//
//  Created by Artem Zhukov on 23.04.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

/// Encapsulates functions that return an array of prime numbers using the Sieve of Eratosthenes.
///
/// To call one of the methods, type the name of the enumeration, a dot, and the function.
///
///     let primes = SieveOfEratosthenes.primes(2...30)
///
/// All methods will return an empty array if the arguments define an invalid range.
///
///     SieveOfEratosthenes.primes(through: -5)
///     // []
///
/// - Complexity: O(n log log n) for all methods.
enum SieveOfEratosthenes {
    
    /// Returns an array of prime numbers not greather than a given value.
    /// - Complexity: O(n log log n)
    /// - Parameter upperBound: The upper bound for a value in the resulting array. If `upperBound` is prime, it will be included in the array.
    /// - Returns: An array of all prime numbers less than or equal to `upperBound`.
    public static func primes(through upperBound: Int) -> [Int] {
        return primes(from: 2, to: upperBound)
    }
    
    /// Returns an array of prime numbers that are in the given range.
    /// - Complexity: O(n log log n)
    /// - Parameter range: The range from which prime numbers should be returned.
    /// - Returns: An array of all prime numbers that are also in `range`.
    public static func primes(in range: ClosedRange<Int>) -> [Int] {
        return primes(from: range.lowerBound, to: range.upperBound)
    }
    
    /// Returns an array of prime numbers that are in the given range.
    /// - Complexity: O(n log log n)
    /// - Parameter range: The range from which prime numbers should be returned.
    /// - Returns: An array of all prime numbers that are also in `range`.
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

