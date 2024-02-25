import Foundation

func readTextFile(filePath: String) -> [String]? {
    do {
        // Read the contents of the file into a string
        let fileContents = try String(contentsOfFile: filePath, encoding: .utf8)
        
        // Split the string into an array of lines (strings)
        let lines = fileContents.components(separatedBy: .newlines)
        
        // Filter out any empty lines
        // let nonEmptyLines = lines.filter { !$0.isEmpty }
        
        return lines
    } catch {
        // Handle the error if the file couldn't be read
        print("Error reading file: \(error)")
        return nil
    }
}

// Replace "dayOneInput.txt" with the actual name of your text file
let arguments = CommandLine.arguments
let fileName = arguments.count > 1 && arguments[1] == "x" ? "day3InputExample.txt" : "day3Input.txt"
let filePath = FileManager.default.currentDirectoryPath.appending("/\(fileName)")
var lines = readTextFile(filePath: filePath)!

var sum = 0

var i = 0
while i < lines.count {
    let char = Set(lines[i]).intersection(lines[i + 1]).intersection(lines[i + 2]).first!
    sum += Int("\(char.isUppercase ? char.asciiValue! - 38 : char.asciiValue! - 96)")!
    i += 3
}

// for line in lines {
//     let char: Character = Set(line.prefix(line.count / 2)).intersection(line.suffix(line.count / 2)).first!
//     print(char, char.isUppercase ? char.asciiValue! - 38 : char.asciiValue! - 96)
//     sum += Int("\(char.isUppercase ? char.asciiValue! - 38 : char.asciiValue! - 96)")!
// }
print(sum)