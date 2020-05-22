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
    
    private(set) var count = 0
    
    var isEmpty: Bool {
        return count == 0
    }
    
    func add(_ item: Element, adjacentWith: [Element]) {
        adjacencyList[item] = [:]
        for vertex in adjacentWith {
            adjacencyList[item]![vertex] = 1
            if adjacencyList[vertex] == nil {
                adjacencyList[vertex] = [:]
                count += 1
            }
            adjacencyList[vertex]![item] = 1
        }
        count += 1
    }
    func add(_ item: Element) {
        adjacencyList[item] = [:]
        count += 1
    }
    
}
