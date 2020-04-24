//
//  LinkedList.swift
//  Learning
//
//  Created by Artem Zhukov on 24.04.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

protocol LinkedList {
    associatedtype ElementType
    associatedtype NodeType
    
    var head: NodeType? { get }
    var toe: NodeType? { get }
    var isEmpty: Bool { get }
    var count: Int { get }
    
    init()
    init(_ items: ElementType...)
    
    subscript(index: Int) -> ElementType { get set }
    
    mutating func append(_ item: ElementType)
    mutating func insert(_ item: ElementType, at index: Int)
    @discardableResult mutating func removeFirst() -> ElementType
    @discardableResult mutating func removeLast() -> ElementType
    @discardableResult mutating func remove(at index: Int) -> ElementType
    mutating func removeAll()
}

