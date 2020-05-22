//
//  UndirectedGraph.swift
//  Learning
//
//  Created by Artem Zhukov on 22.05.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

class UndirectedGraph<Element: Hashable>: DirectedGraph<Element> {
    
    var uniqueEdgeCount: Int {
        return super.edgeCount / 2
    }
    
    func neighbors(of vertex: Element) -> [Element] {
        return super.successors(of: vertex)
    }
    
    override func add(_ item: Element, adjacentWith: [Element]) {
        super.add(item)
        for vertex in adjacentWith {
            super.add(vertex)
            addEdge(item, vertex)
        }
    }
    
    override func addEdge(_ from: Element, _ to: Element) {
        super.addEdge(from, to)
        super.addEdge(to, from)
    }    
    
    override func removeEdge(_ from: Element, _ to: Element) {
        super.removeEdge(from, to)
        super.removeEdge(to, from)
    }
    
}
