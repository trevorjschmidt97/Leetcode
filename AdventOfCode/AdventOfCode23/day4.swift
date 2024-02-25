import Foundation

func readTextFile(filePath: String) -> [String]? {
    do {
        // Read the contents of the file into a string
        let fileContents = try String(contentsOfFile: filePath, encoding: .utf8)
        
        // Split the string into an array of lines (strings)
        let lines = fileContents.components(separatedBy: .newlines)
        
        // Filter out any empty lines
        let nonEmptyLines = lines.filter { !$0.isEmpty }
        
        return nonEmptyLines
    } catch {
        // Handle the error if the file couldn't be read
        print("Error reading file: \(error)")
        return nil
    }
}

// Replace "dayOneInput.txt" with the actual name of your text file
let fileName = "day4Input.txt"
let filePath = FileManager.default.currentDirectoryPath.appending("/\(fileName)")
var lines = readTextFile(filePath: filePath)!

var sum = 0
var numCards = Array(repeating: 1, count: lines.count)

for (i, line) in lines.enumerated() {
    let numbers = line.split(separator: ":")[1]
    let winningNumbersSet = Set(numbers.split(separator: "|")[0].split(separator: " "))
    let numbersWeHave = numbers.split(separator: "|")[1].split(separator: " ")
    var count = 0
    for num in numbersWeHave {
        if winningNumbersSet.contains(num) { count += 1 }
    }

    if count == 0 { continue }
    let numICards = numCards[i]
    for j in 1...count {
        // if i + j > lines.count { break }
        numCards[i + j] += numICards
    }
    print(numCards)
}

// print(numCards)

print(numCards.reduce(0, +))