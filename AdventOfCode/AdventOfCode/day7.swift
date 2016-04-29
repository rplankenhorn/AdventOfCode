//
//  day7.swift
//  AdventOfCode
//
//  Created by Robbie Plankenhorn on 4/28/16.
//  Copyright © 2016 Plankenhorn.net. All rights reserved.
//

import Foundation

typealias CommandValue = UInt16

var registers: [String:[String]] = [:]
var values:[String:CommandValue] = [:]

func commands() -> [String] {
    let path = NSBundle.mainBundle().pathForResource("day7_input", ofType: "txt")
    let text = try? NSString(contentsOfFile: path! as String, encoding: NSUTF8StringEncoding)
    return text!.componentsSeparatedByString("\n")
}

func day7Part1() -> CommandValue {
    for command in commands() {
        let tokens = command.componentsSeparatedByString(" -> ")
        registers[tokens.last!] = tokens.first!.componentsSeparatedByString(" ")
    }
    
    return calculate("a")
}

func calculate(wire:String) -> CommandValue {
    if let value = values[wire] {
        return value
    }
    
    if let value = CommandValue(wire) {
        return value
    }
    
    let command = registers[wire]!
    
    let value:CommandValue
    
    if command.contains("AND") {
        value = calculate(command.first!) & calculate(command.last!)
    } else if command.contains("OR") {
        value = calculate(command.first!) | calculate(command.last!)
    } else if command.contains("LSHIFT") {
        value = calculate(command.first!) << calculate(command.last!)
    } else if command.contains("RSHIFT") {
        value =  calculate(command.first!) >> calculate(command.last!)
    } else if command.contains("NOT") {
        value = ~(calculate(command.last!))
    } else {
        value = calculate(command.first!)
    }
    
    values[wire] = value
    return value
}