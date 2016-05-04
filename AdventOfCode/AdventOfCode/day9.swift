//
//  day9.swift
//  AdventOfCode
//
//  Created by Robbie Plankenhorn on 5/2/16.
//  Copyright © 2016 Plankenhorn.net. All rights reserved.
//

import Foundation

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