//
//  day7.swift
//  AdventOfCode
//
//  Created by Robbie Plankenhorn on 4/28/16.
//  Copyright © 2016 Plankenhorn.net. All rights reserved.
//

import Foundation

private typealias CommandValue = UInt16

private var registers: [String:[String]] = [:]
private var values:[String:CommandValue] = [:]

private func commands() -> [String] {
    return readInputFile("day7_input")!.componentsSeparatedByString("\n")
}

func day7Part1() -> UInt16 {
    registers = [:]
    values = [:]
    
    for command in commands() {
        let tokens = command.componentsSeparatedByString(" -> ")
        registers[tokens.last!] = tokens.first!.componentsSeparatedByString(" ")
    }
    
    return calculate("a")
}

func day7Part2() -> UInt16 {
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

private func calculate(wire:String) -> CommandValue {
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