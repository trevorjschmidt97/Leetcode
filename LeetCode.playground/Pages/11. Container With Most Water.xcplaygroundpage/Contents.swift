//: [Previous](@previous)

import Foundation
import UIKit
import XCTest

// What did we learn?
// Two Pointers!
// 

class Solution {
    
    /// You are given an integer array height of length n.
    /// There are n vertical lines drawn such that the two endpoints of the ith line are (i, 0) and (i, height[i]).
    /// Find two lines that together with the x-axis form a container, such that the container contains the most water.
    /// Return the maximum amount of water a container can store.
    /// Notice that you may not slant the container.
    func maxArea(_ height: [Int]) -> Int {
        var bestArea = 0
        
        var left = 0
        var right = height.count - 1
        
        while left < right {
            
            let area = (right - left) * min(height[left], height[right])
            bestArea = max(bestArea, area)
            
            if height[right] > height[left] {
                left += 1
            } else {
                right -= 1
            }
        }
        
        return bestArea
    }
}


class SolutionTests: XCTestCase {
    
//    Example 1:
//    Input: height = [1,8,6,2,5,4,8,3,7]
//    Output: 49
//    Explanation:
//    The above vertical lines are represented by array [1,8,6,2,5,4,8,3,7].
//    In this case, the max area of water (blue section) the container can contain is 49.
    func testMaxArea1() {
        XCTAssertEqual(Solution().maxArea([1,8,6,2,5,4,8,3,7]), 49)
    }
    
//    Example 2:
//    Input: height = [1,1]
//    Output: 1
    func testMaxArea2() {
        XCTAssertEqual(Solution().maxArea([1, 1]), 1)
    }
}


SolutionTests.defaultTestSuite.run()


//: [Next](@next)
