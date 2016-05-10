//
//  day10.swift
//  AdventOfCode
//
//  Created by Robbie Plankenhorn on 5/3/16.
//  Copyright © 2016 Plankenhorn.net. All rights reserved.
//

import Foundation

private func nextLookAndSay(ints:[Int]) -> [Int] {
    if ints.count == 1 {
        return [1, ints.first!]
    }
    
    var retString:[Int] = []
    
    var i = 0
    
    while i < ints.count {
        let curChar = ints[i]
        var j = i+1
        var currentDigitCount = 1
        
        while j < ints.count {
            let nextChar = ints[j]
            
            if curChar == nextChar {
                currentDigitCount+=1
            } else {
                break
            }
            
            j+=1
        }
        
        retString.append(currentDigitCount)
        retString.append(curChar)
        
        i+=currentDigitCount
    }
    
    return retString
}

func day10Part1() -> Int {
    var input = "3113322113".characters.map { Int(String($0))! }
    
    for _ in 1...40 {
        input = nextLookAndSay(input)
    }
    
    return input.count
}

func day10Part2() -> Int {
    var input = "3113322113".characters.map { Int(String($0))! }
    
    for _ in 1...50 {
        input = nextLookAndSay(input)
    }
    
    return input.count
}