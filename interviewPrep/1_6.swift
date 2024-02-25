func compress(str: String) -> String {
	let strArr = Array(str)
	guard !str.isEmpty else { return str }
	
	var currentChar = strArr[0]
	var currentCount = 1
	var result = ""
	for i in 1..<strArr.count {
		if strArr[i] == currentChar {
			currentCount += 1
		} else {
			result += "\(currentChar)\(currentCount)"
			currentChar = strArr[i]
			currentCount = 1
		}
	}
	result += "\(currentChar)\(currentCount)"
	currentChar = strArr[strArr.count - 1]
	currentCount = 1

	return result.count < str.count ? result : str
}

let str = "aabcccccaaa"
print("\(str) -> \(compress(str: str))")