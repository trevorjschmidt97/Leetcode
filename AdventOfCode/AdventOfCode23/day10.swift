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
let fileName = arguments.count > 1 && arguments[1] == "x" ? "day10InputExample.txt" : "day10Input.txt"
let filePath = FileManager.default.currentDirectoryPath.appending("/\(fileName)")
var lines = readTextFile(filePath: filePath)!
// for line in lines { print(line) }

var grid = lines.map{ $0.map{ Character("\($0)") } }

var currCell: (Int, Int) = (0, 0)
for r in 0..<grid.count {
    for c in 0..<grid[r].count {
        if grid[r][c] == "S" { 
            currCell = (r, c)
            break
        }
    }
}

let charToDirections: [Character: [(Int, Int)]] = [
    "|": [(-1, 0), (1, 0)], // North and south
    "-": [(0, -1), (0, 1)], // west and east
    "L": [(-1, 0), (0, 1)], // north and east
    "J": [(-1, 0), (0, -1)], // nonth and west
    "7": [(1, 0), (0, -1)], // south and west
    "F": [(1, 0), (0, 1)], // south and east
]

func dfs(_ cell: (Int, Int) = currCell, _ path: [(Int, Int)], _ seen: Set<String>) -> [(Int, Int)]? {
    var seen = seen
    var path = path
    if cell.0 < 0 || cell.0 >= grid.count { return nil }
    if cell.1 < 0 || cell.1 >= grid[cell.0].count { return nil }
    if !seen.insert("\(cell)").inserted { 
        return nil 
    }
    if cell == currCell {
        return path
    }

    let currChar = grid[cell.0][cell.1]
    let directions = charToDirections[currChar, default: []]

    var paths = [[(Int, Int)]]()

    for direction in directions {
        path.append(cell)
        if let path = dfs((cell.0 + direction.0, cell.1 + direction.1), path, seen) {
            paths.append(path)
        }
    }

    var maxPath = paths.first ?? []
    for path in paths {
        maxPath = maxPath.count > path.count ? maxPath : path
    }

    return maxPath
}

func runDfs(_ cell: (Int, Int), charSet: Set<Character>) -> [(Int, Int)]? {
    if cell.0 < 0 || cell.0 >= grid.count { return [] }
    if cell.1 < 0 || cell.1 >= grid[cell.0].count { return [] }
    if !charSet.contains(grid[cell.0][cell.1]) { return [] }
    return dfs(cell, [], [])
}

let paths = [
    runDfs((currCell.0 - 1, currCell.1), charSet: ["|", "7", "F"]), // above
    runDfs((currCell.0 + 1, currCell.1), charSet: ["|", "L", "J"]), // below
    runDfs((currCell.0, currCell.1 - 1), charSet: ["-", "J", "7"]), // left
    runDfs((currCell.0, currCell.1 + 1), charSet: ["-", "L", "F"]), // right
].compactMap{ $0 }


var maxPath = paths.first ?? []
for path in paths {
    maxPath = maxPath.count > path.count ? maxPath : path
}

var seen: Set<String> = []
var path = [(Int, Int)]()
for cell in maxPath {
    if seen.insert("\(cell)").inserted {
        path.append(cell)
    }
}
path.append(currCell)

for cell in path {
    if cell.0 == 0 && cell.1 == 0 {
        print("hits the top left")
        break
    }
}

// print(path)