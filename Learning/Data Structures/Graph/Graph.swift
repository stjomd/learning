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
    var adjacencyList: [Element: [Element: Double?]] = [:]
    
    private(set) var vertexCount = 0
    private(set) var edgeCount = 0
    
    var isEmpty: Bool {
        return vertexCount == 0
    }
    
    func add(_ item: Element, adjacentWith: Element...) {
        add(item, adjacentWith: adjacentWith)
    }
    func add(_ item: Element, adjacentWith: [Element] = []) {
        add(item)
        for vertex in adjacentWith {
            if adjacencyList[item]![vertex] == nil {
                adjacencyList[item]![vertex] = 1
                if adjacencyList[vertex] == nil {
                    adjacencyList[vertex] = [:]
                    vertexCount += 1
                }
                adjacencyList[vertex]![item] = 1
                edgeCount += 1
            }
        }
    }
    func add(_ item: Element) {
        if adjacencyList[item] == nil {
            adjacencyList[item] = [:]
            vertexCount += 1
        }
    }
    
    func remove(edge vertices: (Element, Element)) {
        precondition(adjacencyList[vertices.0] != nil, "The vertex is not present in the graph")
        precondition(adjacencyList[vertices.1] != nil, "The vertex is not present in the graph")
        adjacencyList[vertices.0]![vertices.1] = nil
        adjacencyList[vertices.1]![vertices.0] = nil
    }
    
    func hasEdge(_ from: Element, _ to: Element) -> Bool {
        precondition(adjacencyList[from] != nil, "The vertex is not present in the graph")
        precondition(adjacencyList[to] != nil, "The vertex is not present in the graph")
        return adjacencyList[from]![to] != nil && adjacencyList[to]![from] != nil
    }
    
}

extension Graph: CustomStringConvertible where Element: CustomStringConvertible {
    var description: String {
        var str = "<<Undirected, unweighted graph"
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
