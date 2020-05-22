//
//  UndirectedGraph.swift
//  Learning
//
//  Created by Artem Zhukov on 22.05.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

class UndirectedGraph<Element: Hashable>: DirectedGraph<Element> {
    
    override var edgeCount: Int {
        return _edgeCount
    }
    private var _edgeCount = 0
    
    override func add(_ item: Element, adjacentWith: [Element]) {
        super.add(item)
        for vertex in adjacentWith {
            super.add(vertex)
            super.addEdge(item, vertex)
            super.addEdge(vertex, item)
            _edgeCount += 1
        }
    }
    
}
