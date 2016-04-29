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
    return readInputFile("day7_input")!.componentsSeparatedByString("\n")
}

func day7Part1() -> CommandValue {
    registers = [:]
    values = [:]
    
    for command in commands() {
        let tokens = command.componentsSeparatedByString(" -> ")
        registers[tokens.last!] = tokens.first!.componentsSeparatedByString(" ")
    }
    
    return calculate("a")
}

func day7Part2() -> CommandValue {
    let signalA = day7Part1()
    
    registers = [:]
    values = [:]
    
    for command in commands() {
        let tokens = command.componentsSeparatedByString(" -> ")
        registers[tokens.last!] = tokens.first!.componentsSeparatedByString(" ")
    }
    
    registers["b"] = [String(signalA)]
    
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