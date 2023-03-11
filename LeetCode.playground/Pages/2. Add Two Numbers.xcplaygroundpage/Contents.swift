//: [1. Two Sum](@previous)

import Foundation
import UIKit
import XCTest

// What did we learn?
// It's important to use recursion
// We can pass an extra parameter to the function with a default val for more info during recursion

//Definition for singly-linked list.
public class ListNode: Equatable {
    public static func == (lhs: ListNode, rhs: ListNode) -> Bool {
        return (lhs.val == rhs.val && lhs.next == rhs.next)
    }
    
    public var val: Int
    public var next: ListNode?
    
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int, _ next: ListNode? = nil) { self.val = val; self.next = next; }
    public init(_ vals: [Int]) {
        guard !vals.isEmpty else {
            self.val = 0
            self.next = nil
            return
        }
        
        self.val = vals[0]
        var currentNode = self
        
        for i in 1..<vals.count {
            let newNode = ListNode(vals[i])
            currentNode.next = newNode
            currentNode = newNode
        }
    }
}

class Solution {
    
    // You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order, and each of their nodes contains a single digit. Add the two numbers and return the sum as a linked list.
    // You may assume the two numbers do not contain any leading zero, except the number 0 itself.

    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?, dig: Int = 0) -> ListNode? {
        var dig = dig
        if l1 == nil && l2 == nil && dig == 0 { return nil }
        let sum = (l1?.val ?? 0) + (l2?.val ?? 0) + dig
        dig = sum / 10
        return ListNode(sum % 10, addTwoNumbers(l1?.next, l2?.next, dig: dig))
    }
    
}


class SolutionTests: XCTestCase {
    //    Input: l1 = [2,4,3], l2 = [5,6,4]
    //    Output: [7,0,8]
    //    Explanation: 342 + 465 = 807.
    func testAddTwoNumbersExample1() {
        let l1 = ListNode(2, ListNode(4, ListNode(3)))
        let l2 = ListNode(5, ListNode(6, ListNode(4)))
        let output = ListNode(7, ListNode(0, ListNode(8)))
        XCTAssertEqual(Solution().addTwoNumbers(l1, l2), output)
    }
    
    //    Example 2:
    //    Input: l1 = [0], l2 = [0]
    //    Output: [0]
    func testAddTwoNumbersExample2() {
        let l1 = ListNode([0])
        let l2 = ListNode([0])
        let output = ListNode([0])
        XCTAssertEqual(Solution().addTwoNumbers(l1, l2), output)
    }
    
    //    Example 3:
    //    Input: l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]
    //    Output: [8,9,9,9,0,0,0,1]
    func testAddTwoNumbersExample3() {
        let l1 = ListNode([9,9,9,9,9,9,9])
        let l2 = ListNode([9,9,9,9])
        let output = ListNode([8,9,9,9,0,0,0,1])
        XCTAssertEqual(Solution().addTwoNumbers(l1, l2), output)
    }
}


SolutionTests.defaultTestSuite.run()


//: [3. Longest Substring Without Repeating Characters](@next)
