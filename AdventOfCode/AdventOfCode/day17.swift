//
//  day17.swift
//  AdventOfCode
//
//  Created by Robbie Plankenhorn on 5/6/16.
//  Copyright © 2016 Plankenhorn.net. All rights reserved.
//

import Foundation

private func combinations(withBase: [Int], _ andOthers: [Int], _ toTotal: Int) -> [[Int]] {
    var result : [[Int]] = []
    
    guard withBase.reduce(0,combine: +) != toTotal else {
        return [withBase]
    }
    
    guard withBase.reduce(0,combine: +)  < toTotal else {
        return [[]]
    }
    
    if andOthers.count == 0 {
        if withBase.reduce(0,combine: +) == toTotal {
            return [withBase]
        } else {
            return [[]]
        }
    }
    
    var workingArray = andOthers
    while workingArray.count > 0 {
        var baseArray: [Int] = withBase
        baseArray.append(workingArray.removeAtIndex(0))
        result += combinations(baseArray, workingArray, toTotal).filter{$0 != []}
    }
    return result
}


func day17Part1() -> Int {
    let input = readInputFile("day17_input")!.componentsSeparatedByString("\n").map { Int($0)! }
    return combinations([], input, 150).count
}

