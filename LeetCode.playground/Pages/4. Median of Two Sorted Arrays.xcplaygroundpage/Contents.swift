//: [Previous](@previous)

import Foundation
import UIKit
import XCTest

//first check


// What did we learn?
// Whenever we see O(log(x)), it should mean binary search
//class Solution {
//    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
//        let totalCount = nums1.count + nums2.count
//        if totalCount == 0 {
//            return 0
//        } else if totalCount <= 2 || nums1.count == 0 || nums2.count == 0 {
//            let nums = nums1 + nums2
//            let midIndex = nums.count / 2
//            if nums.count % 2 == 1 {
//                return Double(nums[midIndex])
//            } else {
//                return Double(nums[midIndex] + nums[midIndex - 1]) / 2
//            }
//        }
//
//        var start1 = 0
//        var end1 = nums1.count
//        var start2 = 0
//        var end2 = nums2.count
//
//        let cut = min(max(1, totalCount / 4), min(nums1.count, nums2.count))
//        if nums1[cut - 1] < nums2[cut - 1] {
//            start1 = cut
//        } else {
//            start2 = cut
//        }
//        if nums1[nums1.count - cut] > nums2[nums2.count - cut] {
//            end1 = max(start1, nums1.count - cut)
//        } else {
//            end2 = max(start2, nums2.count - cut)
//        }
//
//        let newNums1 = Array(nums1[start1..<end1])
//        let newNums2 = Array(nums2[start2..<end2])
//        return findMedianSortedArrays(newNums1, newNums2)
//    }
//}
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
//        var nums = nums1 + nums2
//        nums = nums.sorted()
//
//        var count = nums.count
//
//        // If even, we need middle left and right averaged
//        if count % 2 == 0 {
//            let midLeft = nums[(count - 1) / 2]
//            let midRight = nums[count/2]
//            return Double(midLeft + midRight) / 2.0
//        }
//        return Double(nums[count/2])
        let totalCount = nums1.count + nums2.count
        let isEven = totalCount % 2 == 0
        let half = totalCount / 2 // rounded down
        let smallList = nums1.count > nums2.count ? nums1 : nums2
        let largeList = nums2.count > nums1.count ? nums2 : nums1

        var left = 0
        var right = smallList.count - 1

        while true {
            let mid = (left + right) / 2
            // Index that splits the large list
            // such that the count of left sides of both == count of right sides of both
            let bigMid = half - mid - 2

            let smallLeft = mid >= 0 ? smallList[mid] : Int.min
            let smallRight = mid + 1 < smallList.count ? smallList[mid + 1] : Int.max
            let largeLeft = bigMid >= 0 ? largeList[bigMid] : Int.min
            let largeRight = bigMid + 1 < largeList.count ? largeList[bigMid + 1] : Int.max

            // We found the partition
            if smallLeft <= largeRight && smallRight >= largeLeft {
                let result: Double
                if isEven {
                    result = Double(max(smallLeft, largeLeft) + min(smallRight, largeRight)) / 2
                } else {
                    result = Double(min(smallRight, largeRight))
                }
                return result
            }

            if smallLeft > largeRight {
                right = mid - 1
            } else {
                left = mid + 1
            }
        }
    }
}

//print(Solution().findMedianSortedArrays((1..<100000).map{$0}, [60000]))// (1..<1).map{$0}))
Solution().findMedianSortedArrays([1,2], [3,4])


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
