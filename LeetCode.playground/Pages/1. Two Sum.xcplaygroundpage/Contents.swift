//: [Previous](@previous)

import Foundation
import UIKit
import XCTest

// What did we learn?
// Using dictionaries allows us to store what we've already seen and read it quickly.
// .enumerated() is a function that works on collections<T> that returns a tuple of (index: Int, item: <T>)

class Solution {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var numToIndex: [Int:Int] = [:]

        for (i, num) in nums.enumerated() {
            let numToLookFor = target - num
            if let secondIndex = numToIndex[numToLookFor] {
                return [i, secondIndex]
            }
            numToIndex[num] = i
        }

        return []
    }
}


class SolutionTests: XCTestCase {
//    Example 1:
//    Input: nums = [2,7,11,15], target = 9
//    Output: [0,1]
//    Explanation: Because nums[0] + nums[1] == 9, we return [0, 1].
    func testTwoSumExample1() {
        XCTAssertEqual(Solution().twoSum([2,7,11,15], 9).sorted(), [0,1].sorted())
    }
    
//    Example 2:
//    Input: nums = [3,2,4], target = 6
//    Output: [1,2]
    func testTwoSumExample2() {
        XCTAssertEqual(Solution().twoSum([3,2,4], 6).sorted(), [1,2].sorted())
    }
    
//    Example 3:
//    Input: nums = [3,3], target = 6
//    Output: [0,1]
    func testTwoSumExample3() {
        XCTAssertEqual(Solution().twoSum([3,3], 6).sorted(), [0,1].sorted())
    }
}


SolutionTests.defaultTestSuite.run()


//: [Next](@next)
