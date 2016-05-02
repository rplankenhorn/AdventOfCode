//
//  day8.swift
//  AdventOfCode
//
//  Created by Robbie Plankenhorn on 4/29/16.
//  Copyright © 2016 Plankenhorn.net. All rights reserved.
//

import Foundation

extension String {
    
    func numberOfCharactersInEncodedString() -> UInt {
        var count:UInt = 2
        
        for c in self.characters {
            print(c)
            
            if c == "\"" {
                count += 2
            } else if c == "\\" {
                count += 2
            } else {
                count += 1
            }
        }
        
        return count
    }
    
    func numberOfCharactersInCode() -> UInt {
        return UInt(self.stringByReplacingOccurrencesOfString("\"", withString: "aa").characters.count)
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
    let strings = readInputFile("day8_input")!.componentsSeparatedByString("\n")
    
    let numberOfCharactersInCode = strings.reduce(0, combine: {$0 + $1.numberOfCharactersInCode() })
    let numberOfCharactersInMemory = strings.reduce(0, combine: {$0 + $1.numberOfCharactersInMemory() })
    
    return numberOfCharactersInCode - numberOfCharactersInMemory
}

func day8Part2() -> UInt {
    let strings = readInputFile("day8_input")!.componentsSeparatedByString("\n")
    
    let numberOfCharactersInEncodedString = strings.reduce(0, combine: {$0 + $1.numberOfCharactersInEncodedString() })
    let numberOfCharactersInCode = strings.reduce(0, combine: {$0 + UInt($1.characters.count) })
    
    return numberOfCharactersInEncodedString - numberOfCharactersInCode
}