//
//  day11.swift
//  AdventOfCode
//
//  Created by Robbie Plankenhorn on 5/3/16.
//  Copyright © 2016 Plankenhorn.net. All rights reserved.
//

import Foundation

let straights = Set<String>(["abc", "bcd", "cde", "def", "efg", "fgh", "ghi", "hij", "ijk", "jkl", "klm", "lmn", "mno", "nop", "opq", "pqr", "qrs", "rst", "stv", "tvu", "vuw", "uwx", "wxy", "xyz"])
let alphabet = "abcdefghijklmnopqrstuvwxyz".characters.map { String($0) }

extension String {
    
    func isValidPassword() -> Bool {
        if self.containsString("i") || self.containsString("o") || self.containsString("l") {
            return false
        }
        
        var matches = false
        
        for i in 0..<self.characters.count {
            if i + 2 >= self.characters.count {
                break
            }
            
            let subStr = self.substringWithRange(self.startIndex.advancedBy(i)...self.startIndex.advancedBy(i+2))
            if straights.contains(subStr) {
                matches = true
                break
            }
        }
        
        if matches == false {
            return matches
        }
        
        var pairs:[String:Int] = [:]
        
        var i = 0
        
        while i < self.characters.count {
            if i + 1 >= self.characters.count {
                break
            }
            
            let curChar = String(self[self.startIndex.advancedBy(i)])
            let nextChar = String(self[self.startIndex.advancedBy(i+1)])
            
            if curChar == nextChar {
                pairs[curChar] = i
                i+=2
            } else {
                i+=1
            }
        }
        
        return pairs.keys.count >= 2
    }
    
    func incrementPassword() -> String {
        var retString = self
        
        while retString == self || retString.isValidPassword() == false {
            let characterStrings = retString.characters.map { String($0) }.reverse()
            
            retString = ""
            
            var shouldIncrementNextDigit = true
            
            for character in characterStrings {
                if shouldIncrementNextDigit {
                    shouldIncrementNextDigit = false
                    
                    var position = alphabet.indexOf(character)!
                    position+=1
                    
                    if position >= alphabet.count {
                        position = 0
                        shouldIncrementNextDigit = true
                    }
                    
                    retString += alphabet[position]
                } else {
                    retString += character
                }
            }
            
            if shouldIncrementNextDigit {
                retString += "a"
            }
            
            retString = retString.characters.reverse().reduce("", combine: { $0 + String($1) })
        }
        
        return retString
    }
    
}

func day11Part1() -> String {
    return "hepxcrrq".incrementPassword()
}

func day11Part2() -> String {
    return day11Part1().incrementPassword()
}