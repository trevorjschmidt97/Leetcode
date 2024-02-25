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
let arguments = CommandLine.arguments
let fileName = arguments.count > 1 && arguments[1] == "x" ? "day9InputExample.txt" : "day9Input.txt"
let filePath = FileManager.default.currentDirectoryPath.appending("/\(fileName)")
var lines = readTextFile(filePath: filePath)!

func dfs(_ input: [Int]) -> [Int] {
    if input.allSatisfy{ $0 == 0 } { 
        var input = input
        input.append(0)
        return input
    }

    var next = Array(repeating: 0, count: input.count - 1)

    for i in 1..<input.count {
        next[i - 1] = input[i] - input[i - 1]
    }

    next.append(next.last! + dfs(next).last!)

    return next
}

print(lines.map{ $0.split(separator: " ").map{ Int($0)! }.reversed() }.reduce(0) { $0 + dfs($1).last! + $1.last! })