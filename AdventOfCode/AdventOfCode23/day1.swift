import Foundation

// Function to read contents of a text file and return an array of strings
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
let fileName = "dayOneInput.txt"

let filePath = FileManager.default.currentDirectoryPath.appending("/\(fileName)")
var lines = readTextFile(filePath: filePath)!

for i in 0..<lines.count {
    let line = Array(lines[i])
    var newLine = ""
    
    var j = 0
    while j < line.count {
        if j <= line.count - 3 && String(line[j..<j + 3]) == "one" {
            newLine += "1"
            j += 1
            continue
        } else if j <= line.count - 3 && String(line[j..<j + 3]) == "two" {
            newLine += "2"
            j += 1
            continue
        } else if j <= line.count - 5 && String(line[j..<j + 5]) == "three" {
            newLine += "3"
            j += 1
            continue
        } else if j <= line.count - 4 && String(line[j..<j + 4]) == "four" {
            newLine += "4"
            j += 1
            continue
        } else if j <= line.count - 4 && String(line[j..<j + 4]) == "five" {
            newLine += "5"
            j += 1
            continue
        } else if j <= line.count - 3 && String(line[j..<j + 3]) == "six" {
            newLine += "6"
            j += 1
            continue
        } else if j <= line.count - 5 && String(line[j..<j + 5]) == "seven" {
            newLine += "7"
            j += 1
            continue
        } else if j <= line.count - 5 && String(line[j..<j + 5]) == "eight" {
            newLine += "8"
            j += 1
            continue
        } else if j <= line.count - 4 && String(line[j..<j + 4]) == "nine" {
            newLine += "9"
            j += 1
            continue
        } else {
            newLine += String(line[j])
            j += 1
            continue
        }
    }
    lines[i] = newLine
}

var sum = 0

for i in 0..<lines.count {
    let line = lines[i]
    let last = line.last{ $0.isNumber }!
    let first = line.first{ $0.isNumber }!
    sum += Int("\(first)")! * 10 + Int("\(last)")!
}

print(sum)