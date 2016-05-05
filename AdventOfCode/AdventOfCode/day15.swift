//
//  day15.swift
//  AdventOfCode
//
//  Created by Robbie Plankenhorn on 5/5/16.
//  Copyright © 2016 Plankenhorn.net. All rights reserved.
//

import Foundation

struct Ingredient {
    let name:String
    let capacity:Int
    let durability:Int
    let flavor:Int
    let texture:Int
    let calories:Int
    
    init(line:String) {
        let tokens = line.stringByReplacingOccurrencesOfString(":", withString: "").stringByReplacingOccurrencesOfString(",", withString: "").componentsSeparatedByString(" ")
        name = tokens[0]
        capacity = Int(tokens[2])!
        durability = Int(tokens[4])!
        flavor = Int(tokens[6])!
        texture = Int(tokens[8])!
        calories = Int(tokens[10])!
    }
}

func day15Part1() -> Int {
    let ingredients = readInputFile("day15_input")!.componentsSeparatedByString("\n").map { Ingredient(line: $0) }
    
    var bestScore = 0
    
    for i in 1...100 {
        for j in 1...100 {
            for k in 1...100 {
                for l in 1...100 {
                    if i + j + k + l == 100 {
                        var capacity = i*ingredients[0].capacity
                        var durability = i*ingredients[0].durability
                        var flavor = i*ingredients[0].flavor
                        var texture = i*ingredients[0].texture
                        
                        capacity += j*ingredients[1].capacity
                        durability += j*ingredients[1].durability
                        flavor += j*ingredients[1].flavor
                        texture += j*ingredients[1].texture
                        
                        capacity += k*ingredients[2].capacity
                        durability += k*ingredients[2].durability
                        flavor += k*ingredients[2].flavor
                        texture += k*ingredients[2].texture
                        
                        capacity += l*ingredients[3].capacity
                        durability += l*ingredients[3].durability
                        flavor += l*ingredients[3].flavor
                        texture += l*ingredients[3].texture
                        
                        let score = Swift.max(capacity, 0) * Swift.max(durability, 0) * Swift.max(flavor, 0) * Swift.max(texture, 0)
                        
                        bestScore = Swift.max(bestScore, score)
                    }
                }
            }
        }
    }
    
    return bestScore
}