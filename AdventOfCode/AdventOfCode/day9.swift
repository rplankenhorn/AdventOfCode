//
//  day9.swift
//  AdventOfCode
//
//  Created by Robbie Plankenhorn on 5/2/16.
//  Copyright © 2016 Plankenhorn.net. All rights reserved.
//

import Foundation

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

func getPlacesAndDistances() -> (Set<String>, [String:[String:Int]]) {
    let lines = readInputFile("day9_input")!.componentsSeparatedByString("\n")
    
    var places = Set<String>()
    var distances:[String:[String:Int]] = [:]
    
    for line in lines {
        let tokens = line.componentsSeparatedByString(" ")
        let source = tokens[0]
        let destination = tokens[2]
        let distance = Int(tokens.last!)!
        places.insert(source)
        places.insert(destination)
        
        distances[source] = distances[source] ?? [:]
        distances[destination] = distances[destination] ?? [:]
        
        distances[source]![destination] = distance
        distances[destination]![source] = distance
    }
    
    return (places, distances)
}

func day9Part1() -> Int {
    let placesAndDistances = getPlacesAndDistances()
    
    let places = placesAndDistances.0
    let distances = placesAndDistances.1
    
    var shortestPath = Int.max
    
    for items in permutations(places) {
        var currentPath = 0
        
        for i in 0..<items.count-1 {
            let currentPlace = items[i]
            let destinationPlace = items[i+1]
            currentPath += distances[currentPlace]![destinationPlace]!
        }
        
        shortestPath = Swift.min(shortestPath, currentPath)
    }
    
    return shortestPath
}

func day9Part2() -> Int {
    let placesAndDistances = getPlacesAndDistances()
    
    let places = placesAndDistances.0
    let distances = placesAndDistances.1
    
    var longestPath = 0
    
    for items in permutations(places) {
        var currentPath = 0
        
        for i in 0..<items.count-1 {
            let currentPlace = items[i]
            let destinationPlace = items[i+1]
            currentPath += distances[currentPlace]![destinationPlace]!
        }
        
        longestPath = Swift.max(longestPath, currentPath)
    }
    
    return longestPath
}