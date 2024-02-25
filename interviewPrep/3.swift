class Stack<T> {
	class Node {
		var data: T
		var next: Node?

		init(data: T) {
			self.data = data
		}
	}

	private var top: Node? = nil

	func pop() -> T {
		guard top != nil else { fatalError("Empty stack exception") }
		let item = top!.data
		top = top?.next
		return item
	}

	func push(_ item: T) {
		let newNode = Node(data: item)
		newNode.next = top
		top = newNode	
	}

	func peek() -> T {
		guard top != nil else { fatalError("Empty stack exception") }
		return top!.data
	}

	func isEmpty() -> Bool {
		top == nil
	}			
}

class Queue<T> {
	class Node {
		var data: T
		var next: Node?

		init(data: T) {
			self.data = data
		}
	}

	private var first: Node?
	private var last: Node?

	func add(_ item: T) {
		let newNode = Node(data: item)
		last?.next = newNode
		last = newNode
		if first == nil { first = last }
	}

	func remove() -> T {
		if first == nil { fatalError("No such element exception") }
		let data = first!.data
		first = first?.next
		if first == nil { last = nil }
		return data
	}

	func peek() -> T {
		if first == nil { fatalError("No such element exception") }
		return first!.data
	}

	func isEmpty() -> Bool {
		first == nil
	}
}


let queue: Queue<Int> = Queue()
queue.add(100)
print(queue.peek())
print(queue.isEmpty())
print(queue.remove())
print(queue.isEmpty())