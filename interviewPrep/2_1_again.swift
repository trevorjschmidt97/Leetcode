class Node {
	var data: Int
	var next: Node? = nil

	init(data: Int, next: Node? = nil) {
		self.data = data
		self.next = next
	}

	func printAll() {
		var curr: Node? = self
		while curr != nil {
			print(curr!.data)
			curr = curr!.next
		}
	}
}

class LinkedList {
	var head: Node?

	init(head: Node?) {
		self.head = head
	}
}

var linkedList = LinkedList(head: Node(data: 1))
linkedList.head?.next = Node(data: 2)
linkedList.head?.next?.next = Node(data: 1)
linkedList.head?.next?.next?.next = Node(data: 4)
linkedList.head?.next?.next?.next?.next = Node(data: 5)
linkedList.head?.next?.next?.next?.next?.next = Node(data: 4)

func removeDups(head: Node?) -> Node? {
	var seen: Set<Int> = []

	var prev: Node? = nil
	var curr = head

	while curr != nil {
		if !seen.insert(curr!.data).inserted {
			prev?.next = curr?.next				
		} else {
			prev = curr			
		}
		curr = curr?.next
	}

	return head
}

func removeDupsNoSpace(head: Node?) -> Node? {

	var prev: Node? = nil
	var curr = head

	while curr != nil {
		let hasDup: Bool = {
			var runner = curr?.next
			while runner != nil {
				if runner?.data == curr?.data {
					return true
				}
				runner = runner?.next 	
			}
			return false
		}()
//		print(curr?.data ?? -1, hasDup)
		if hasDup {
			prev?.next = curr?.next				
		} else {
			prev = curr			
		}
		curr = curr?.next
	}

	return head
}

let removedDupsNode = removeDupsNoSpace(head: linkedList.head)
removedDupsNode?.printAll()