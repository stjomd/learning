//
//  Dijkstra.swift
//  Learning
//
//  Created by Artem Zhukov on 23.05.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

extension DirectedGraph {
    
    // MARK: DijkstraSolution
    
    /// A type that encapsulates data associated with the Dijkstra's algorithm.
    ///
    /// You can access the vertex that was used as a start vertex, as well as the distance from that vertex to any vertex in the graph. You can also calculate the shortest path from the start vertex to any vertex in the graph.
    /// - Complexity: Required memory is O(*n*), where *n* is the number of vertices in the graph.
    struct DijkstraSolution {
        
        /// The vertex that was used a start vertex.
        private(set) var startVertex: Element
        private var distances: [Element: Weight]
        private var predecessors: [Element: Element?]
        
        fileprivate init(startVertex: Element, distances: [Element: Weight], predecessors: [Element: Element?]) {
            self.startVertex = startVertex; self.distances = distances; self.predecessors = predecessors
        }
        
        /// The shortest path from the start vertex to the given vertex.
        ///
        /// This method reconstructs the shortest path from the data that Dijkstra's algorithm provides.
        /// - Precondition: The graph contains `vertex`.
        /// - Complexity: O(*m*), where *m* is the number of edges in the graph.
        /// - Parameter vertex: The target vertex.
        /// - Returns: An array of vertices that describe a path from the start vertex to `vertex`.
        func path(to vertex: Element) -> [Element] {
            precondition(distances[vertex] != nil, "The vertex is not present in the graph")
            var path = [Element]()
            if predecessors[vertex] != nil || vertex == startVertex {
                var u: Element? = vertex
                while let _ = u {
                    path.append(u!)
                    u = predecessors[u!] ?? nil
                }
            }
            return path.reversed()
        }
        
        /// The shortest distance from the start vertex to the given vertex.
        ///
        /// This method returns the shortest distance that the Dijkstra's algorithm has calculated.
        /// - Precondition: The graph contains `vertex`.
        /// - Complexity: O(1)
        /// - Parameter vertex: The target vertex.
        /// - Returns: The shortest distance.
        func distance(to vertex: Element) -> Weight {
            precondition(distances[vertex] != nil, "The vertex is not present in the graph")
            return distances[vertex]!
        }
        
    }
    
    // MARK: - Methods
        
    /// Perform the Dijkstra's algorithm on the graph.
    ///
    /// Note that any changes to the graph might invalidate the solution. Call this method if you need the shortest distance or path to several vertices. If you only need a path to a vertex once, call `shortestPath(from:to:)` instead.
    /// - Precondition: All edges in the graph have positive weights. The method does not check if this is the case.
    /// - Complexity: O(*n* + *m* log *n*), where *n* is the number of vertices, and *m* the number of edges in the graph. The returned object requires O(*n*) space.
    /// - Parameter startVertex: The vertex from which the shortest distances are calculated.
    /// - Returns: A `DijkstraSolution` object, which can be used to calculate the shortest paths or access the shortest distances.
    func dijkstra(from startVertex: Element) -> DijkstraSolution {
        var distance: [Element: Weight] = [startVertex: 0]
        var predecessor = [Element: Element?]()
        let queue = PriorityQueue<Element, Weight>(<)
        for v in vertices {
            if v != startVertex {
                distance[v] = Weight.infinity
                predecessor[v] = nil
            }
            queue.enqueue(v, priority: distance[v]!)
        }
        while !queue.isEmpty {
            let u = queue.dequeue()
            for v in successors(of: u) {
                let alt = distance[u]! + weight(u, v)
                if alt < distance[v]! {
                    distance[v] = alt
                    predecessor[v] = u
                    queue.changePriority(of: v, to: alt)
                }
            }
        }
        let solution = DijkstraSolution(startVertex: startVertex, distances: distance, predecessors: predecessor)
        return solution
    }
    
    /// Calculates the shortest path between two given vertices.
    ///
    /// If you only need one path or your graph is expected to be mutated before you need another path, calling this method is more efficient as it stops as soon as the target vertex is reached.
    /// - Precondition: All edges in the graph have positive weights. The method does not check if this is the case.
    /// - Complexity: O(*n* + *m* log *n*), where *n* is the number of vertices, and *m* the number of edges in the graph.
    /// - Parameter startVertex: The vertex from which the shortest path is calculated.
    /// - Parameter endVertex: The target vertex, the path to which is to be calculated.
    /// - Returns: An array of vertices that describe a path from `startVertex` to `endVertex`.
    func shortestPath(from startVertex: Element, to endVertex: Element) -> [Element] {
        
        var distance: [Element: Weight] = [startVertex: 0]
        var predecessor = [Element: Element?]()
        
        let queue = PriorityQueue<Element, Weight>(<)
        for v in vertices {
            if v != startVertex {
                distance[v] = Weight.infinity
                predecessor[v] = nil
            }
            queue.enqueue(v, priority: distance[v]!)
        }
        
        while !queue.isEmpty {
            let u = queue.dequeue()
            if u == endVertex {
                break
            }
            for v in successors(of: u) {
                let alt = distance[u]! + weight(u, v)
                if alt < distance[v]! {
                    distance[v] = alt
                    predecessor[v] = u
                    queue.changePriority(of: v, to: alt)
                }
            }
        }
        
        var path = [Element]()
        if predecessor[endVertex] != nil || endVertex == startVertex {
            var u: Element? = endVertex
            while let _ = u {
                path.append(u!)
                u = predecessor[u!] ?? nil
            }
        }
        return path.reversed()
    }
    
}
