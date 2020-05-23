//
//  Dijkstra.swift
//  Learning
//
//  Created by Artem Zhukov on 23.05.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

extension DirectedGraph {
    
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
