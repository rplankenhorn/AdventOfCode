//
//  day25.swift
//  AdventOfCode
//
//  Created by Robbie Plankenhorn on 5/16/16.
//  Copyright © 2016 Plankenhorn.net. All rights reserved.
//

import Foundation

func day25() -> UInt {
    var codes:[[UInt?]] = Array(count: 8000, repeatedValue: [UInt?](count: 8000, repeatedValue: nil))
    
    let firstCode:UInt = 20151125
    
    var count:UInt = 1
    var previousCode = firstCode
    
    for j in 0..<codes.count {
        var row = j
        var column = 0
        
        while row >= 0 && column < codes.count {
            var calculatedValue:UInt
            
            if row == 0 && column == 0 {
                calculatedValue = firstCode
            } else {
                calculatedValue = (previousCode * 252533) % 33554393
            }
            
            codes[row][column] = calculatedValue
            previousCode = calculatedValue
            count += 1
            row-=1
            column+=1
        }
    }

    return codes[2980][3074]!
}