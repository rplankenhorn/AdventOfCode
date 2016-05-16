//
//  day24.swift
//  AdventOfCode
//
//  Created by Robbie Plankenhorn on 5/13/16.
//  Copyright © 2016 Plankenhorn.net. All rights reserved.
//

import Foundation

func calculateGroups(presents:[UInt], numberOfGroups:UInt = 3) -> [[UInt]] {
    var presentsCopy = presents.sort(>)
    let sum = presents.reduce(0, combine: +)
    let sizeOfGroup = sum / numberOfGroups
    var groups:[[UInt]] = []
    
    for i in 0..<presentsCopy.count {
        var currentSubArray = Array(presentsCopy[i...presentsCopy.count-1])
        let first = currentSubArray.removeFirst()
        
        while currentSubArray.count > 0 {
            let group = calculateGroup(currentSubArray, totalSum: sizeOfGroup - first)
            
            if group.count > 0 {
                var newGroup = [first]
                newGroup.appendContentsOf(group)
                groups.append(newGroup)
                
                for item in group {
                    var newSubArray = currentSubArray
                    let indexOfObject = newSubArray.indexOf(item)!
                    newSubArray.removeAtIndex(indexOfObject)
                    let anotherGroup = calculateGroup(newSubArray, totalSum: sizeOfGroup - first)
                    
                    if anotherGroup.count > 0 {
                        var newGroup = [first]
                        newGroup.appendContentsOf(anotherGroup)
                        groups.append(newGroup)
                    }
                }
                
            } else if currentSubArray.count <= 1 {
                break
            }
            
            currentSubArray.removeFirst()
        }
    }
    
    return groups.filter { $0.reduce(0, combine: +) == sizeOfGroup }
}

func calculateGroup(presents:[UInt], totalSum:UInt) -> [UInt] {
    if presents.count == 0 {
        return []
    }
    
    if let first = presents.first where first == totalSum {
        return [first]
    }
    
    var presentsCopy = presents
    
    while presentsCopy.count > 0 {
        let currentPresent = presentsCopy.removeFirst()
        
        if currentPresent <= totalSum {
            var retPresents = [currentPresent]
            retPresents.appendContentsOf(calculateGroup(presentsCopy, totalSum: totalSum - currentPresent))
            return retPresents
        }

    }
    
    return []
}

func day24Part1() -> UInt {
    let presents = readInputFile("day24_input")!.componentsSeparatedByString("\n").map { UInt($0)! }.sort(>)

    let groups = calculateGroups(presents)
    
    var smallestQuantumEntanglement = UInt.max
    
    for group in groups {
        var quantumEntanglement:UInt = 1
        
        for item in group {
            quantumEntanglement *= item
            
            if quantumEntanglement > smallestQuantumEntanglement {
                break
            }
        }
        
        smallestQuantumEntanglement = Swift.min(smallestQuantumEntanglement, quantumEntanglement)
    }

    return smallestQuantumEntanglement
}

func day24Part2() -> UInt {
    let presents = readInputFile("day24_input")!.componentsSeparatedByString("\n").map { UInt($0)! }.sort(>)
    
    let groups = calculateGroups(presents, numberOfGroups: 4)
    
    var smallestQuantumEntanglement = UInt.max
    
    for group in groups {
        var quantumEntanglement:UInt = 1
        
        for item in group {
            quantumEntanglement *= item
            
            if quantumEntanglement > smallestQuantumEntanglement {
                break
            }
        }
        
        smallestQuantumEntanglement = Swift.min(smallestQuantumEntanglement, quantumEntanglement)
    }
    
    return smallestQuantumEntanglement
}