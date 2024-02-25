func allUnique(_ str: String) -> Bool {
	var seen: Set<Character> = []

	for char in str {
		if seen.contains(char) { return false }
		seen.insert(char)
	}
	return true
}

func allUniqueNoDataStructures(_ str: String) -> Bool {
	let str = str.sorted()
	var currentChar = ""

	for s in str {
		let char = String(s)
		if char == currentChar { return false }
		currentChar = char
	}
	return true
}

func allUniqueNoDataStructuresLinear(_ str: String) -> Bool {
	var characterCounts: [Int] = Array(repeating: 0, count: 26)

	for char in str {
		let index = Int(char.asciiValue!) - Int(Character("a").asciiValue!)
		if characterCounts[index] > 0 { return false }
		characterCounts[index] += 1
	}
	return true
}

let test = "abcdefghijklmnopqrstuvwxyzb"
print(allUniqueNoDataStructuresLinear(test).description)