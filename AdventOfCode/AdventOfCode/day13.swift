//
//  day13.swift
//  AdventOfCode
//
//  Created by Robbie Plankenhorn on 5/4/16.
//  Copyright © 2016 Plankenhorn.net. All rights reserved.
//

import Foundation

func day13Part1() -> Int {    
    let input = readInputFile("day13_input")!.componentsSeparatedByString("\n").map { $0.stringByReplacingOccurrencesOfString(".", withString: "") }
    
    var people = Set<String>()
    var happiness:[String:[String:Int]] = [:]
    
    for line in input {
        let tokens = line.componentsSeparatedByString(" ")
        let person = tokens.first!
        let value = Int(tokens[3])! * (tokens[2] == "gain" ? 1 : -1)
        let adjacentPerson = tokens.last!
        people.insert(person)
        people.insert(adjacentPerson)
        happiness[person] = happiness[person] ?? [:]
        happiness[person]![adjacentPerson] = value
    }
    
    var maxHappiness = 0
    
    for permutation in permutations(Array(people)) {
        var currentHappiness = 0
        
        for i in 0..<permutation.count {
            let adjacent1:String
            let person = permutation[i]
            let adjacent2:String
            
            if i == 0 {
                adjacent1 = permutation.last!
                adjacent2 = permutation[i+1]
            } else if i == permutation.count - 1 {
                adjacent1 = permutation[i-1]
                adjacent2 = permutation.first!
            } else {
                adjacent1 = permutation[i-1]
                adjacent2 = permutation[i+1]
            }
            
            currentHappiness += (happiness[person]![adjacent1]! + happiness[person]![adjacent2]!)
        }
        
        maxHappiness = Swift.max(maxHappiness, currentHappiness)
    }
    
    return maxHappiness
}