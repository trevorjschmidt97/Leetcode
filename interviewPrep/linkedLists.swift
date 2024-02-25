struct Node<T> {
	var value: T
	var next: Node<T>? = nil
}

let node: Node<String> = Node(value: "test")