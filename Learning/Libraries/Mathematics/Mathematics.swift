//
//  Mathematics.swift
//  Learning
//
//  Created by Artem Zhukov on 12.05.20.
//  Copyright © 2020 Artem Zhukov. All rights reserved.
//

enum Mathematics {
    static func integrate(from: Double, through: Double, step: Double = 1e-5, _ function: (Double) -> Double) -> Double {
        var sum: Double = 0
        for x in stride(from: from, through: through, by: step) {
            sum += function(x + step/2) * step
        }
        return sum
    }
}
