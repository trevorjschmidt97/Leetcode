func oneAway(str1: String, str2: String) -> Bool {
	let str1 = Array(str1)
	let str2 = Array(str2)
	// edit
	if str1.count == str2.count {
		var changeMade = false
		for i in 0..<str1.count {
			if str1[i] == str2[i] { continue }
			if changeMade { return false }
			changeMade = true
		}
		return true
	}

	// add/remove is the same
	if abs(str1.count - str2.count) > 1 { return false }
	let longer = str1.count > str2.count ? str1 : str2
	let shorter = str1.count > str2.count ? str2 : str1

	var changeMade = 0
	for i in 0..<shorter.count {
		if longer[i + changeMade] == shorter[i] { continue }
		if changeMade == 1 { return false }
		changeMade = 1
	}
	return true
}


var str1 = "pale"
var str2 = "ple"
print("\(str1), \(str2) -> \(oneAway(str1: str1, str2: str2))")

str1 = "pales"
str2 = "pale"
print("\(str1), \(str2) -> \(oneAway(str1: str1, str2: str2))")

str1 = "pale"
str2 = "bale"
print("\(str1), \(str2) -> \(oneAway(str1: str1, str2: str2))")

str1 = "pale"
str2 = "bake"
print("\(str1), \(str2) -> \(oneAway(str1: str1, str2: str2))")