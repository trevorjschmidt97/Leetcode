//: [Previous](@previous)

import Foundation
import UIKit
import XCTest

// What did we learn?

class Solution {
    
    /// Given two sorted arrays nums1 and nums2 of size m and n respectively, return the median of the two sorted arrays.
    ///
    /// ```
    /// findMedianSortedArrays([1, 2], [3, 4]) // 2.500
    /// ```
    ///
    /// > Note: The overall run time complexity should be O(log (m+n)). However, this is unoptimized at the moment.
    /// I need to implement a binary search of the lists in order to find the optimum solution.
    ///
    /// - Parameters:
    ///     - _ nums1: 1st array of sorted Ints
    ///     - _ nums2: 2nd array of sorted Ints
    ///
    /// - Returns: Median of all the elements of the sorted arrays
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        var nums = nums1 + nums2
        nums = nums.sorted()
        
        var count = nums.count
        
        if count % 2 == 0 {
            return (Double(nums[count/2]) + Double(nums[(count - 1) / 2])) / 2.0
        }
        return Double(nums[count/2])
    }
}


class SolutionTests: XCTestCase {
//    Example 1:
//    Input: nums1 = [1,3], nums2 = [2]
//    Output: 2.00000
//    Explanation: merged array = [1,2,3] and median is 2.
    func testMedianSortedArrays1() {
        XCTAssertEqual(Solution().findMedianSortedArrays([1,3], [2]), 2.00000, accuracy: 0.001)
    }
    
//    Example 2:
//    Input: nums1 = [1,2], nums2 = [3,4]
//    Output: 2.50000
//    Explanation: merged array = [1,2,3,4] and median is (2 + 3) / 2 = 2.5.
    func testMedianSortedArrays2() {
        XCTAssertEqual(Solution().findMedianSortedArrays([1,2], [3,4]), 2.5, accuracy: 0.001)
    }
}


SolutionTests.defaultTestSuite.run()


//: [Next](@next)
