
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

func removeDuplicates(node: Node?) -> Node? {
	var seen: Set<Int> = []
	var curr = node
	var prev: Node? = nil
	while curr != nil {
		!seen.insert(curr!.data).inserted ? (prev?.next = curr?.next) : (prev = curr)
		curr = curr?.next
	}
	return node
}

linkedList = LinkedList(head: removeDuplicates(node: linkedList.head))
linkedList.head?.printAll()
