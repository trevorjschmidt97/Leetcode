//: [Previous](@previous)

import Foundation
import UIKit
import XCTest

// What did we learn?
// Binary search 

class Solution {
    
    /// Given an array of integers nums which is sorted in ascending order, and an integer target, write a function to search target in nums.
    /// If target exists, then return its index. Otherwise, return -1.
    ///
    /// ```
    /// search([1, 2, 3, 4], 3) // 2
    /// ```
    ///
    /// > Note: You must write an algorithm with O(log n) runtime complexity.
    ///
    /// - Parameters:
    ///     - _ nums: [Int] // Array of Ints, sorted
    ///     - _ target: Int // Target number to find
    ///
    /// - Returns: Int // the index of the number, if found. -1 if not.
    func search(_ nums: [Int], _ target: Int) -> Int {
        var left = 0
        var right = nums.count - 1
        while left <= right {
            let mid = (right + left) / 2
            if nums[mid] == target {
                return mid
            }
            if nums[mid] < target {
                left = mid + 1
            } else if nums[mid] > target {
                right = mid - 1
            }
        }
        return -1
    }
}


class SolutionTests: XCTestCase {
//    Example 1:
//    Input: nums = [-1,0,3,5,9,12], target = 9
//    Output: 4
//    Explanation: 9 exists in nums and its index is 4
    func testSearch1() {
        XCTAssertEqual(Solution().search([-1,0,3,5,9,12], 9), 4)
    }
    
//    Example 2:
//    Input: nums = [-1,0,3,5,9,12], target = 2
//    Output: -1
//    Explanation: 2 does not exist in nums so return -1
    func testSearch2() {
        XCTAssertEqual(Solution().search([-1,0,3,5,9,12], 2), -1)
    }
}


SolutionTests.defaultTestSuite.run()


//: [Next](@next)
