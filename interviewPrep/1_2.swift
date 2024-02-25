func checkPermutation(str1: String, str2: String) -> Bool {
	var str1CharCount: [Character: Int] = [:]
	var str2CharCount: [Character: Int] = [:]

	for s in str1 {
		str1CharCount[s, default: 0] += 1
	}
	for s in str2 {
		str2CharCount[s, default: 0] += 1
	}

	return str1CharCount == str2CharCount
}

func checkPermutationNoDataStructures(str1: String, str2: String) -> Bool {
	let str1 = str1.sorted()
	let str2 = str2.sorted()
	return str1 == str2
}

let str1 = "abcdefg"
let str2 = "abcdegf"
print(checkPermutationNoDataStructures(str1: str1, str2: str2))