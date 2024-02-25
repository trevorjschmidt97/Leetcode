//Definition for singly-linked list.
public class ListNode {
	public var val: Int
     	public var next: ListNode?

     	public init(_ val: Int = 0) { self.val = val; self.next = nil; }
	public init?(_ values: [Int]) {
	        guard !values.isEmpty else {
			return nil
	        }

        	self.val = values[0]
	        var current: ListNode? = self

	        for i in 1..<values.count {
            		current?.next = ListNode(values[i])
            		current = current?.next
        	}
    	}
}

// Time: O(n)
// Space: O(1)
func reverse(head: ListNode?) -> ListNode? {
	var prev: ListNode?
	var curr = head
	while curr != nil {
		let temp = curr?.next
		curr?.next = prev
		prev = curr
		curr = temp
	}
	return prev
}

func sumLists(list1: ListNode?, list2: ListNode?) -> ListNode? {
	var overflow: Int = 0
	let preHead = ListNode()
	var tail: ListNode? = preHead

	var list1 = list1
	var list2 = list2
	while true {
		if list1 == nil && list2 == nil { break }

		let sum = (list1?.val ?? 0) + (list2?.val ?? 0) + overflow

		overflow = sum / 10
		let nextNode = ListNode(sum % 10)
		tail?.next = nextNode
		tail = nextNode

		list1 = list1?.next
		list2 = list2?.next
	}
	if overflow > 0 {
		let finalNode = ListNode(overflow)
		tail?.next = finalNode
		tail = finalNode
	}
	return reverse(head: preHead.next)
}

var listNode1 = ListNode([7, 1, 9, 9])
var listNode2 = ListNode([5, 9, 2])

var sumNode = sumLists(list1: listNode1, list2: listNode2)
while sumNode != nil {
	print(sumNode?.val ?? -1)
	sumNode = sumNode?.next
}
