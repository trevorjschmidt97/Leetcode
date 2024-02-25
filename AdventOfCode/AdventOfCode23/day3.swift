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
let fileName = "day3Input.txt"
let filePath = FileManager.default.currentDirectoryPath.appending("/\(fileName)")
var lines = readTextFile(filePath: filePath)!
var grid = [[Character]]()
for line in lines {
    grid.append(Array(line))
}

func sumOfEngineParts(_ grid: [[Character]]) -> Int {
    var partToCountAndPower: [String: (Int, Int)] = [:]

    for r in 0..<grid.count {
        var c = 0
        while c < grid[r].count {
            if grid[r][c].isNumber {
                var connectedParts = Set<String>()

                var nums = [Int("\(grid[r][c])")!]
                connectedParts = connectedParts.union(checkIfHasPart(grid, r, c))
                c += 1
                while c < grid[r].count && grid[r][c].isNumber {
                    connectedParts = connectedParts.union(checkIfHasPart(grid, r, c))
                    nums.append(Int("\(grid[r][c])")!)
                    c += 1
                }
                for n in 0..<nums.count {
                    for _ in 0..<n {
                        nums[nums.count - n - 1] *= 10
                    }
                }
                for part in connectedParts {
                    var prev = partToCountAndPower[part, default: (0, 1)]
                    prev.0 += 1
                    prev.1 *= nums.reduce(0, +)
                    partToCountAndPower[part] = prev
                }
                
            } else {
                c += 1
            }
        }
    }

    var sum = 0

    print(partToCountAndPower)

    for countAndPower in partToCountAndPower.values {
        if countAndPower.0 == 2 {
            sum += countAndPower.1
        }
    }

    return sum
}

func checkIfHasPart(_ grid: [[Character]], _ r: Int, _ c: Int) -> Set<String> {
    var result = Set<String>()
    if let check = checkIfPart(grid, r - 1, c - 1) { result.insert(check) }
    if let check = checkIfPart(grid, r - 1, c) { result.insert(check) }
    if let check = checkIfPart(grid, r - 1, c + 1) { result.insert(check) }
    if let check = checkIfPart(grid, r, c - 1) { result.insert(check) }
    if let check = checkIfPart(grid, r, c + 1) { result.insert(check) }
    if let check = checkIfPart(grid, r + 1, c - 1) { result.insert(check) }
    if let check = checkIfPart(grid, r + 1, c) { result.insert(check) }
    if let check = checkIfPart(grid, r + 1, c + 1) { result.insert(check) }
    return result
}

func checkIfPart(_ grid: [[Character]], _ r: Int, _ c: Int) -> String? {
    guard r >= 0 && r < grid.count && c >= 0 && c < grid[r].count else { return nil }
    if !grid[r][c].isNumber && grid[r][c] != "." { return "\(r),\(c)" } else { return nil }
}


print(sumOfEngineParts(grid))