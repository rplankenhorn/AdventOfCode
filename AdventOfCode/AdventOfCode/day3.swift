//
//  day3.swift
//  AdventOfCode
//
//  Created by Robbie Plankenhorn on 4/27/16.
//  Copyright © 2016 Plankenhorn.net. All rights reserved.
//

import Foundation

enum Direction : String {
    case North = "^"
    case South = "v"
    case East = ">"
    case West = "<"
}

struct Point {
    var x:Int
    var y:Int
    
    init(x:Int, y:Int) {
        self.x = x
        self.y = y
    }
    
    func move(direction:Direction) -> Point {
        switch direction {
        case .North: return Point(x: self.x, y: self.y-1)
        case .South: return Point(x: self.x, y: self.y+1)
        case .East: return Point(x: self.x+1, y: self.y)
        case .West: return Point(x: self.x-1, y: self.y)
        }
    }
}

extension Point: Hashable {
    var hashValue: Int {
        return self.x.hashValue + self.y.hashValue
    }
}

func ==(lhs: Point, rhs: Point) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
}

private func directions() -> [Direction] {
    return readInputFile("day3_input")!.characters.map { Direction(rawValue: String($0))! }
}

func day3Part1() -> Int {
    var currentLocation = Point(x: 0, y: 0)
    var placesVisited = Set<Point>([currentLocation])
    
    for direction in directions() {
        currentLocation = currentLocation.move(direction)
        placesVisited.insert(currentLocation)
    }
    
    return placesVisited.count
}

func day3Part2() -> Int {
    var santaLocation = Point(x: 0, y: 0)
    var robotLocation = Point(x: 0, y: 0)
    var placesVisited = Set<Point>([santaLocation])
    
    let allDirections = directions()
    
    for i in 1...allDirections.count {
        if i % 2 == 0 {
            robotLocation = robotLocation.move(allDirections[i-1])
            placesVisited.insert(robotLocation)
        } else {
            santaLocation = santaLocation.move(allDirections[i-1])
            placesVisited.insert(santaLocation)
        }
    }
    
    return placesVisited.count
}