//
//  day4.swift
//  AdventOfCode
//
//  Created by Robbie Plankenhorn on 4/27/16.
//  Copyright © 2016 Plankenhorn.net. All rights reserved.
//

import Foundation

private extension String  {
    var md5: String! {
        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
        let strLen = CC_LONG(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.dealloc(digestLen)
        
        return String(format: hash as String)
    }
}

func day4Part1() -> Int {
    let input = "iwrupvqb"
    var start = 0
    
    while String(input + String(start)).md5.hasPrefix("00000") == false {
        start += 1
    }
    
    return start
}

func day4Part2() -> Int {
    let input = "iwrupvqb"
    var start = 0
    
    while String(input + String(start)).md5.hasPrefix("000000") == false {
        start += 1
    }
    
    return start
}