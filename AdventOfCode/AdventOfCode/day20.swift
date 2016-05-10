//
//  day20.swift
//  AdventOfCode
//
//  Created by Robbie Plankenhorn on 5/10/16.
//  Copyright © 2016 Plankenhorn.net. All rights reserved.
//

import Foundation

func day20Part1() -> Int {
    let input = 34000000
    var houses = [Int](count: 29000000, repeatedValue: 0)
    
    let n = 29000000
    
    for i in 1..<(n/10) {
        for j in i.stride(to: n/10, by: i) {
            houses[j] += i * 10
        }
    }
    
    return houses.indexOf(houses.filter({ $0 >= input }).first!)!
}

func day20Part2() -> Int {
    let input = 34000000
    var houses = [Int](count: 34000000, repeatedValue: 1)
    
    for e in 2...houses.count {
        var i = 0
        
        for h in (e-1).stride(to: houses.count, by: e) {
            houses[h] += e*11
            i += 1
            
            if i >= 50 {
                break
            }
        }
        
        if houses[e-1] >= input {
            return e
        }
    }
    
    return -1
}