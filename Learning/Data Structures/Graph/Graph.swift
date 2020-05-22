//
//  Graph.swift
//  Learning
//
//  Created by Artem Zhukov on 22.05.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

class Graph<Element: Hashable> {
    
    private typealias VertexID = Int
    
    private class Vertex {
        var id: Int
        var value: Element
        init(id: Int, value: Element) {
            self.id = id
            self.value = value
        }
    }
    
    // aL[i] returns a list of vertices that vertex i is adjacent to
    private var adjacencyList: [Element: [Element: Double?]] = [:]
    
    private(set) var vertexCount = 0
    private(set) var edgeCount = 0
    
    var isEmpty: Bool {
        return vertexCount == 0
    }
    
    func neighbors(of vertex: Element) -> [Element] {
        var array = [Element]()
        for neighbor in adjacencyList[vertex]! {
            array.append(neighbor.key)
        }
        return array
    }
    
    func add(_ item: Element) {
        if !hasVertex(item) {
            adjacencyList[item] = [:]
            vertexCount += 1
        }
    }
    func add(_ item: Element, adjacentWith: [Element]) {
        add(item)
        for vertex in adjacentWith where vertex != item {
            if !hasVertex(vertex) {
                add(vertex)
            }
            if !hasEdge(item, vertex) {
                adjacencyList[item]![vertex] = 1
                adjacencyList[vertex]![item] = 1
                edgeCount += 1
            }
        }
    }
    func add(_ item: Element, adjacentWith: Element...) {
        add(item, adjacentWith: adjacentWith)
    }
    
    func addEdge(_ from: Element, _ to: Element) {
        precondition(hasVertex(from), "The vertex is not present in the graph")
        precondition(hasVertex(to), "The vertex is not present in the graph")
        add(from, adjacentWith: to)
    }
    
    func removeEdge(_ from: Element, _ to: Element) {
        precondition(hasVertex(from), "The vertex is not present in the graph")
        precondition(hasVertex(to), "The vertex is not present in the graph")
        adjacencyList[from]![to] = nil
        adjacencyList[to]![from] = nil
        edgeCount -= 1
    }
    
    func removeVertex(_ vertex: Element) {
        precondition(hasVertex(vertex), "The vertex is not present in the graph")
        let neighbs = neighbors(of: vertex)
        for neigbor in neighbs {
            removeEdge(vertex, neigbor)
        }
        adjacencyList[vertex] = nil
        vertexCount -= 1
    }
    
    func hasEdge(_ from: Element, _ to: Element) -> Bool {
        precondition(hasVertex(from), "The vertex is not present in the graph")
        precondition(hasVertex(to), "The vertex is not present in the graph")
        return adjacencyList[from]![to] != nil && adjacencyList[to]![from] != nil
    }
    
    func hasVertex(_ vertex: Element) -> Bool {
        return adjacencyList[vertex] != nil
    }
    
}

extension Graph: CustomStringConvertible where Element: CustomStringConvertible {
    var description: String {
        var str = "<<Undirected, unweighted graph; |V| = \(vertexCount); |E| = \(edgeCount);"
        for v in adjacencyList {
            var vstr = "\n\t\(v.key.description) → ["
            for u in adjacencyList[v.key]! {
                vstr.append("\(u.key.description), ")
            }
            let offset = (adjacencyList[v.key]!.count == 0) ? 0 : -2
            let endIndex = vstr.index(vstr.endIndex, offsetBy: offset)
            str.append(contentsOf: vstr[vstr.startIndex..<endIndex] + "]")
        }
        return str + "\n>>"
    }
}
