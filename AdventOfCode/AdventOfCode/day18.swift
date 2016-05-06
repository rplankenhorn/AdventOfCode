//
//  day18.swift
//  AdventOfCode
//
//  Created by Robbie Plankenhorn on 5/6/16.
//  Copyright © 2016 Plankenhorn.net. All rights reserved.
//

import Foundation

private func updateLights(lights:[[Bool]], ignoreCorners:Bool = false) -> [[Bool]] {
    var lightsCopy = lights
    
    for row in 0..<lights.count {
        for column in 0..<lights[row].count {
            
            if ignoreCorners && (row == 0 || row == lights.count - 1) && (column == 0 || column == lights.count - 1) {
                continue
            }
            
            var numberOfNeighborsOn = 0
            
            let rowMin = Swift.max(0, row-1)
            let rowMax = Swift.min(row+1, lights.count-1)
            
            let columnMin = Swift.max(0, column-1)
            let columnMax = Swift.min(column+1, lights[row].count-1)
            
            for i in rowMin...rowMax {
                for j in columnMin...columnMax  {
                    if lights[i][j] && (i != row || j != column) {
                        numberOfNeighborsOn+=1
                    }
                }
            }
            
            if lights[row][column] {
                lightsCopy[row][column] = numberOfNeighborsOn == 2 || numberOfNeighborsOn == 3
            } else {
                lightsCopy[row][column] = numberOfNeighborsOn == 3
            }
        }
    }
    
    return lightsCopy
}

private func getLights() -> [[Bool]] {
    let input = readInputFile("day18_input")!.componentsSeparatedByString("\n")
    
    return input.map { row in
        let booleanRow = row.characters.map { element in
            return element == "#" ? true : false
        }
        return booleanRow
    }
}

func day18Part1() -> Int {
    var lights = getLights()
    
    for _ in 1...100 {
        lights = updateLights(lights)
    }
    
    return lights.map { $0.map { $0 ? 1 : 0 } }.reduce(0, combine: { $0 + $1.reduce(0, combine:+) })
}

func day18Part2() -> Int {
    var lights = getLights()
    
    lights[0][0] = true
    lights[lights.count-1][0] = true
    lights[0][lights.count-1] = true
    lights[lights.count-1][lights.count-1] = true
    
    for _ in 1...100 {
        lights = updateLights(lights, ignoreCorners: true)
    }
    
    return lights.map { $0.map { $0 ? 1 : 0 } }.reduce(0, combine: { $0 + $1.reduce(0, combine:+) })
}