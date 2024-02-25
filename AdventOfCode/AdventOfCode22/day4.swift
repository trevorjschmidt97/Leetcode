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
let day = arguments[0].split(separator: ".")[0]
let fileName = arguments.count > 1 && arguments[1] == "x" ? "\(day)InputExample.txt" : "\(day)Input.txt"
let filePath = FileManager.default.currentDirectoryPath.appending("/\(fileName)")
var lines = readTextFile(filePath: filePath)!
// for line in lines { print(line) }

var count = 0
for line in lines {
    let one = line.split(separator: ",")[0].split(separator: "-").map{ Int($0)! }
    let two = line.split(separator: ",")[1].split(separator: "-").map{ Int($0)! }

    let oneSet = Set((one[0]...one[1]).map{ $0 })
    let twoSet = Set((two[0]...two[1]).map{ $0 })

    if !oneSet.isDisjoint(with: twoSet) {
        count += 1
    }

    // let largeSet = oneSet.count > twoSet.count ? oneSet : twoSet
    // let smallset = oneSet.count > twoSet.count ? twoSet : oneSet

    // if largeSet.isSuperset(of: smallset) {
    //     count += 1
    // }
}

print(count)