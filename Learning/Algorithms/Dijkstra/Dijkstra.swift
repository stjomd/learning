//
//  Dijkstra.swift
//  Learning
//
//  Created by Artem Zhukov on 23.05.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

extension DirectedGraph {
    
    struct DijkstraSolution {
        
        fileprivate(set) var startVertex: Element
        fileprivate(set) var distances: [Element: Double]
        fileprivate var predecessors: [Element: Element?]
        
        fileprivate init(startVertex: Element, distances: [Element: Double], predecessors: [Element: Element?]) {
            self.startVertex = startVertex; self.distances = distances; self.predecessors = predecessors
        }
        
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
        
        func distance(to vertex: Element) -> Double {
            precondition(distances[vertex] != nil, "The vertex is not present in the graph")
            return distances[vertex]!
        }
        
    }
        
    func dijkstra(from startVertex: Element) -> DijkstraSolution {
        var distance: [Element: Double] = [startVertex: 0]
        var predecessor = [Element: Element?]()
        let queue = PriorityQueue<Element, Double>(<)
        for v in vertices {
            if v != startVertex {
                distance[v] = Double.infinity
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
    
    func shortestPath(from startVertex: Element, to endVertex: Element) -> [Element] {
        
        var distance: [Element: Double] = [startVertex: 0]
        var predecessor = [Element: Element?]()
        
        let queue = PriorityQueue<Element, Double>(<)
        for v in vertices {
            if v != startVertex {
                distance[v] = Double.infinity
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
