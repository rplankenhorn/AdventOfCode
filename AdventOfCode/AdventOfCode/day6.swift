//
//  day6.swift
//  AdventOfCode
//
//  Created by Robbie Plankenhorn on 4/28/16.
//  Copyright © 2016 Plankenhorn.net. All rights reserved.
//

import Foundation

enum LightState {
    case On
    case Off
    case Toggle
}

extension Point {
    
    init(line:String) {
        let components = line.componentsSeparatedByString(",")
        self.x = Int(components.first!)!
        self.y = Int(components.last!)!
    }
    
}

struct Instruction {
    var state:LightState
    var start:Point
    var end:Point
    
    init(line:String) {
        var modifiedString:String
        
        if line.containsString("turn off") {
            state = .Off
            modifiedString = line.stringByReplacingOccurrencesOfString("turn off ", withString: "")
        } else if line.containsString("turn on") {
            state = .On
            modifiedString = line.stringByReplacingOccurrencesOfString("turn on ", withString: "")
        } else {
            state = .Toggle
            modifiedString = line.stringByReplacingOccurrencesOfString("toggle ", withString: "")
        }
        
        modifiedString = modifiedString.stringByReplacingOccurrencesOfString("through ", withString: "")
        
        let components = modifiedString.componentsSeparatedByString(" ")
        
        start = Point(line: components.first!)
        end = Point(line: components.last!)
    }
}

func instructions() -> [Instruction] {
    let path = NSBundle.mainBundle().pathForResource("day6_input", ofType: "txt")
    let text = try? NSString(contentsOfFile: path! as String, encoding: NSUTF8StringEncoding)
    return text!.componentsSeparatedByString("\n").map { Instruction(line: $0) }
}

func day6Part1() -> Int {
    var lights:[[Bool]] = []
    
    for _ in 0..<1000 {
        lights.append(Array(count: 1000, repeatedValue:false))
    }
    
    for instruction in instructions() {
        for i in instruction.start.x...instruction.end.x {
            for j in instruction.start.y...instruction.end.y {
                switch instruction.state {
                case .On: lights[i][j] = true
                case .Off: lights[i][j] = false
                case .Toggle: lights[i][j] = !lights[i][j]
                }
            }
        }
    }
    
    let count = lights.map { $0.flatMap { $0 ? 1 : nil } }.reduce([], combine: +).count
    
    return count
}