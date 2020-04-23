//
//  Stack.swift
//  Learning
//
//  Created by Artem Zhukov on 23.04.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

public struct Stack<T> {
    
    private var stack: [T] = []

    /// The number of elements in the stack.
    /// - Complexity: O(1)
    var count: Int {
        stack.count
    }
    
    /// A Boolean value indicating whether the stack is empty.
    /// - Complexity: O(1)
    var isEmpty: Bool {
        stack.isEmpty
    }
    
    /// The top element of the stack.
    /// - Complexity: O(1)
    var top: T? {
        stack.last
    }
    
    /// Adds a new element to the top of the stack.
    /// - Parameter newElement: The element to add to the stack.
    /// - Complexity: O(1) on average, over many calls to push(_:) on the same stack, O(n) in worst case.
    mutating func push(_ newElement: T) {
        stack.append(newElement)
    }
    
    /// Removes and returns the top element of the stack.
    /// - Returns: The element that has been removed, or `nil` if the stack is empty.
    /// - Complexity: O(1)
    @discardableResult mutating func pop() -> T? {
        return stack.popLast()
    }
    
    /// Creates a new, empty stack.
    /// - Complexity: O(1)
    init() {
    }
    
}

extension Stack: CustomStringConvertible {
    public var description: String {
        return stack.description
    }
}

extension Stack: Equatable where T: Equatable {
    public static func == (lhs: Stack<T>, rhs: Stack<T>) -> Bool {
        return lhs.stack == rhs.stack
    }
}