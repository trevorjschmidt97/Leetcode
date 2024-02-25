func palindromePermutation(_ str: String) -> Bool {
	var charCount: [Character: Int] = [:]

	for char in str {
		if char == " " { continue }
		charCount[char, default: 0] += 1
	}

	var seenOdd = false
	for count in charCount.values {
		if count % 2 == 0 { continue }
		if seenOdd { return false }
		seenOdd = true
	}
	return true
}

func aplindromePermutationConstantSpace(_ str: String) -> Bool {
	var charCount = Array(repeating: 0, count: 26) // constant always 26

	for char in str {
		if char == " " { continue }
		let index = Int(char.asciiValue!) - 97
		charCount[index] += 1
	}

	var seenOdd = false
	for count in charCount { // always 26 times
		if count % 2 == 0 { continue }
		if seenOdd { return false }
		seenOdd = true
	}
	return true
}

print(aplindromePermutationConstantSpace("taco catoov"))