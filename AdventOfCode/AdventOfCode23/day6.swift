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
let fileName = arguments.count > 1 && arguments[1] == "x" ? "day6InputExample.txt" : "day6Input.txt"
let filePath = FileManager.default.currentDirectoryPath.appending("/\(fileName)")
var lines = readTextFile(filePath: filePath)!

var times = [Int(lines[0].split(separator: ":")[1].split(separator: " ").joined())!]
var distances = [Int(lines[1].split(separator: ":")[1].split(separator: " ").joined())!]

var count = 0

print(times, distances)

for i in 0..<times.count {
    let prevBest = distances[i]
    let raceDuration = times[i]
    for j in 0..<raceDuration {
        let speed = j
        let distanceTraveled = speed * (raceDuration - speed)
        if distanceTraveled > prevBest {
            count += 1
        }
    }
}

print(count)


