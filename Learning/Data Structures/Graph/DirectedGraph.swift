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
    
    private(set) var vertexCount = 0
    private(set) var edgeCount = 0
    
    var isEmpty: Bool {
        return vertexCount == 0
    }
    
    var vertices: [Element] {
        var ans = [Element]()
        for (vertex, _) in adjacencyList {
            ans.append(vertex)
        }
        return ans
    }
    
    var showWeightsInDescription = false
    
    // MARK: - Methods
    func predecessors(of vertex: Element) -> [Element] {
        precondition(hasVertex(vertex), "The vertex is not present in the graph")
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
    
    func successors(of vertex: Element) -> [Element] {
        precondition(hasVertex(vertex), "The vertex is not present in the graph")
        var array = [Element]()
        for successor in adjacencyList[vertex]! {
            array.append(successor.key)
        }
        return array
    }
    
    // MARK: Addition
    func add(vertex: Element) {
        if !hasVertex(vertex) {
            adjacencyList[vertex] = [:]
            vertexCount += 1
        }
    }
    func add(vertex: Element, adjacentWith vertices: [Element], weights: [Weight]? = nil) {
        if let _ = weights {
            precondition(weights!.count == vertices.count, "The array of weights must be equal in length to the array of vertices")
        }
        add(vertex: vertex)
        for i in vertices.indices where vertices[i] != vertex {
            if !hasVertex(vertices[i]) {
                add(vertex: vertices[i])
            }
            connect(vertex, to: vertices[i], weight: weights?[i] ?? 1.0)
        }
    }
    func add(vertex: Element, adjacentWith vertices: Element...) {
        add(vertex: vertex, adjacentWith: vertices, weights: nil)
    }
    
    func connect(_ startVertex: Element, to endVertex: Element, weight: Weight = 1.0) {
        precondition(hasVertex(startVertex), "The vertex is not present in the graph")
        precondition(hasVertex(endVertex), "The vertex is not present in the graph")
        if startVertex != endVertex {
            adjacencyList[startVertex]![endVertex] = weight
            edgeCount += 1
        }
    }
    
    // MARK: Removal
    func removeEdge(_ from: Element, _ to: Element) {
        precondition(hasVertex(from), "The vertex is not present in the graph")
        precondition(hasVertex(to), "The vertex is not present in the graph")
        adjacencyList[from]![to] = nil
        edgeCount -= 1
    }
    
    func removeVertex(_ vertex: Element) {
        precondition(hasVertex(vertex), "The vertex is not present in the graph")
        for item in predecessors(of: vertex) {
            removeEdge(item, vertex)
        }
        for item in successors(of: vertex) {
            removeEdge(vertex, item)
        }
        adjacencyList[vertex] = nil
        vertexCount -= 1
    }
    
    // MARK: Miscellaneous
    func weight(_ from: Element, _ to: Element) -> Weight {
        return adjacencyList[from]![to]!
    }
    
    func hasEdge(_ from: Element, _ to: Element) -> Bool {
        precondition(hasVertex(from), "The vertex is not present in the graph")
        precondition(hasVertex(to), "The vertex is not present in the graph")
        return adjacencyList[from]![to] != nil
    }
    
    func hasVertex(_ vertex: Element) -> Bool {
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
