//: [Previous](@previous)

import Foundation
import UIKit
import XCTest

// What did we learn?

class Solution {
    
    /// Given two sorted arrays nums1 and nums2 of size m and n respectively, return the median of the two sorted arrays.
    ///
    /// ```
    /// name([1, 2], [3, 4]) // 2.500
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
    func name() -> Int? {
        return nil
    }
}


class SolutionTests: XCTestCase {
    func testNameExample1() {
        XCTAssertEqual(Solution().name(), nil)
    }
}


SolutionTests.defaultTestSuite.run()


//: [Next](@next)
