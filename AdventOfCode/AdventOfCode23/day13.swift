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

var grids = [[[Character]]]()
var currentGrid = [[Character]]()
for line in lines {
    if line.isEmpty { 
        grids.append(currentGrid)
        currentGrid = []    
    } else {
        currentGrid.append(line.map{ Character("\($0)") })
    }
}
grids.append(currentGrid)   

// for grid in grids {
//     for row in grid {
//         print(row)
//     }
//     print()
// }

var sum = 0
for grid in grids {
    // First thing to check if it the mirror is placed up and down
    // for row in grid
    var nonWorkingCols = Set<Int>()
    for row in 0..<grid.count {
        // for col in row where !nonWorkingCol.contains(col)
        for col in 0..<grid[row].count  {
            var l = col, r = col + 1
            // while l >= 0 and r < grid[row].count and grid[row][l] == grid[row][r]
            while l >= 0 && r < grid[row].count && grid[row][l] == grid[row][r] {
                //  keep incrementing/decrementing
                l -= 1
                r += 1
            }
            // if it stops because grid[row][l] != grid[row][r], we know that the col doesn't work
            if l >= 0 && r < grid[row].count {
                nonWorkingCols.insert(col)
            }
        }
    }
    // Then, we can check all nonWorkingCols against working cols and see if there's one that works
    var workingCols = Set((1..<grid[0].count - 1).map{ $0 }).subtracting(nonWorkingCols)
    // print(workingCols)
    if let col = workingCols.first {
        sum += col + 1
        // continue
    }

    let grid = grid.transposed()
    nonWorkingCols = Set<Int>()
    for row in 0..<grid.count {
        // for col in row where !nonWorkingCol.contains(col)
        for col in 0..<grid[row].count  {
            var l = col, r = col + 1
            // while l >= 0 and r < grid[row].count and grid[row][l] == grid[row][r]
            while l >= 0 && r < grid[row].count && grid[row][l] == grid[row][r] {
                //  keep incrementing/decrementing
                l -= 1
                r += 1
            }
            // if it stops because grid[row][l] != grid[row][r], we know that the col doesn't work
            if l >= 0 && r < grid[row].count {
                nonWorkingCols.insert(col)
            }
        }
    }
    // Then, we can check all nonWorkingCols against working cols and see if there's one that works
    workingCols = Set((1..<grid[0].count - 1).map{ $0 }).subtracting(nonWorkingCols)
    // print(workingCols)
    if let col = workingCols.first {
        sum += (col + 1) * 100
        // continue
    }

    // // Then, we need to check if the mirror is placed left to right
    // var nonWorkingRows = Set<Int>()
    // // for row in grid where !nonWorkingRows.contains(row)
    // for row in 0..<grid.count {
    //     // for each col in grid
    //     for col in 0..<grid[row].count {
    //         var u = row, d = row + 1
    //         // while u >= 0 and d < grid.count and grid[u][col] == grid[d][col]
    //         while u >= 0 && d < grid.count && grid[u][col] == grid[d][col] {
    //             //  keep incrementing/decrementing
    //             u -= 1
    //             d += 1
    //         }
    //         if u >= 0 && d < grid.count {
    //             // if it stops because grid[u][col] != grid[d][col], we know row doesn't work
    //             nonWorkingRows.insert(row)
    //         }
    //     }
    // }
    // // Then check all nonWorkingRows against rows and see if there's one that works
    // let workingRows = Set((1..<grid.count - 1).map{ $0 }).subtracting(nonWorkingRows)
    // print(workingRows)
    // if let row = workingRows.first {
    //     sum += (row + 1) * 100
    // }

    // if workingCols.isEmpty && workingRows.isEmpty {
    //     for row in grid {
    //         print(row.map{ String($0) }.joined())
    //     }
    //     break
    // }

}
print(sum)
