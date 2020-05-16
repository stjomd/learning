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
    
    func notContains(_ item: Element) -> Bool {
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
