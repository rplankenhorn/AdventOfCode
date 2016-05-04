//
//  day12.swift
//  AdventOfCode
//
//  Created by Robbie Plankenhorn on 5/3/16.
//  Copyright © 2016 Plankenhorn.net. All rights reserved.
//

import Foundation

func day12Part1() -> Int {
    var input = readInputFile("day12_input")!
    
    let regex = try! NSRegularExpression(pattern: "[\\{\\}\"\\[\\]\\:,]", options: NSRegularExpressionOptions())
    
    input = regex.stringByReplacingMatchesInString(input, options: NSMatchingOptions(), range: NSRange(location: 0, length: input.characters.count), withTemplate: " ")
    
    let tokens = input.componentsSeparatedByString(" ").flatMap { element -> Int? in
        if let number = Int(element) {
            return number
        } else {
            return nil
        }
    }
    
    return tokens.reduce(0, combine:+)
}