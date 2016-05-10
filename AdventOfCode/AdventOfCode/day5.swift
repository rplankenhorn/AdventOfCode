//
//  day5.swift
//  AdventOfCode
//
//  Created by Robbie Plankenhorn on 4/27/16.
//  Copyright © 2016 Plankenhorn.net. All rights reserved.
//

import Foundation

private extension String {
    
    func isNiceString() -> Bool {
        if self.containsString("ab") || self.containsString("cd") || self.containsString("pq") || self.containsString("xy") {
            return false
        }
        
        let vowels = self.characters.filter { $0.isVowel() }
        
        if vowels.count < 3 {
            return false
        }
        
        var numberOfDoubleLetters = 0
        
        for i in 0..<self.characters.count-1 {
            let curChar = String(self[self.startIndex.advancedBy(i)])
            let adjacentChar = String(self[self.startIndex.advancedBy(i+1)])
            
            if curChar == adjacentChar {
                numberOfDoubleLetters+=1
            }
        }
        
        return numberOfDoubleLetters > 0
    }
    
    func isNiceString2() -> Bool {
        var numberOfNonOverlappingRepeatingPairs = 0
        var numberOfGappedRepeatingLetters = 0
        
        for i in 0..<self.characters.count-2 {
            let pair = String(self[self.startIndex.advancedBy(i)...self.startIndex.advancedBy(i+1)])
            let remaining = String(self[self.startIndex.advancedBy(i+2)...self.endIndex.predecessor()])
            
            if remaining.containsString(pair) {
                numberOfNonOverlappingRepeatingPairs += 1
            }
            
            let curChar = String(self[self.startIndex.advancedBy(i)])
            let adjacentChar = String(self[self.startIndex.advancedBy(i+2)])
            
            if curChar == adjacentChar {
                numberOfGappedRepeatingLetters+=1
            }
        }
        
        return numberOfGappedRepeatingLetters > 0 &&  numberOfNonOverlappingRepeatingPairs > 0
    }
    
}

private extension Character {
    
    func isVowel() -> Bool {
        return self == "a" || self == "e" || self == "i" || self == "o" || self == "u"
    }
    
}

private func strings() -> [String] {
    return readInputFile("day5_input")!.componentsSeparatedByString("\n")
}

func day5Part1() -> Int {
    return strings().filter { $0.isNiceString() }.count
}

func day5Part2() -> Int {
    return strings().filter { $0.isNiceString2() }.count
}