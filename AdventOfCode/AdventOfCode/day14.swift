//
//  day14.swift
//  AdventOfCode
//
//  Created by Robbie Plankenhorn on 5/4/16.
//  Copyright © 2016 Plankenhorn.net. All rights reserved.
//

import Foundation

private struct Reindeer {
    let name:String
    let speed:Int
    let flightTime:Int
    let restTime:Int
    
    var points = 0
    
    init(line:String) {
        let tokens = line.componentsSeparatedByString(" ")
        name = tokens[0]
        speed = Int(tokens[3])!
        flightTime = Int(tokens[6])!
        restTime = Int(tokens[13])!
    }
    
    func distanceTraveled(time:Int) -> Int {
        let cycleLength = flightTime + restTime
        let numberOfCycles = time / cycleLength
        let excessFlightTime = Swift.min(flightTime, time % cycleLength)
        return ((numberOfCycles * flightTime) + excessFlightTime) * speed
    }
}

func day14Part1() -> Int {
    let input = readInputFile("day14_input")!.componentsSeparatedByString("\n").map { Reindeer(line: $0) }
    return input.map { $0.distanceTraveled(2503) }.reduce(0, combine: { Swift.max($0, $1) })
}

func day14Part2() -> Int {
    let input = readInputFile("day14_input")!.componentsSeparatedByString("\n").map { Reindeer(line: $0) }
    return input.map { $0.distanceTraveled(2503) }.reduce(0, combine: { Swift.max($0, $1) })
}
