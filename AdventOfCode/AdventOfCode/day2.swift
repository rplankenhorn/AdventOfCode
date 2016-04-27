//
//  day2.swift
//  AdventOfCode
//
//  Created by Robbie Plankenhorn on 4/27/16.
//  Copyright © 2016 Plankenhorn.net. All rights reserved.
//

import Foundation

struct Box {
    var length:Int = 0
    var width:Int = 0
    var height:Int = 0
    
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
}

func day2Part1() -> Int {
    let path = NSBundle.mainBundle().pathForResource("day2_input", ofType: "txt")
    let text = try? NSString(contentsOfFile: path! as String, encoding: NSUTF8StringEncoding)
    let amountOfPaper = text?.componentsSeparatedByString("\n").map { Box(line: $0) }.map { $0.amountOfPaper() }.reduce(0, combine: +)
    return amountOfPaper!
}