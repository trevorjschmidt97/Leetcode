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
let fileName = arguments.count > 1 && arguments[1] == "x" ? "day11InputExample.txt" : "day11Input.txt"
let filePath = FileManager.default.currentDirectoryPath.appending("/\(fileName)")
var lines = readTextFile(filePath: filePath)!
// for line in lines { print(line) }

var space = lines.map{ $0.map{ Character("\($0)") } }

var rowsToExpand: [Int] = []
var colsToExpand: [Int] = []

for r in 0..<space.count {
    var containsGalaxy = false
    for c in 0..<space[r].count {
        if space[r][c] == "#" { containsGalaxy = true }
    }
    if !containsGalaxy { rowsToExpand.append(r) }
}

for c in 0..<space[0].count {
    var containsGalaxy = false
    for r in 0..<space.count {
        if space[r][c] == "#" { containsGalaxy = true }
    }
    if !containsGalaxy { colsToExpand.append(c) }
}

// for row in rowsToExpand.reversed() {
//     for _ in 0..<numToExpand {
//         space.insert(Array(repeating: ".", count: space[0].count), at: row)
//     }
// }

// for col in colsToExpand.reversed() {
//     for r in 0..<space.count {
//         for _ in 0..<numToExpand {
//             space[r].insert(".", at: col)
//         }
//     }
// }

var galaxyLocations: [(Int, Int)] = []

for r in 0..<space.count {
    for c in 0..<space[r].count {
        if space[r][c] == "#" {
            galaxyLocations.append((r, c))
        }
    }
}

var shortestLengths: [Int] = []

for i in 0..<galaxyLocations.count {
    for j in i + 1..<galaxyLocations.count {
        let dest = galaxyLocations[i]
        let source = galaxyLocations[j]

        let lowerRow = min(dest.0, source.0)
        let upperRow = max(dest.0, source.0)
        let rows = rowsToExpand.filter{ lowerRow < $0 && $0 < upperRow }
        let lowerCol = min(dest.1, source.1)
        let upperCol = max(dest.1, source.1)
        let cols = colsToExpand.filter{ lowerCol < $0 && $0 < upperCol }
        let expansionRate = 1_000_000 - 1

        shortestLengths.append(upperRow - lowerRow + (rows.count * expansionRate) + upperCol - lowerCol + (cols.count * expansionRate))
    }
}

print(shortestLengths.reduce(0, +))

// for source in galaxyLocations {
//     var shortestLength = Int.max
//     for dest in galaxyLocations {
//         if source == dest { continue }
//         shortestLength = min(shortestLength, abs(dest.0 - source.0) + abs(dest.1 - source.1))
//     }
//     print(shortestLength, source)
// }
