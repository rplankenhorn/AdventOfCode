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

// Pulled from http://stackoverflow.com/questions/34968470/calculate-all-permutations-of-a-string-in-swift
func permutations<C: CollectionType>(items: C) -> [[C.Generator.Element]] {
    var scratch = Array(items) // This is a scratch space for Heap's algorithm
    var result: [[C.Generator.Element]] = [] // This will accumulate our result
    
    // Heap's algorithm
    func heap(n: Int) {
        if n == 1 {
            result.append(scratch)
            return
        }
        
        for i in 0..<n-1 {
            heap(n-1)
            let j = (n%2 == 1) ? 0 : i
            swap(&scratch[j], &scratch[n-1])
        }
        heap(n-1)
    }
    
    // Let's get started
    heap(scratch.count)
    
    // And return the result we built up
    return result
}

//print("Day 1 Part 1: \(day1Part1())")
//print("Day 1 Part 2: \(day1Part2())")
//print("Day 2 Part 1: \(day2Part1())")
//print("Day 2 Part 2: \(day2Part2())")
//print("Day 3 Part 1: \(day3Part1())")
//print("Day 3 Part 2: \(day3Part2())")
//print("Day 4 Part 1: \(day4Part1())")
//print("Day 4 Part 2: \(day4Part2())")
//print("Day 5 Part 1: \(day5Part1())")
//print("Day 5 Part 2: \(day5Part2())")
//print("Day 6 Part 1: \(day6Part1())")
//print("Day 6 Part 2: \(day6Part2())")
//print("Day 7 Part 1: \(day7Part1())")
//print("Day 7 Part 2: \(day7Part2())")
//print("Day 8 Part 1: \(day8Part1())")
//print("Day 8 Part 2: \(day8Part2())")
//print("Day 9 Part 1: \(day9Part1())")
//print("Day 9 Part 2: \(day9Part2())")
//print("Day 10 Part 1: \(day10Part1())")
//print("Day 10 Part 2: \(day10Part2())")
//print("Day 11 Part 1: \(day11Part1())")
//print("Day 11 Part 2: \(day11Part2())")
//print("Day 12 Part 1: \(day12Part1())")
//print("Day 12 Part 2: \(day12Part2())")
//print("Day 13 Part 1: \(day13Part1())")
//print("Day 13 Part 2: \(day13Part2())")
//print("Day 14 Part 1: \(day14Part1())")
//print("Day 14 Part 2: \(day14Part2())")
//print("Day 15 Part 1: \(day15Part1())")
//print("Day 15 Part 2: \(day15Part2())")
//print("Day 16 Part 1: \(day16Part1())")
//print("Day 16 Part 2: \(day16Part2())")
print("Day 17 Part 1: \(day17Part1())")