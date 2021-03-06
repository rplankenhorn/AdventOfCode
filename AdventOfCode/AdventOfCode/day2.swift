//
//  day2.swift
//  AdventOfCode
//
//  Created by Robbie Plankenhorn on 4/27/16.
//  Copyright © 2016 Plankenhorn.net. All rights reserved.
//

import Foundation

private struct Box {
    var length:Int = 0
    var width:Int = 0
    var height:Int = 0
    
    var volume:Int {
        return length * width * height
    }
    
    init(line:String) {
        let array = line.characters.split { $0 == "x" }.map(String.init)
        length = Int(array[0])!
        width = Int(array[1])!
        height = Int(array[2])!
    }
    
    func amountOfPaper() -> Int {
        let area1 = 2 * length * width
        let area2 = 2 * width * height
        let area3 = 2 * height * length
        let smallestSide = Swift.min(area1, area2, area3) / 2
        return area1 + area2 + area3 + smallestSide
    }
    
    func amountOfRibbon() -> Int {
        let smallestPermimeter = Swift.min(2 * (length + width), 2 * (width + height), 2 * (height + length))
        return smallestPermimeter + self.volume
    }
}

private func boxes() -> [Box] {
    return readInputFile("day2_input")!.componentsSeparatedByString("\n").map { Box(line: $0) }
}

func day2Part1() -> Int {
    return boxes().map { $0.amountOfPaper() }.reduce(0, combine: +)
}

func day2Part2() -> Int {
    return boxes().map { $0.amountOfRibbon() }.reduce(0, combine: +)
}