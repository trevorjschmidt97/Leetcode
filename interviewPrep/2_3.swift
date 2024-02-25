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

	        for value in values.dropFirst() {
            		current?.next = ListNode(value)
            		current = current?.next
        	}
    	}
}

var listNode = ListNode([1, 4, 3, 2, 5, 2])

func partition(_ head: ListNode?, _ x: Int) -> ListNode? {
	let preHeadL = ListNode()
	let preHeadR = ListNode()
	var tailL: ListNode? = preHeadL
	var tailR: ListNode? = preHeadR
	
	var curr = head
	while curr != nil {
		if curr!.val < x {
			tailL?.next = curr
			tailL = curr
		} else {
			tailR?.next = curr
			tailR = curr
		}
		curr = curr?.next
	}

	tailL?.next = preHeadR.next
	tailR?.next = nil
	return preHeadL.next
}

let part = partition(listNode, 3)

var curr = part
while curr != nil {
	print(curr?.val ?? -1)
	curr = curr?.next
}