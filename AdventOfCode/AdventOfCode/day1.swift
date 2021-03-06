//
//  day1.swift
//  AdventOfCode
//
//  Created by Robbie Plankenhorn on 4/27/16.
//  Copyright © 2016 Plankenhorn.net. All rights reserved.
//

import Foundation

func day1Part1() -> Int {
    let input = readInputFile("day1_input")!
    
    var floor = 0
    
    for i in input.characters {
        if i == "(" {
            floor += 1
        } else if i == ")" {
            floor -= 1
        }
    }
    
    return floor
}

func day1Part2() -> Int {
    let input = readInputFile("day1_input")!
    
    var floor = 0
    
    var count = 0
    
    for i in input.characters {
        count += 1
        
        if i == "(" {
            floor += 1
        } else if i == ")" {
            floor -= 1
        }
        
        if floor < 0 {
            break
        }
    }
    
    return count
}