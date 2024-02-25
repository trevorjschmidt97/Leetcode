
func validPath( _ edges: [[Int]], _ source: Int, _ destination: Int) -> Bool {
	var adgancencyList: [Int: [Int]] = [:] 

	for edge in edges {
		adgancencyList[edge[0], default: []].append(edge[1])
		adgancencyList[edge[1], default: []].append(edge[0])
	}

	var seen = Set<Int>()
	var stack: [Int] = []
	seen.insert(source)
	stack.append(source)
	
	while !stack.isEmpty {
		let val = stack.removeLast()
		if val == destination { return true }
		if let children = adgancencyList[val] {
			for child in children {
				if seen.insert(child).inserted {
					stack.append(child)
				}
			}
		}
	}

	return false
}

// print(validPath([[0,1], [0,2], [3,5], [5,4], [4,3]], 0, 5))

class TreeNode {
	var val: Int
	var left: TreeNode?
	var right: TreeNode?
	init(_ val: Int = 0, _ left: TreeNode? = nil, _ right: TreeNode? = nil) {
		self.val = val
		self.left = left
		self.right = right
	}
	
	func printTree() {
		var stack: [TreeNode] = [self]
		
		while !stack.isEmpty {
			let curr = stack.removeFirst()
			print(curr.val)
			if let left = curr.left { stack.append(left) }
			if let right = curr.right { stack.append(right) }
		}
	}
}

func sortedArrayToBST(_ nums: [Int], _ low: Int? = nil, _ high: Int? = nil) -> TreeNode? {
        guard let low = low, let high = high else { return sortedArrayToBST(nums, 0, nums.count - 1) }
        guard low <= high else { return nil }
        let mid = (high + low) / 2
        let root = TreeNode(nums[mid])
        root.left = sortedArrayToBST(nums, low, mid - 1)
        root.right = sortedArrayToBST(nums, mid + 1, high)
	return root
}

class ListNode {
	var val: Int
	var next: ListNode?
	init(_ val: Int = 0, next: ListNode? = nil) {
		self.val = val
		self.next = next
	}
	init?(_ values: [Int]) {
		guard !values.isEmpty else { return nil }
		self.val = values[0]
		var curr = self
		for i in 1..<values.count {
			let next = ListNode(values[i])
			curr.next = next
			curr = next
		}
	}
}


func dLinkedLists(root: TreeNode) -> [ListNode] {
	var listNodes: [ListNode] = []
	
	var queue: [TreeNode] = [root]
	while !queue.isEmpty {
		if let node = ListNode(queue.map { $0.val }) { listNodes.append(node) }
		var newList: [TreeNode] = []
		for node in queue {
			if let left = node.left { newList.append(left) }
			if let right = node.right { newList.append(right) }
		}
		queue = newList
	}

	return listNodes
}

guard let sorted = sortedArrayToBST([1, 2, 3, 4, 5, 6, 7, 8]) else { fatalError("No sorted") }


let linkedLists = dLinkedLists(root: sorted)
for listNode in linkedLists {
	var curr: ListNode? = listNode
	while curr != nil {
		print(curr?.val ?? -1, terminator: "")
		curr = curr?.next
	}
	print()
}


func checkBalanced(root: TreeNode) -> Bool {
	return abs(checkBalanceHelper(root.left) - checkBalanceHelper(root.right)) <= 1
}

func checkBalanceHelper(_ root: TreeNode?) -> Int {
	if root == nil { return 0 }
	return 1 + max(checkBalanceHelper(root?.left), checkBalanceHelper(root?.right))
}

func checkIfValidBinarySearchTree(_ root: TreeNode?) -> Bool {
	if root == nil { return true }
	if root!.left == nil && root!.right == nil { return true }
	if let leftVal = root!.left?.val, leftVal > root!.val {
		return false
	}
	if let rightVal = root!.right?.val, rightVal < root!.val {
		return false
	}
	return checkIfValidBinarySearchTree(root!.left) && checkIfValidBinarySearchTree(root!.right)
}

let balanced = checkBalanced(root: TreeNode(0, TreeNode(-1)))
print(balanced)



