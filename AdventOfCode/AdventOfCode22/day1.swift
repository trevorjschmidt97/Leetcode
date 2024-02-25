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
let fileName = arguments.count > 1 && arguments[1] == "x" ? "day1InputExample.txt" : "day1Input.txt"
let filePath = FileManager.default.currentDirectoryPath.appending("/\(fileName)")
var lines = readTextFile(filePath: filePath)!


var nums = [Int]()
var curr = 0

for line in lines {
    let num = Int(line)
    if let num {
        curr += num
    } else {
        nums.append(curr)
        curr = 0
    }
}

print(Array(nums.sorted().reversed()).prefix(upTo: 3).reduce(0, +))