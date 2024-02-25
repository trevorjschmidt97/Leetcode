class ListNode {
	var val: Int
	var next: ListNode?
	
	init(_ val: Int = 0) {
		self.val = val
	}
	init?(_ values: [Int]) {
		guard !values.isEmpty else { return nil }
		self.val = values[0]
		var curr: ListNode? = self
		for i in 1..<values.count {
			curr?.next = ListNode(values[i])
			curr = curr?.next
		}
	}
}

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

func deleteNode(from head: ListNode?, val: Int) -> ListNode? {
	if let headVal = head?.val, headVal == val { return head?.next }
	var prev: ListNode?
	var curr = head

	while curr != nil {
		if let currVal = curr?.val, currVal == val {
			prev?.next = curr?.next
			break
		} else {
			prev = curr
			curr = curr?.next
		}
	}
	return head
}

func removeDups(from head: ListNode?) -> ListNode? {
	var seen: Set<Int> = []
	var prev: ListNode? = nil
	var curr = head

	while curr != nil {
		if !seen.insert(curr!.val).inserted {
			prev?.next = curr?.next
		} else {
			prev = curr
		}	
		curr = curr?.next
	}

	return head
}

func removeDupsAgain(from head: ListNode?) -> ListNode? {
	var prev: ListNode? = nil
	var curr = head
	var seen = Set<Int>()	
	while curr != nil {
		let inserted = seen.insert(curr!.val).inserted
		if !inserted {
			prev?.next = curr?.next
		} else {
			prev = curr
		}
		curr = curr?.next
	}
	return head
}

func removeDupsNoSpace(from head: ListNode?) -> ListNode? {
	var head = head
	var prev: ListNode?
	var curr = head	
	while curr != nil {
		let inserted: Bool = {
			var runner = curr?.next
			while runner != nil {
				if runner?.val == curr?.val {
					return false
				}
				runner = runner?.next
			}
			return true
		}()
		if !inserted {
			if prev == nil { head = head?.next }
			prev?.next = curr?.next
		} else {
			prev = curr
		}
		curr = curr?.next
	}
	return head
}

func removeDupsNoSpaceAgain(from head: ListNode?) -> ListNode? {
	var head = head
	var prev: ListNode?
	var curr = head
	while curr != nil {
		let inserted: Bool = {
			var runner = curr?.next
			while runner != nil {
				if runner?.val == curr?.val {
					return false
				}
				runner = runner?.next
			}
			return true
		}()
		if !inserted {
			if prev == nil { head = head?.next }
			prev?.next = curr?.next
		} else {
			prev = curr
		}
		curr = curr?.next
	}
	return head
}

func returnKthToLast(of head: ListNode?, k: Int) -> ListNode? {
	var p1 = head
	var p2 = head
	
	for _ in 0..<k {
		p2 = p2?.next
	}

	while p2 != nil {
		p1 = p1?.next
		p2 = p2?.next
	}
	
	return p1
}

func returnKthToLastAgain(of head: ListNode?, k: Int) -> ListNode? {
	var p1 = head
	var p2 = head

	for _ in 0..<k {
		p2 = p2?.next
	}

	while p2 != nil {
		p1 = p1?.next
		p2 = p2?.next
	}

	return p1
}

func deleteMiddleNode(mid: ListNode?) {
	mid?.val = mid?.next?.val ?? -1
	mid?.next = mid?.next?.next
}

func partition(head: ListNode?, by x: Int) -> ListNode? {
	let preHeadL = ListNode()
	let preHeadR = ListNode()
	var tailL: ListNode? = preHeadL
	var tailR: ListNode? = preHeadR
	preHeadL.next = tailL
	preHeadR.next = tailR

	var curr = head
	while curr != nil {
		if let currVal = curr?.val, currVal < x {
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

func partitionAgain(_ head: ListNode?, by x: Int) -> ListNode? {
	let preHeadL = ListNode()
	let preHeadR = ListNode()
	var tailL: ListNode? = preHeadL
	var tailR: ListNode? = preHeadR
	preHeadL.next = tailL
	preHeadR.next = tailR

	var curr = head
	while curr != nil {
		if let currVal = curr?.val, currVal <= x {
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

func sumLists(l1: ListNode?, l2: ListNode?) -> ListNode? {
	var overflow = 0
	var l1 = l1
	var l2 = l2
	
	let preHead = ListNode()
	var tail: ListNode? = preHead

	while true {
		if l1 == nil && l2 == nil { break }
		let sum = (l1?.val ?? 0) + (l2?.val ?? 0) + overflow
		overflow = sum / 10
		let remainder = sum % 10
		let newNode = ListNode(remainder)
		tail?.next = newNode
		tail = newNode

		l1 = l1?.next
		l2 = l2?.next
	}
	if overflow > 0 {
		let newNode = ListNode(overflow) 
		tail?.next = newNode
		tail = newNode
	}
	return reverse(head: preHead.next)
}

func isPalindrome(head: ListNode?) -> Bool {
	var p1 = head
	var p2 = head

	var stack: [Int?] = []
	
	while p2 != nil {
		stack.append(p1?.val)
		p1 = p1?.next
		p2 = p2?.next?.next
	}
	print(stack)
	if stack.count % 2 != 0 { stack.removeLast() }
	while p1 != nil {
		let top = stack.removeLast()
		guard top == p1?.val else { return false }
		p1 = p1?.next
	}

	return true
}



let l1 = ListNode([7, 1, 6, 4, 4, 6, 1, 7])
print(isPalindrome(head: l1))

