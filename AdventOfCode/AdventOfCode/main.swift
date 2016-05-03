//
//  main.swift
//  AdventOfCode
//
//  Created by Robbie Plankenhorn on 4/27/16.
//  Copyright © 2016 Plankenhorn.net. All rights reserved.
//

import Foundation

func readInputFile(filename:String) -> String? {
    let path = NSBundle.mainBundle().pathForResource(filename, ofType: "txt")
    return try? String(NSString(contentsOfFile: path! as String, encoding: NSUTF8StringEncoding))
}

print("Day 1 Part 1: \(day1Part1())")
print("Day 1 Part 2: \(day1Part2())")
print("Day 2 Part 1: \(day2Part1())")
print("Day 2 Part 2: \(day2Part2())")
print("Day 3 Part 1: \(day3Part1())")
print("Day 3 Part 2: \(day3Part2())")
print("Day 4 Part 1: \(day4Part1())")
print("Day 4 Part 2: \(day4Part2())")
print("Day 5 Part 1: \(day5Part1())")
print("Day 5 Part 2: \(day5Part2())")
print("Day 6 Part 1: \(day6Part1())")
print("Day 6 Part 2: \(day6Part2())")
print("Day 7 Part 1: \(day7Part1())")
print("Day 7 Part 2: \(day7Part2())")
print("Day 8 Part 1: \(day8Part1())")
print("Day 8 Part 2: \(day8Part2())")
print("Day 9 Part 1: \(day9Part1())")
