//: [Previous](@previous)

import Foundation
import UIKit
import XCTest

// What did we learn?
// Sliding window

class Solution {
    // LengthOfLongestSubstring
    /// 1. For each char in the string
    /// 2.      Check to see if we have seen the char before
    /// 2.          If so, then also check to make sure it's in our window
    /// 2.          If it is, then reset our window's left index
    /// 3.      Update our bestLength
    /// 4.      Update the last seen location of the char
    /// 5. Then return our bestLength
    ///
    /// Given a string s, find the length of the longest substring without repeating characters.
    /*:
    See [leetcode]https://leetcode.com/problems/longest-substring-without-repeating-characters/)
   */
    func lengthOfLongestSubstring(_ s: String) -> Int {
        if s.isEmpty {
            return 0
        }
        
        var bestLength = 0
        var charToIndex: [Character:Int] = [:]
        var leftIndex = 0
        
        for (rightIndex, char) in s.enumerated() {
            // if we have seen the char before
            // And it is in our window
            // then reset our window to right after that occurance
            if let index = charToIndex[char], index >= leftIndex {
                leftIndex = index + 1
            }
            // Update our best length
            bestLength = max(bestLength, rightIndex - leftIndex + 1)
            // Update last seen location of char
            charToIndex[char] = rightIndex
        }
        
        return bestLength
    }
}


class SolutionTests: XCTestCase {
    
//    Example 1:
//    Input: s = "abcabcbb"
//    Output: 3
//    Explanation: The answer is "abc", with the length of 3.
    func testLengthOfLongestSubstringOne() {
        XCTAssertEqual(Solution().lengthOfLongestSubstring("abcabcbb"), 3)
    }
    
//    Example 2:
//    Input: s = "bbbbb"
//    Output: 1
//    Explanation: The answer is "b", with the length of 1.
    func testLengthOfLongestSubstringTwo() {
        XCTAssertEqual(Solution().lengthOfLongestSubstring("bbbbb"), 1)
    }
    
//    Example 3:
//    Input: s = "pwwkew"
//    Output: 3
//    Explanation: The answer is "wke", with the length of 3.
//    Notice that the answer must be a substring, "pwke" is a subsequence and not a substring.
    func testLengthOfLongestSubstringThree() {
        XCTAssertEqual(Solution().lengthOfLongestSubstring("pwwkew"), 3)
    }
}


SolutionTests.defaultTestSuite.run()


//: [Next](@next)
