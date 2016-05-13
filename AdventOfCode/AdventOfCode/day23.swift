//
//  day23.swift
//  AdventOfCode
//
//  Created by Robbie Plankenhorn on 5/13/16.
//  Copyright © 2016 Plankenhorn.net. All rights reserved.
//

import Foundation

private enum Instruction {
    case Half(register:String)
    case Triple(register:String)
    case Increment(register:String)
    case Jump(offset:Int)
    case JumpIfEven(register:String, offset:Int)
    case JumpIfOne(register:String, offset:Int)
    
    init(line:String) {
        let tokens = line.stringByReplacingOccurrencesOfString(",", withString: "").componentsSeparatedByString(" ")
        
        if tokens.first! == "hlf" {
            self = .Half(register: tokens.last!)
        } else if tokens.first! == "tpl" {
            self = .Triple(register: tokens.last!)
        } else if tokens.first! == "inc" {
            self = .Increment(register: tokens.last!)
        } else if tokens.first! == "jmp" {
            self = .Jump(offset: Int(tokens.last!)!)
        } else if tokens.first! == "jie" {
            self = .JumpIfEven(register: tokens[1], offset: Int(tokens.last!.stringByReplacingOccurrencesOfString("+", withString: ""))!)
        } else {
            self = .JumpIfOne(register: tokens[1], offset: Int(tokens.last!.stringByReplacingOccurrencesOfString("+", withString: ""))!)
        }
    }
}

func day23Part1() -> Int {
    let instructions = readInputFile("day23_input")!.componentsSeparatedByString("\n").map { Instruction(line: $0) }
    
    var registers: [String:UInt] = ["a":0, "b":0]
    
    var i = 0
    
    while i < instructions.count {        
        switch instructions[i] {
        case .Half(register: let register): registers[register] = registers[register]! / 2
        case .Triple(register: let register): registers[register] = registers[register]! * 3
        case .Increment(register: let register): registers[register]! += 1
        case .Jump(offset: let offset):
            i+=offset
            continue
        case .JumpIfEven(register: let register, offset: let offset):
            if registers[register]! % 2 == 0 {
                i+=offset
                continue
            }
        case .JumpIfOne(register: let register, offset: let offset):
            if registers[register]! == 1 {
                i+=offset
                continue
            }
        }
        
        i+=1
    }
    
    return Int(registers["b"]!)
}