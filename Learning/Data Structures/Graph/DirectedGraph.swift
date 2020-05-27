//
//  DirectedGraph.swift
//  Learning
//
//  Created by Artem Zhukov on 22.05.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

class DirectedGraph<Element: Hashable> {
    
    typealias Weight = Double
    
    // MARK: - Properties
    private var adjacencyList: [Element: [Element: Weight]] = [:]
    
    /// The amount of vertices in the graph.
    ///
    /// In documentation for other methods on graphs, *n* stands for this value.
    /// - Complexity: O(1)
    private(set) var vertexCount = 0
    /// The amount of edges in the graph.
    ///
    /// In documentation for other methods on graphs, *m* stands for this value.
    ///
    /// In undirected graphs, an undirected edge is considered to be two directed ones. Therefore, for undirected graphs, this value is actually double what one might expect. For unique edges, access `uniqueEdgeCount` on undirected graphs.
    /// - Complexity: O(1)
    private(set) var edgeCount = 0
    /// A Boolean value that indicates whether the graph is empty (has no vertices, and therefore edges).
    var isEmpty: Bool {
        return vertexCount == 0
    }
    /// An array of all vertices in the graph.
    ///
    /// Since vertices are hashed, this property might return an array with the same vertices but in different order between different runs of the program.
    /// - Complexity: O(*n*), where *n* is the amount of vertices in the graph.
    var vertices: [Element] {
        var ans = [Element]()
        for (vertex, _) in adjacencyList {
            ans.append(vertex)
        }
        return ans
    }
    /// A Boolean value that indicates whether the weights should appear in the graph's `description` (for example, when printing to console).
    var showWeightsInDescription = false
    
    // MARK: - Methods
    /// An array of all predecessors of a given vertex (i.e. all vertices from which this given vertex is reachable).
    /// - Precondition: The graph contains `vertex`.
    /// - Complexity: O(*n*+*m*), where *n* is the amount of vertices, and *m* the amount of edges in the graph.
    /// - Parameter vertex: The vertex the predeccessors of which should be found.
    /// - Returns: An array of vertices from which `vertex` is reachable.
    func predecessors(of vertex: Element) -> [Element] {
        precondition(has(vertex: vertex), "The vertex is not present in the graph")
        var array = [Element]()
        for (item, _) in adjacencyList {
            if let links = adjacencyList[item] {
                for (link, _) in links where link == vertex {
                    array.append(item)
                }
            }
        }
        return array
    }
    /// An array of all successors of a given vertex (i.e. all vertices that are reachable from this given vertex).
    /// - Precondition: The graph contains `vertex`.
    /// - Complexity: O(deg+ *v*), where *v* is the `vertex`, and deg+ *v* is the outdegree of *v*.
    /// - Parameter vertex: The vertex the successors of which should be found.
    /// - Returns: An array of vertices that are reachable from `vertex`.
    func successors(of vertex: Element) -> [Element] {
        precondition(has(vertex: vertex), "The vertex is not present in the graph")
        var array = [Element]()
        for successor in adjacencyList[vertex]! {
            array.append(successor.key)
        }
        return array
    }
    
    // MARK: Addition
    /// Add a vertex to the graph.
    ///
    /// This method adds a new vertex to the graph if it's not already present, otherwise this method does nothing.
    /// - Complexity: O(1)
    /// - Parameter vertex: The vertex to be added.
    func add(vertex: Element) {
        if !has(vertex: vertex) {
            adjacencyList[vertex] = [:]
            vertexCount += 1
        }
    }
    /// Add a vertex to the graph with specified edges.
    ///
    /// This method adds a new vertex to the graph if it's not already present. After that edges are added. If an edge connects to a vertex that is not yet present, this vertex will also be added.
    /// - Complexity: O(*k*), where *k* is the amount of edges to be added.
    /// - Parameter vertex: The vertex to be added.
    /// - Parameter vertices: The vertices that are reachable from `vertex`. In case of an undirected graph, edges in both directions will be created.
    /// - Parameter weights: The weights of the respective edges. If this parameter is `nil`, the weight of `1.0` is assumed.
    func add(vertex: Element, adjacentWith vertices: [Element], weights: [Weight]? = nil) {
        if let _ = weights {
            precondition(weights!.count == vertices.count, "The array of weights must be equal in length to the array of vertices")
        }
        add(vertex: vertex)
        for i in vertices.indices where vertices[i] != vertex {
            if !has(vertex: vertices[i]) {
                add(vertex: vertices[i])
            }
            connect(vertex, to: vertices[i], weight: weights?[i] ?? 1.0)
        }
    }
    /// Add a vertex to the graph with specified edges.
    ///
    /// The weights of all edges are assumed to be `1`.
    ///
    /// This method adds a new vertex to the graph if it's not already present. After that edges are added. If an edge connects to a vertex that is not yet present, this vertex will also be added.
    /// - Complexity: O(*k*), where *k* is the amount of edges to be added.
    /// - Parameter vertex: The vertex to be added.
    /// - Parameter vertices: The vertices that are reachable from `vertex`. In case of an undirected graph, edges in both directions will be created.
    func add(vertex: Element, adjacentWith vertices: Element...) {
        add(vertex: vertex, adjacentWith: vertices, weights: nil)
    }
    /// Create an edge between two vertices.
    ///
    /// In a directed graph, the edge from the first vertex to the second will be created. In an undirected graph, edges in both directions are created.
    /// - Complexity: O(1)
    /// - Parameter startVertex: The vertex from which the edge starts.
    /// - Parameter endVertex: The vertex that is connected by the edge with `startVertex`.
    /// - Parameter weight: The weight of the edge. If this value is `nil`, the weight of `1` is assumed.
    func connect(_ startVertex: Element, to endVertex: Element, weight: Weight = 1.0) {
        precondition(has(vertex: startVertex), "The vertex is not present in the graph")
        precondition(has(vertex: endVertex), "The vertex is not present in the graph")
        if startVertex != endVertex {
            adjacencyList[startVertex]![endVertex] = weight
            edgeCount += 1
        }
    }
    
    // MARK: Removal
    /// Remove an edge between two vertices.
    ///
    /// In a directed graph, the edge from the first vertex to the second will be removed. In an undirected graph, edges in both directions are removed.
    /// - Complexity: O(1)
    /// - Parameter startVertex: The vertex from which the edge starts.
    /// - Parameter endVertex: The vertex that is connected by the edge with `startVertex`.
    func disconnect(_ startVertex: Element, _ endVertex: Element) {
        precondition(has(vertex: startVertex), "The vertex is not present in the graph")
        precondition(has(vertex: endVertex), "The vertex is not present in the graph")
        adjacencyList[startVertex]![endVertex] = nil
        edgeCount -= 1
    }
    /// Remove a vertex and all incident edges.
    /// - Complexity: O(*n*+*m*), where *n* is the amount of vertices, and *m* the amount of edges in the graph.
    /// - Parameter startVertex: The vertex from which the edge starts.
    /// - Parameter endVertex: The vertex that is connected by the edge with `startVertex`.
    func remove(vertex: Element) {
        precondition(has(vertex: vertex), "The vertex is not present in the graph")
        for item in predecessors(of: vertex) {
            disconnect(item, vertex)
        }
        for item in successors(of: vertex) {
            disconnect(vertex, item)
        }
        adjacencyList[vertex] = nil
        vertexCount -= 1
    }
    
    // MARK: Traversals
    /// Traverse the graph in breadth first order.
    ///
    /// You can pass a closure to the method which performs an action on a vertex. This action will be performed on vertices in the same order as they are being discovered.
    /// - Precondition: The graph contains `startVertex`.
    /// - Complexity: O(*n*+*m*), where *n* is the amount of vertices, and *m* the amount of edges in the graph.
    /// - Parameter startVertex: The vertex from which the traversal begins.
    /// - Parameter action: A closure that accepts a vertex and returns nothing.
    func breadthFirstSearch(from startVertex: Element, action: (Element) -> Void) {
        precondition(has(vertex: startVertex), "The vertex is not present in the graph")
        var discovered = [Element: Bool]()
        for vertex in vertices {
            discovered[vertex] = false
        }
        discovered[startVertex] = true
        var queue = Queue<Element>()
        queue.enqueue(startVertex)
        while !queue.isEmpty {
            let u = queue.dequeue()
            action(u)
            for v in successors(of: u) where !discovered[v]! {
                discovered[v] = true
                queue.enqueue(v)
            }
        }
    }
    
    /// Traverse the graph in depth first order.
    ///
    /// You can pass a closure to the method which performs an action on a vertex. This action will be performed on vertices in the same order as they are being discovered.
    /// - Precondition: The graph contains `startVertex`.
    /// - Complexity: O(*n*+*m*), where *n* is the amount of vertices, and *m* the amount of edges in the graph.
    /// - Parameter startVertex: The vertex from which the traversal begins.
    /// - Parameter action: A closure that accepts a vertex and returns nothing.
    func depthFirstSearch(from startVertex: Element, action: (Element) -> Void) {
        var discovered = [Element: Bool]()
        for vertex in vertices {
            discovered[vertex] = false
        }
        dfs(from: startVertex, discovery: &discovered, action: action)
    }
    private func dfs(from vertex: Element, discovery discovered: inout [Element: Bool], action: (Element) -> Void) {
        discovered[vertex] = true
        action(vertex)
        for v in successors(of: vertex) where !discovered[v]! {
            dfs(from: v, discovery: &discovered, action: action)
        }
    }
    
    // MARK: Miscellaneous
    /// The weight of the edge between two given vertices.
    /// - Complexity: O(1)
    /// - Parameter startVertex: The vertex from which the edge starts.
    /// - Parameter endVertex: The vertex that is connected by the edge with `startVertex`.
    /// - Returns: The weight of the edge.
    func weight(from startVertex: Element, to endVertex: Element) -> Weight {
        return adjacencyList[startVertex]![endVertex]!
    }
    /// A Boolean value that indicates if there is an edge between two given vertices.
    /// - Precondition: Both vertices are present in the graph.
    /// - Complexity: O(1)
    /// - Parameter startVertex: The vertex from which the edge starts.
    /// - Parameter endVertex: The vertex that is connected by the edge with `startVertex`.
    /// - Returns: `true`, if such an edge exists, and `false` otherwise.
    func has(edgeFrom startVertex: Element, to endVertex: Element) -> Bool {
        precondition(has(vertex: startVertex), "The vertex is not present in the graph")
        precondition(has(vertex: endVertex), "The vertex is not present in the graph")
        return adjacencyList[startVertex]![endVertex] != nil
    }
    /// A Boolean value that indicates if the graph contains a given vertex.
    /// - Complexity: O(1)
    /// - Parameter vertex: The vertex from which the edge starts.
    /// - Returns: `true`, if the graph contains `vertex`, and `false` otherwise.
    func has(vertex: Element) -> Bool {
        return adjacencyList[vertex] != nil
    }
    
}

// MARK: - CustomStringConvertible
extension DirectedGraph: CustomStringConvertible where Element: CustomStringConvertible {
    var description: String {
        var directed = true
        if let _ = self as? UndirectedGraph {
            directed = false
        }
        var str = "<< \(directed ? "Directed" : "Undirected") graph:"
        for v in adjacencyList {
            var vstr = "\n  \(v.key.description) → ["
            for u in adjacencyList[v.key]! {
                vstr.append("\(u.key.description)\(showWeightsInDescription ? " {\(u.value)}" : ""), ")
            }
            let offset = (adjacencyList[v.key]!.count == 0) ? 0 : -2
            let endIndex = vstr.index(vstr.endIndex, offsetBy: offset)
            str.append(contentsOf: vstr[vstr.startIndex..<endIndex] + "]")
        }
        return str + "\n>>"
    }
}
