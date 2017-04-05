//
//  L4_2.swift
//  CodilityLessons
//
//  Created by Oleksandr Malovichko on 3/29/17.
//  Copyright © 2017 MAG. All rights reserved.
//

import XCTest

class L4_2: XCTestCase {
    
    func test() {
        var arr = [4, 1, 3, 2]
        XCTAssertEqual(solution(&arr), 1)
        
        var arr2 = [4, 1, 3]
        XCTAssertEqual(solution(&arr2), 0)
        
        var arr3 = [1]
        XCTAssertEqual(solution(&arr3), 1)
        
        var arr4 = [2]
        XCTAssertEqual(solution(&arr4), 0)
        
        var arr5 = [4, 1, 3, 2, 4]
        XCTAssertEqual(solution(&arr5), 0)
    }
    
    public func solution(_ A : inout [Int]) -> Int {
        var sum = 0
        var set = Set<Int>()
        for e in A {
            if set.contains(e) {
                return 0
            }
            set.insert(e)
            sum += e
        }
        
        let count = A.count
        let gaussSum = (count * (count + 1)) / 2
        
        let result = gaussSum - sum
        
        return result == 0 ? 1 : 0
    }
    
    // speed: 60 / 100
    public func solutionSlow(_ A : inout [Int]) -> Int {
        let arr = A.sorted()
        
        var n = 1
        for e in arr {
            if e == n {
                n += 1
                continue
            } else {
                return 0
            }
        }
        
        return 1
    }
    
}
