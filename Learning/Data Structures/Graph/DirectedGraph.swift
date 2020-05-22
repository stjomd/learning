//
//  DirectedGraph.swift
//  Learning
//
//  Created by Artem Zhukov on 22.05.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

class DirectedGraph<Element: Hashable> {
    
    private var adjacencyList: [Element: [Element: Double?]] = [:]
    
    private(set) var vertexCount = 0
    private(set) var edgeCount = 0
    
    var isEmpty: Bool {
        return vertexCount == 0
    }
    
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
            addEdge(item, vertex)
        }
    }
    func add(_ item: Element, adjacentWith: Element...) {
        add(item, adjacentWith: adjacentWith)
    }
    
    func addEdge(_ from: Element, _ to: Element) {
        precondition(hasVertex(from), "The vertex is not present in the graph")
        precondition(hasVertex(to), "The vertex is not present in the graph")
        if from != to {
            adjacencyList[from]![to] = 1
            edgeCount += 1
        }
    }
    
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
    
    func hasEdge(_ from: Element, _ to: Element) -> Bool {
        precondition(hasVertex(from), "The vertex is not present in the graph")
        precondition(hasVertex(to), "The vertex is not present in the graph")
        return adjacencyList[from]![to] != nil
    }
    
    func hasVertex(_ vertex: Element) -> Bool {
        return adjacencyList[vertex] != nil
    }
    
}

extension DirectedGraph: CustomStringConvertible where Element: CustomStringConvertible {
    var description: String {
        var str = "<< Graph:"
        for v in adjacencyList {
            var vstr = "\n  \(v.key.description) → ["
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
