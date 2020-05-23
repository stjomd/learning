//
//  UndirectedGraph.swift
//  Learning
//
//  Created by Artem Zhukov on 22.05.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

class UndirectedGraph<Element: Hashable>: DirectedGraph<Element> {
    
    /// The amount of unique edges in the graph.
    ///
    /// In undirected graphs, an undirected edge is considered to be two directed ones. Therefore, for undirected graphs, the value of `edgeCount` is actually double what one might expect. This property returns the amount of unique edges (two edges that connect the same two vertices are counted as one).
    /// - Complexity: O(1)
    var uniqueEdgeCount: Int {
        return super.edgeCount / 2
    }
    
    /// The vertices that are reachable from a given vertex.
    /// - Precondition: The graph contains `vertex`.
    /// - Complexity: O(deg *v*), where *v* is the `vertex`, and deg *v* is the degree of *v*.
    /// - Parameter vertex: The vertex the neighbors of which are to be returned.
    /// - Returns: An array of vertices that are reachable from `vertex`.
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
    
    override func disconnect(_ from: Element, _ to: Element) {
        super.disconnect(from, to)
        super.disconnect(to, from)
    }
    
}
