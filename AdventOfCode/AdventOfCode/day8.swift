//
//  day8.swift
//  AdventOfCode
//
//  Created by Robbie Plankenhorn on 4/29/16.
//  Copyright © 2016 Plankenhorn.net. All rights reserved.
//

import Foundation

extension String {
    
    func numberOfCharactersInCode() -> UInt {
        return UInt(self.stringByReplacingOccurrencesOfString("\"", withString: "aa").characters.count) + 2
    }
    
    func numberOfCharactersInMemory() -> UInt {
        var modifiedString = self
        
        let regex = try! NSRegularExpression(pattern: "[\\u005C]x[A-Fa-f0-9]{2}", options: NSRegularExpressionOptions(rawValue: 0))
        
        modifiedString = regex.stringByReplacingMatchesInString(modifiedString, options: NSMatchingOptions(rawValue: 0), range: NSRange(location: 0, length: self.characters.count), withTemplate: "X")
        modifiedString = modifiedString.stringByReplacingOccurrencesOfString("\\\\", withString: "\\")
        
        return UInt(modifiedString.characters.count)
    }
    
}

func day8Part1() -> UInt {
    let strings = readInputFile("day8_input")!.componentsSeparatedByString("\n").map { String(String($0.characters.dropFirst()).characters.dropLast()) }
    
    let numberOfCharactersInCode = strings.reduce(0, combine: {$0 + $1.numberOfCharactersInCode() })
    let numberOfCharactersInMemory = strings.reduce(0, combine: {$0 + $1.numberOfCharactersInMemory() })
    
    return numberOfCharactersInCode - numberOfCharactersInMemory
}