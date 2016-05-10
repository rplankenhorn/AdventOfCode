//
//  day19.swift
//  AdventOfCode
//
//  Created by Robbie Plankenhorn on 5/6/16.
//  Copyright © 2016 Plankenhorn.net. All rights reserved.
//

import Foundation

private func getReplacementsAndMolcule() -> ([String:[String]], String) {
    var input = readInputFile("day19_input")!.componentsSeparatedByString("\n")
    
    let molecule = input.removeLast()
    input.removeLast()
    
    var replacements:[String:[String]] = [:]
    
    for line in input {
        let tokens = line.stringByReplacingOccurrencesOfString(" ", withString: "").componentsSeparatedByString("=>")
        
        var array = replacements[tokens.first!] ?? []
        array.append(tokens.last!)
        replacements[tokens.first!] = array
    }
    
    return (replacements, molecule)
}

func day19Part1() -> Int {
    let replacementsAndMolecule = getReplacementsAndMolcule()
    
    let replacements = replacementsAndMolecule.0
    let molecule = replacementsAndMolecule.1
    
    var newMolecules = Set<String>()
    
    for (replacement,values) in replacements {
        let regex = try! NSRegularExpression(pattern: replacement, options: [])
        let ranges = regex.matchesInString(molecule, options: [], range: NSMakeRange(0, molecule.characters.count)).map { $0.range }
        
        for value in values {
            for range in ranges {
                let newMolecule = (molecule as NSString).stringByReplacingCharactersInRange(range, withString: value)
                newMolecules.insert(newMolecule)
            }
        }
    }
    
    return newMolecules.count
}