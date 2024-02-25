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
let fileName = "dayTwoInput.txt"

let filePath = FileManager.default.currentDirectoryPath.appending("/\(fileName)")
var lines = readTextFile(filePath: filePath)!

var sum = 0
// Game 99: 6 green, 12 red, 1 blue; 5 blue, 1 red, 7 green; 5 green, 7 red, 10 blue; 8 blue, 1 red, 7 green; 17 red, 4 blue, 9 green

// only 12 red cubes, 13 green cubes, and 14 blue cubes?
for game in lines {
    let gameSets = game.split(separator: ":")[1].split(separator: ";")
    var numRed = 0
    var numGreen = 0
    var numBlue = 0
    for game in gameSets {
        let pulls = game.split(separator: ",")
        for pull in pulls {
            let num = Int(pull.split(separator: " ")[0])!
            let color = pull.split(separator: " ")[1]
            if color == "red" {
                numRed = max(numRed, num)
            } else if color == "green" {
                numGreen = max(numGreen, num)
            } else if color == "blue" {
                numBlue = max(numBlue, num)
            }
        }
    }
    sum += numRed * numGreen * numBlue
}

print(sum)