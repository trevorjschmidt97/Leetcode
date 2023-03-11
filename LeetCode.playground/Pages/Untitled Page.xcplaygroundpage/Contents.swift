import UIKit
import XCTest

class Solution {
    
    // Palindrome Number
    //    Given an integer x, return true if x is a palindrome,
    //        and false otherwise.
    //Input: x = 121
    //Output: true
    //Explanation: 121 reads as 121 from left to right and from right to left.
    //Input: x = -121
    //Output: false
    //Explanation: From left to right, it reads -121. From right to left, it becomes 121-. Therefore it is not a palindrome.
    //Input: x = 10
    //Output: false
    //Explanation: Reads 01 from right to left. Therefore it is not a palindrome.
    func isPalindrome(_ x: Int) -> Bool {
        return String(String(x).reversed()) == String(x)
    }

    
    // Description
//    Given two sorted arrays nums1 and nums2 of size m and n respectively,
//    return the median of the two sorted arrays.
//    The overall run time complexity should be O(log (m+n)).
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        guard !nums1.isEmpty && !nums2.isEmpty else { return 0.0 }
        
        
        var nums = nums1 + nums2
        nums = nums.sorted()
        
        if nums.count % 2 == 0 {
            let leftNum = Double(nums[nums.count / 2 - 1])
            let rightNum = Double(nums[nums.count / 2])
            return (leftNum + rightNum) / 2
        } else {
            return Double(nums[nums.count / 2])
        }
    }
    
    
    // LengthOfLongestSubstring
    /// 1. For each char in the string
    /// 2.      Check to see if we have seen the char before
    /// 2.          If so, then also check to make sure it's in our window
    /// 2.          If it is, then reset our window's left index
    /// 3.      Update our bestLength
    /// 4.      Update the last seen location of the char
    /// 5. Then return our bestLength
    func lengthOfLongestSubstring(_ s: String) -> Int {
        if s.isEmpty {
            return 0
        }
        
        var bestLength = 0
        var charToIndex: [Character:Int] = [:]
        var leftIndex = 0
        
        for (rightIndex, char) in s.enumerated() {
            if let index = charToIndex[char], index >= leftIndex {
                leftIndex = index + 1
            }
            bestLength = max(bestLength, rightIndex - leftIndex + 1)
            charToIndex[char] = rightIndex
        }
        
        return bestLength
    }
    
    func binarySearch(_ nums: [Int], _ target: Int) -> Int {
        
        var left = 0
        var right = nums.count
        
        while left <= right {
            let middleIndex = (right - left) / 2
            
            let middleNum = nums[middleIndex]
            
            if middleNum == target {
                return middleIndex
            }
            
            if middleNum > target {
                left = middleIndex + 1
            } else {
                right = middleIndex
            }
        }
        
        return -1
    }
}

class SolutionTests: XCTestCase {
    
    func testBinarySearchOne() {
        XCTAssertEqual(Solution().binarySearch([0,1,2,3,4,7], 7), 5)
    }
    
    func testLengthOfLongestSubstringOne() {
        XCTAssertEqual(Solution().lengthOfLongestSubstring("abcabcbb"), 3)
    }
    
    func testLengthOfLongestSubstringTwo() {
        XCTAssertEqual(Solution().lengthOfLongestSubstring("bbbbb"), 1)
    }
    
    func testLengthOfLongestSubstringThree() {
        XCTAssertEqual(Solution().lengthOfLongestSubstring("pwwkew"), 3)
    }
    
    func testFindMedianSortedArraysOne() {
        XCTAssertEqual(Solution().findMedianSortedArrays([1,3], [2]), 2.0, accuracy: 0.01)
    }
    
    func testFindMedianSortedArraysTwo() {
        XCTAssertEqual(Solution().findMedianSortedArrays([1,2], [3,4]), 2.5, accuracy: 0.01)
    }
    
    func testFindMedianSortedArrays() {
        XCTAssertEqual(Solution().findMedianSortedArrays([], []), 0.0, accuracy: 0.01)
    }
    
    func testPalindromeNumberOne() {
        XCTAssertEqual(Solution().isPalindrome(121), true)
    }
    
    func testPalindromeNumberTwo() {
        XCTAssertEqual(Solution().isPalindrome(-121), false)
    }
    
    func testPalindromeNumberThree() {
        XCTAssertEqual(Solution().isPalindrome(10), false)
    }
}


SolutionTests.defaultTestSuite.run()
