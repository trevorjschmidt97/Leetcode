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

func kthToLast(head: Node?, k: Int) -> Node? {
	var p1 = head
	var p2 = head
	
	for _ in 0..<k {
		guard let next = p2?.next else { return p1 }
		p2 = next
	}

	while p2 != nil {
		p1 = p1?.next
		p2 = p2?.next
	}

	return p1
}

let result = kthToLast(head: linkedList.head, k: 6)
print(result?.data ?? -1)

