//
//  day12.swift
//  AdventOfCode
//
//  Created by Robbie Plankenhorn on 5/3/16.
//  Copyright © 2016 Plankenhorn.net. All rights reserved.
//

import Foundation

private func readJSONInput() -> [String:AnyObject] {
    let data = readInputFile("day12_input")!.dataUsingEncoding(NSUTF8StringEncoding)!
    return try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as! [String:AnyObject]
}

func day12Part1() -> Int {
    return countDictionary(readJSONInput(), countRed: true)
}

func day12Part2() -> Int {
    return countDictionary(readJSONInput(), countRed: false)
}

private func countDictionary(dict:[String:AnyObject], countRed:Bool) -> Int {
    var count = 0
    
    for (_, value) in dict {
        if let string = value as? String where countRed == false && string.caseInsensitiveCompare("red") == .OrderedSame {
            return 0
        }
        
        count += countValue(value, countRed: countRed)
    }
    
    return count
}

private func countArray(array:[AnyObject], countRed:Bool) -> Int {
    var count = 0
    
    for object in array {
        count += countValue(object, countRed: countRed)
    }
    
    return count
}

private func countValue(value:AnyObject, countRed:Bool) -> Int {
    var count = 0
    
    if let array = value as? [AnyObject] {
        count += countArray(array, countRed: countRed)
    } else if let dict = value as? [String:AnyObject] {
        count += countDictionary(dict, countRed: countRed)
    } else if let number = value as? NSNumber {
        count += number.integerValue
    } else if let _ = value as? String {
        return 0
    }
    
    return count
}