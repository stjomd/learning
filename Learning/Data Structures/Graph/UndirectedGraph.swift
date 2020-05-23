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
    
    override func add(vertex: Element) {
        super.add(vertex: vertex)
    }
    
    override func add(vertex: Element, adjacentWith vertices: [Element], weights: [Weight]? = nil) {
        if let _ = weights {
            precondition(weights!.count == vertices.count, "The array of weights must be equal in length to the array of vertices")
        }
        super.add(vertex: vertex)
        for i in vertices.indices {
            super.add(vertex: vertices[i])
            connect(vertex, to: vertices[i], weight: weights?[i] ?? 1.0)
        }
    }
    
    override func add(vertex: Element, adjacentWith vertices: Element...) {
        super.add(vertex: vertex, adjacentWith: vertices, weights: nil)
    }
    
    override func connect(_ startVertex: Element, to endVertex: Element, weight: Weight = 1.0) {
        super.connect(startVertex, to: endVertex, weight: weight)
        super.connect(endVertex, to: startVertex, weight: weight)
    }    
    
    override func removeEdge(_ from: Element, _ to: Element) {
        super.removeEdge(from, to)
        super.removeEdge(to, from)
    }
    
}
