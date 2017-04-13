//
//  Lesson8Task1.swift
//  CodilityLessons
//
//  Created by Oleksandr Malovichko on 4/12/17.
//
//

import XCTest

class Lesson8Task1: XCTestCase {
    
    func test() {
        var arr = [4, 3, 4, 4, 4, 2]
        XCTAssertEqual(solution(&arr), 2)
        
        var arr2 = [0]
        XCTAssertEqual(solution(&arr2), 0)

        var arr3 = [1, 2, 1, 1, 2, 1]
        XCTAssertEqual(solution(&arr3), 3)
        
        measure {
            var arr4 = Array<Int>(repeatElement(0, count: 100_000))
            XCTAssertEqual(self.solution(&arr4), 99999)
        }
    }

    public func solution(_ A : inout [Int]) -> Int {
        let count = A.count
        
        if count <= 1 {
            return 0
        }
        
        var equiLeaders = Dictionary<Int, (leftLeader: Int?, rightLeader: Int?)>(minimumCapacity: count)
        
        var leftCounts = Dictionary<Int, Int>(minimumCapacity: count)
        var maxLeft = (value: Int.min, count: 0)
        
        var rightCounts = Dictionary<Int, Int>(minimumCapacity: count)
        var maxRight = (value: Int.min, count: 0)
        
        var leadersCount = 0
        
        for s in 0..<count {
            // Left side leader
            let l = A[s]
            if let currentCount = leftCounts[l] {
                leftCounts[l] = currentCount + 1
            } else {
                leftCounts[l] = 1
            }
            
            if maxLeft.count < leftCounts[l]! {
                maxLeft = (l, leftCounts[l]!)
            }
            
            if maxLeft.count >= (s + 1) / 2 + 1 {
                if equiLeaders[s] != nil {
                    equiLeaders[s]!.leftLeader = maxLeft.value
                } else {
                    equiLeaders[s] = (maxLeft.value, nil)
                }
            }
            
            // Right side leader
            let rightIndex = count - 1 - s
            let r = A[rightIndex]
            if let currentCount = rightCounts[r] {
                rightCounts[r] = currentCount + 1
            } else {
                rightCounts[r] = 1
            }
            
            if maxRight.count < rightCounts[r]! {
                maxRight = (r, rightCounts[r]!)
            }
            
            let rs = rightIndex - 1
            
            if maxRight.count >= (count - rightIndex) / 2 + 1 {
                if equiLeaders[rs] != nil {
                    equiLeaders[rs]!.rightLeader = maxRight.value
                } else {
                    equiLeaders[rs] = (nil, maxRight.value)
                }
            }
            
            // Check leaders
            if s != count - 1 {
                if let value = equiLeaders[s], value.leftLeader == value.rightLeader {
                    leadersCount += 1
                    equiLeaders[s] = nil
                }
            }
            if rightIndex != count - 1 {
                if let value = equiLeaders[rs], value.leftLeader == value.rightLeader {
                    leadersCount += 1
                    equiLeaders[rs] = nil
                }
            }
        }

        return leadersCount
    }

}