//: [Previous](@previous)

import Foundation
import UIKit
import XCTest

// What did we learn?

//Definition for singly-linked list.
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

class Solution {
    
    /// You are given the head of a linked list containing unique integer values
    /// and an integer array nums that is a subset of the linked list values.
    /// Return the number of connected components in nums
    /// where two values are connected if they appear consecutively in the linked list.
    func numComponents(_ head: ListNode?, _ nums: [Int]) -> Int {
        let nums = Set(nums)
        var numConnected = 0
        var current = 0
        var node: ListNode? = head
        
        while node != nil {
            if nums.contains(node!.val) {
                current += 1
            } else {
                if current != 0 {
                    current = 0
                    numConnected += 1
                }
            }
            node = node!.next
        }
        
        if current != 0 {
            numConnected += 1
        }
        
        return numConnected
    }
}


class SolutionTests: XCTestCase {
    //    Example 1:
    //    Input: head = [0,1,2,3], nums = [0,1,3]
    //    Output: 2
    //    Explanation: 0 and 1 are connected, so [0, 1] and [3] are the two connected components.
    func testNnumComponents1() {
        XCTAssertEqual(Solution().numComponents(ListNode(0, ListNode(1, ListNode(2, ListNode(3)))), [0,1,3]), 2)
    }
    
    //    Example 2:
    //    Input: head = [0,1,2,3,4], nums = [0,3,1,4]
    //    Output: 2
    //    Explanation: 0 and 1 are connected, 3 and 4 are connected,
    //    so [0, 1] and [3, 4] are the two connected components.
    func testNnumComponents2() {
        XCTAssertEqual(Solution().numComponents(ListNode(0, ListNode(1, ListNode(2, ListNode(3, ListNode(4))))), [0,3,1,4]), 2)
    }
}


SolutionTests.defaultTestSuite.run()


//: [Next](@next)
