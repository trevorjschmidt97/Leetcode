import Foundation
func urlify(_ str: String, trueLength: Int) -> String {
	String(str.prefix(trueLength)).replacingOccurrences(of: " ", with: "%20")
}

let input = "Mr John Smith   "
let trueLength = 13

print(urlify(input, trueLength: trueLength))