//
//  day5.swift
//  AdventOfCode
//
//  Created by Robbie Plankenhorn on 4/27/16.
//  Copyright © 2016 Plankenhorn.net. All rights reserved.
//

import Foundation

extension String {
    
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
    
}

extension Character {
    
    func isVowel() -> Bool {
        return self == "a" || self == "e" || self == "i" || self == "o" || self == "u"
    }
    
}

func strings() -> [String] {
    let path = NSBundle.mainBundle().pathForResource("day5_input", ofType: "txt")
    let text = try? NSString(contentsOfFile: path! as String, encoding: NSUTF8StringEncoding)
    return text!.componentsSeparatedByString("\n")
}

func day5Part1() -> Int {
    return strings().filter { $0.isNiceString() }.count
}