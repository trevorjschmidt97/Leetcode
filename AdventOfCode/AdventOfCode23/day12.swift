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
let fileName = arguments.count > 1 && arguments[1] == "x" ? "day12InputExample.txt" : "day12Input.txt"
let filePath = FileManager.default.currentDirectoryPath.appending("/\(fileName)")
var lines = readTextFile(filePath: filePath)!

var dp: [String: Int] = [:] // dp changes it from O(2 ^ dots.count) to instead O(dots.count * blocks.count * dots.count)
// recurses for i in 0..<dots.count, with two options at each point (adding a "." or adding a "#")
func recurse(dots: [Character], blocks: [Int], i: Int, bi: Int, current: Int) -> Int {
    // DP memoization
    let key = "\(i), \(bi), \(current)"
    if let dpAns = dp[key] {
        return dpAns
    }

    // base case
    if i == dots.count { // once we've hit the end of the dots
        if bi == blocks.count && current == 0 { // if we have finished off the last block
            return 1
        } else if bi == blocks.count - 1 && blocks[bi] == current { // if we just finished the last block
            return 1
        } else {
            return 0
        }
    }

    var ans = 0
    for c in [Character("."),Character("#")] {
        if dots[i] == c || dots[i] == "?" { // only mess if it's a ? or the actual thing we're looking at
            if c == "." && current == 0 { // we can add a "." if we are not currently working on a block
                ans += recurse(dots: dots, blocks: blocks, i: i + 1, bi: bi, current: 0)
            } else if c == "." && current > 0 && bi < blocks.count && blocks[bi] == current { // or we can add a "." if we are working on a block and just finished, we move to the next block then
                ans += recurse(dots: dots, blocks: blocks, i: i + 1, bi: bi + 1, current: 0)
            } else if c == "#" { // else, we add a #
                ans += recurse(dots: dots, blocks: blocks, i: i + 1, bi: bi, current: current + 1)
            }
        }
    }
    dp[key] = ans
    return ans
}

var sum = 0
for line in lines {
    var row = line.split(separator: " ")[0].map{ Character("\($0)") } 
    var groups = line.split(separator: " ")[1].split(separator: ",").map{ Int($0)! }
    let rowCopy = row
    let groupCopy = groups
    for i in 0..<4 {
        if i < 4 {
            row.append(Character("?"))
        }
        for r in rowCopy {
            row.append(r)
        }
        for g in groupCopy {
            groups.append(g)
        }
    }

    dp = [:]
    sum += recurse(dots: row, blocks: groups, i: 0, bi: 0, current: 0)
}

print(sum)