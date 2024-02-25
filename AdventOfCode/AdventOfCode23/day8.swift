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
let fileName = arguments.count > 1 && arguments[1] == "x" ? "day8InputExample.txt" : "day8Input.txt"
let filePath = FileManager.default.currentDirectoryPath.appending("/\(fileName)")
var lines = readTextFile(filePath: filePath)!

let instructions = Array(lines.removeFirst())
var nodes: [String: (String, String)] = [:]

for line in lines {
    let key = String(Array(line.split(separator: "=")[0]).dropLast())
    let value = String(Array(line.split(separator: "=")[1]).dropFirst().dropFirst().dropLast())
    let left = String(value.split(separator: ",")[0])
    let right = String(value.split(separator: ",")[1].dropFirst())
    nodes[key] = (left, right)
}

func gcd(_ a: Int, _ b: Int) -> Int {
    if a == 0 { return b }
    return gcd(b % a, a)
}

func lcm(_ a: Int, _ b: Int) -> Int {
    return (a / gcd(a, b)) * b
}

var currLocations: [String] = Array(nodes.keys).filter{ $0.last == "A" }
var shortestSteps: [Int] = []

for currLocation in currLocations {
    var currLocation = currLocation
    var curr = 0
    while currLocation.last != "Z" {
        let currNode = nodes[currLocation]!
        let nextInstruction = instructions[curr % instructions.count]
        if nextInstruction == "L" {
            currLocation = currNode.0
        } else {
            currLocation = currNode.1
        }
        curr += 1
    }
    shortestSteps.append(curr)
}

print(shortestSteps.reduce(shortestSteps.first!) { lcm($0, $1) })