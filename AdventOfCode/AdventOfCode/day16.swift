//
//  day16.swift
//  AdventOfCode
//
//  Created by Robbie Plankenhorn on 5/6/16.
//  Copyright © 2016 Plankenhorn.net. All rights reserved.
//

import Foundation

private struct Sue {
    var number:Int
    var children:Int?
    var cats:Int?
    var samoyeds:Int?
    var pomeranians:Int?
    var akitas:Int?
    var vizslas:Int?
    var goldfish:Int?
    var trees:Int?
    var cars:Int?
    var perfumes:Int?
    
    init(line:String) {
        let tokens = line.stringByReplacingOccurrencesOfString(",", withString: "").stringByReplacingOccurrencesOfString(":", withString: "").componentsSeparatedByString(" ")
        number = Int(tokens[1])!
        
        children = parseValue("children", components: tokens)
        cats = parseValue("cats", components: tokens)
        samoyeds = parseValue("samoyeds", components: tokens)
        pomeranians = parseValue("pomeranians", components: tokens)
        akitas = parseValue("akitas", components: tokens)
        vizslas = parseValue("vizslas", components: tokens)
        goldfish = parseValue("goldfish", components: tokens)
        trees = parseValue("trees", components: tokens)
        cars = parseValue("cars", components: tokens)
        perfumes = parseValue("perfumes", components: tokens)
    }
    
    private func parseValue(propertyName:String, components:[String]) -> Int? {
        if let index = components.indexOf(propertyName), let ret = Int(components[index+1]) {
            return ret
        } else {
            return nil
        }
    }
}

func day16Part1() -> Int {
    var input = readInputFile("day16_input")!.componentsSeparatedByString("\n").map { Sue(line: $0) }
    
    input = input.filter { $0.children == nil || $0.children == 3 }
    input = input.filter { $0.cats == nil || $0.cats == 7 }
    input = input.filter { $0.samoyeds == nil || $0.samoyeds == 2 }
    input = input.filter { $0.pomeranians == nil || $0.pomeranians == 3 }
    input = input.filter { $0.akitas == nil || $0.akitas == 0 }
    input = input.filter { $0.vizslas == nil || $0.vizslas == 0 }
    input = input.filter { $0.goldfish == nil || $0.goldfish == 5 }
    input = input.filter { $0.trees == nil || $0.trees == 3 }
    input = input.filter { $0.cars == nil || $0.cars == 2 }
    input = input.filter { $0.perfumes == nil || $0.perfumes == 1 }
    
    return 0
}