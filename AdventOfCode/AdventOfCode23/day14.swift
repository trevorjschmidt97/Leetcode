import Foundation

extension Collection where Self.Iterator.Element: RandomAccessCollection {
    // PRECONDITION: `self` must be rectangular, i.e. every row has equal size.
    func transposed() -> [[Self.Iterator.Element.Iterator.Element]] {
        guard let firstRow = self.first else { return [] }
        return firstRow.indices.map { index in
            self.map{ $0[index] }
        }
    }
}

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

var grid = lines.map{ $0.map{ Character("\($0)") } }
var numCycles = 200


var count = grid.count
var sum = 0
for r in 0..<grid.count {
    for c in 0..<grid[r].count {
        if grid[r][c] == "O" {
            sum += count
        }
    }
    count -= 1
}

print(0, sum)

var seen: Dictionary<[[Character]], Int> = [:]

for cycle in 0..<numCycles {
    for i in 0..<4 {
        for col in 0..<grid[0].count {
            for row in 0..<grid.count {
                if grid[row][col] == "O" {
                    // move it up until it either hits the end, another O or a #
                    var nextR = row - 1
                    while nextR >= 0 && grid[nextR][col] == "." {
                        grid[nextR][col] = "O"
                        grid[nextR + 1][col] = "."
                        nextR -= 1
                    }
                }
            }
        }
         
        grid = grid.transposed()
        for i in 0..<grid.count {
            grid[i] = grid[i].reversed()
        }
    }
    if cycle == 96 {
    // if let lastSeen = seen[grid] {
        print(grid)
        var count = grid.count
        var sum = 0
        for r in 0..<grid.count {
            for c in 0..<grid[r].count {
                if grid[r][c] == "O" {
                    sum += count
                }
            }
            count -= 1
        }
        print(cycle, sum)
        // print(lastSeen)
        break
    }
    seen[grid] = cycle
    print(cycle)
}