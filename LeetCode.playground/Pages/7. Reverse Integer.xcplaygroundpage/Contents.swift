//: [Previous](@previous)

import Foundation
import UIKit
import XCTest

// What did we learn?
// Sometimes easier is easier.
// I could have used a combination of / 10 and % 10, but I like this way better

class Solution {
    
    /// Given a signed 32-bit integer x, return x with its digits reversed.
    /// If reversing x causes the value to go outside the signed 32-bit integer range [-231, 231 - 1], then return 0.
    /// Assume the environment does not allow you to store 64-bit integers (signed or unsigned).
    func reverse(_ x: Int) -> Int {
        let isNeg = x < 0
        let x = abs(x)
        guard let reversed = Int(String(String(x).reversed())), reversed < 2147483647 else {
            return -1
        }
        return reversed * (isNeg ? -1 : 1)
    }
}


class SolutionTests: XCTestCase {
//    Example 1:
//    Input: x = 123
//    Output: 321
    func testReverse1() {
        XCTAssertEqual(Solution().reverse(123), 321)
    }
    
//    Example 2:
//    Input: x = -123
//    Output: -321
    func testReverse2() {
        XCTAssertEqual(Solution().reverse(-123), -321)
    }
    
//    Example 3:
//    Input: x = 120
//    Output: 21
    func testReverse3() {
        XCTAssertEqual(Solution().reverse(120), 21)
    }
}


SolutionTests.defaultTestSuite.run()


//: [Next](@next)
