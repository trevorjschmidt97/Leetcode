// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

func day1(_ isTest: Bool) throws -> String {
    let lines = try getLines(of: "day1.txt")
    let cleanLines = lines.map{ $0.replacingOccurrences(of: "   ", with: " ")}
    var firstNums = [Int]()
    var secondNums = [Int]()
    for line in cleanLines {
        let nums = line.split(separator: " ")
        let firstNum = Int(nums[0])!
        let secondNum = Int(nums[1])!

        firstNums.append(firstNum)
        secondNums.append(secondNum)
    }
    firstNums.sort()
    secondNums.sort()

    let countOfNumsInSecondList = secondNums.reduce(into: [:]) { $0[$1, default: 0] += 1 }
    print(countOfNumsInSecondList)

    var sum = 0
    for i in 0..<firstNums.count {
        sum += firstNums[i] * countOfNumsInSecondList[firstNums[i], default: 0]
    }

    return "\(sum)"
}

func day2(isTest: Bool = false) throws {
    let lines = try getLines(of: "day2\(isTest ? "Test" : "").txt")

    var sum = 0

    outer:
    for line in lines {
        let levels = line.split(separator: " ").compactMap{ Int($0) }
        // print(line)
        inner:
        for i in 0...levels.count {
            var newLevel = levels
            if i < levels.count {
                newLevel.remove(at: i)
            }
            // print("\t", newLevel)

            guard newLevel == newLevel.sorted() || newLevel.reversed() == newLevel.sorted() else { continue inner }
            for i in 1..<newLevel.count {
                let diff = abs(newLevel[i] - newLevel[i - 1])
                guard diff <= 3 && diff > 0 else { continue inner }
            }
            sum += 1
            // print("\tYes!")
            break inner
        }
    }
    print(sum)
}

func day3(isTest: Bool = false) throws -> Int {
    try getLines(of: "day3\(isTest ? "Test" : "").txt")
        .flatMap { matches(for: "mul\\(\\d+,\\d+\\)", in: $0) }
        .map{ $0.replacingOccurrences(of: "mul(", with: "") }
        .map{ $0.replacingOccurrences(of: ")", with: "") }
        .map{ 
            $0.split(separator: ",")
                .compactMap { Int($0) }
        }
        .map{ $0[0] * $0[1] }
        .reduce(0, +)
}
func day3Part2(isTest: Bool = false) throws -> Int {
    try getLines(of: "day3\(isTest ? "Test" : "").txt")
        .flatMap{ line in
            matches(for: "mul\\(\\d+,\\d+\\)|don't\\(\\)|do\\(\\)", in: line)
        }
        .reduce(into: (0, true)) { res, line in
            switch line {
            case "do()":
                res.1 = true
            case "don't()":
                res.1 = false
            default:
                if !res.1 { return }
                res.0 = res.0 + line
                    .replacingOccurrences(of: "mul(", with: "")
                    .replacingOccurrences(of: ")", with: "")
                    .split(separator: ",")
                    .compactMap { Int($0) }
                    .reduce(1, *)
            }
        }.0
}

func day4Part1(_ isTest: Bool = true) throws -> String {
    let lines = try getLines(of: "day4\(isTest ? "Test" : "").txt").map{ Array($0) }

    let toFind: [Character] = ["X", "M", "A", "S"]

    let directions = [
        [0, 1], // right
        [0, -1], // left
        [1, 0], // down
        [-1, 0], // up
        [1, 1], // down right
        [1, -1], // down left
        [-1, 1], // up right
        [-1, -1] // up left
    ]
    
    var result = 0

    func dfs(_ i: Int, _ j: Int, _ count: Int, _ directionIndex: Int) {
        let newI = i + directions[directionIndex][0]
        let newJ = j + directions[directionIndex][1]
        guard 0..<n ~= newI && 0..<m ~= newJ && lines[newI][newJ] == toFind[count] else { return }
        if count == 3 { 
            result += 1 
            return
        }
        dfs(newI, newJ, count + 1, directionIndex)
    }

    let n = lines.count
    let m = lines[0].count
    for i in 0..<n {
        for j in 0..<m where lines[i][j] == "X" {
            for direction in 0..<directions.count {
                dfs(i, j, 1, direction)
            }
        }
    }

    return "\(result)"
}

func day4Part2(_ isTest: Bool = true) throws -> String {
    let lines = try getLines(of: "day4\(isTest ? "Test" : "").txt").map{ Array($0) }
    var result = 0
    let setOfMAndS: Set<Character> = Set(["M", "S"])
    for i in 1..<lines.count - 1 {
        for j in 1..<lines[i].count - 1 where lines[i][j] == "A" {
            let neg = Set([lines[i - 1][j - 1], lines[i + 1][j + 1]])
            let pos = Set([lines[i + 1][j - 1], lines[i - 1][j + 1]])
            if neg == setOfMAndS && pos == setOfMAndS {
                result += 1
            }
        }
    }
    return "\(result)"
}

func exampleDay(_ lines: [[Character]]) -> String {
    #function + " " + lines.joined(separator: "\n")
}

func day5(_ lines: [[Character]]) -> String {
    var adjacencyList: [Int: Set<Int>] = [:]
    
    let rules = lines.filter{ $0.contains("|") }
    for rule in rules {
        let ruleString = rule.map{ String("\($0)") }.joined(separator: "")
        let ruleArr = ruleString.components(separatedBy: "|")
        let firstNum = Int(ruleArr[0])!
        let secondNum = Int(ruleArr[1])!
        adjacencyList[firstNum, default: []].insert(secondNum)
    }
    
    let updates = lines.filter{ $0.contains(",") }.map{ $0.map{ String("\($0)") }.joined(separator: "") }
    var result = 0
    outer:
    for update in updates {
        let updateArr = update.split(separator: ",")
        for i in 0..<updateArr.count {
            let iNum = Int(updateArr[i])!
            for j in i..<updateArr.count {
                let jNum = Int(updateArr[j])!
                if adjacencyList[jNum, default: []].contains(iNum) { continue outer }
            }
        }
        let mid = updateArr.count / 2
        result += Int(updateArr[mid])!
    }
    
    return "\(result)"
}

func day5Part2(_ lines: [[Character]]) -> String {
    var adjacencyList: [Int: Set<Int>] = [:]
    
    let rules = lines.filter{ $0.contains("|") }
    for rule in rules {
        let ruleString = rule.map{ String("\($0)") }.joined(separator: "")
        let ruleArr = ruleString.components(separatedBy: "|")
        let firstNum = Int(ruleArr[0])!
        let secondNum = Int(ruleArr[1])!
        adjacencyList[firstNum, default: []].insert(secondNum)
    }
    
    let updates = lines.filter{ $0.contains(",") }.map{ $0.map{ String("\($0)") }.joined(separator: "") }
    
    var result = 0
    
    for update in updates {
        var updateArr = update.split(separator: ",").compactMap{ Int($0) }
        var isCorrect = true
        
        for i in 0..<updateArr.count {
            let iNum = updateArr[i]
            for j in i..<updateArr.count {
                let jNum = updateArr[j]
                if adjacencyList[jNum, default: []].contains(iNum) {
                    isCorrect = false
                    break
                }
            }
        }
        if isCorrect { continue }
        
        updateArr.sort { leftNum, rightNum in
            adjacencyList[rightNum, default: []].contains(leftNum)
        }
        let mid = updateArr.count / 2
        result += updateArr[mid]
    }
    
    return "\(result)"
}

func day6(_ lines: [[Character]]) -> String {
    #function + " " + lines.joined(separator: "\n")
}

func day6Part2(_ lines: [[Character]]) -> String {
    #function + " " + lines.joined(separator: "\n")
}

func day7(_ lines: [[Character]]) -> String {
    #function + " " + lines.joined(separator: "\n")
}

func day7Part2(_ lines: [[Character]]) -> String {
    #function + " " + lines.joined(separator: "\n")
}

func day8(_ lines: [[Character]]) -> String {
    #function + " " + lines.joined(separator: "\n")
}

func day8Part2(_ lines: [[Character]]) -> String {
    #function + " " + lines.joined(separator: "\n")
}

func day9(_ lines: [[Character]]) -> String {
    #function + " " + lines.joined(separator: "\n")
}

func day9Part2(_ lines: [[Character]]) -> String {
    #function + " " + lines.joined(separator: "\n")
}

func day10(_ lines: [[Character]]) -> String {
    #function + " " + lines.joined(separator: "\n")
}

func day10Part2(_ lines: [[Character]]) -> String {
    #function + " " + lines.joined(separator: "\n")
}

func day11(_ lines: [[Character]]) -> String {
    #function + " " + lines.joined(separator: "\n")
}

func day11Part2(_ lines: [[Character]]) -> String {
    #function + " " + lines.joined(separator: "\n")
}

func day12(_ lines: [[Character]]) -> String {
    #function + " " + lines.joined(separator: "\n")
}

func day12Part2(_ lines: [[Character]]) -> String {
    #function + " " + lines.joined(separator: "\n")
}

func day13(_ lines: [[Character]]) -> String {
    #function + " " + lines.joined(separator: "\n")
}

func day13Part2(_ lines: [[Character]]) -> String {
    #function + " " + lines.joined(separator: "\n")
}

func day14(_ lines: [[Character]]) -> String {
    #function + " " + lines.joined(separator: "\n")
}

func day14Part2(_ lines: [[Character]]) -> String {
    #function + " " + lines.joined(separator: "\n")
}

func day15(_ lines: [[Character]]) -> String {
    #function + " " + lines.joined(separator: "\n")
}

func day15Part2(_ lines: [[Character]]) -> String {
    #function + " " + lines.joined(separator: "\n")
}

func day16(_ lines: [[Character]]) -> String {
    #function + " " + lines.joined(separator: "\n")
}

func day16Part2(_ lines: [[Character]]) -> String {
    #function + " " + lines.joined(separator: "\n")
}

func day17(_ lines: [[Character]]) -> String {
    #function + " " + lines.joined(separator: "\n")
}

func day17Part2(_ lines: [[Character]]) -> String {
    #function + " " + lines.joined(separator: "\n")
}

func day18(_ lines: [[Character]]) -> String {
    #function + " " + lines.joined(separator: "\n")
}

func day18Part2(_ lines: [[Character]]) -> String {
    #function + " " + lines.joined(separator: "\n")
}

func day19(_ lines: [[Character]]) -> String {
    #function + " " + lines.joined(separator: "\n")
}

func day19Part2(_ lines: [[Character]]) -> String {
    #function + " " + lines.joined(separator: "\n")
}

func day20(_ lines: [[Character]]) -> String {
    #function + " " + lines.joined(separator: "\n")
}

func day20Part2(_ lines: [[Character]]) -> String {
    #function + " " + lines.joined(separator: "\n")
}

func day21(_ lines: [[Character]]) -> String {
    #function + " " + lines.joined(separator: "\n")
}

func day21Part2(_ lines: [[Character]]) -> String {
    #function + " " + lines.joined(separator: "\n")
}

func day22(_ lines: [[Character]]) -> String {
    #function + " " + lines.joined(separator: "\n")
}

func day22Part2(_ lines: [[Character]]) -> String {
    #function + " " + lines.joined(separator: "\n")
}

func day23(_ lines: [[Character]]) -> String {
    #function + " " + lines.joined(separator: "\n")
}

func day23Part2(_ lines: [[Character]]) -> String {
    #function + " " + lines.joined(separator: "\n")
}

func day24(_ lines: [[Character]]) -> String {
    #function + " " + lines.joined(separator: "\n")
}

func day24Part2(_ lines: [[Character]]) -> String {
    #function + " " + lines.joined(separator: "\n")
}

func day25(_ lines: [[Character]]) -> String {
    #function + " " + lines.joined(separator: "\n")
}

func day25Part2(_ lines: [[Character]]) -> String {
    #function + " " + lines.joined(separator: "\n")
}

let funcs: [(([[Character]]) -> String, ([[Character]]) -> String)] = [
    (exampleDay, exampleDay),
    (exampleDay, exampleDay),
    (exampleDay, exampleDay),
    (day5, day5Part2),
    (day6, day6Part2),
    (day7, day7Part2),
    (day8, day8Part2),
    (day9, day9Part2),
    (day10, day10Part2),
    (day11, day11Part2),
    (day12, day12Part2),
    (day13, day13Part2),
    (day14, day14Part2),
    (day15, day15Part2),
    (day16, day16Part2),
    (day17, day17Part2),
    (day18, day18Part2),
    (day19, day19Part2),
    (day20, day20Part2),
    (day21, day21Part2),
    (day22, day22Part2),
    (day23, day23Part2),
    (day24, day24Part2),
    (day25, day25Part2),
]

//let workingDirectory = "/Users/trevorschmidt/Documents/Leetcode/AdventOfCode/AdventOfCode24"
let workingDirectory = "/Users/trevorschmidt/Documents/Leetcode/AdventOfCode/AdventOfCode24/Sources/AdventOfCode24/"
let inputsDirectory = workingDirectory + "Inputs/"

private func getLines(of fileName: String) throws -> [String] {
    let file = inputsDirectory + fileName
    let path = URL(fileURLWithPath: file)
    let fileContents = try String(contentsOf: path)
    return fileContents.components(separatedBy: .newlines)
}

private func matches(for regex: String, in text: String) -> [String] {
    do {
        let regex = try NSRegularExpression(pattern: regex)
        let results = regex.matches(in: text,
                                    range: NSRange(text.startIndex..., in: text))
        return results.map {
            String(text[Range($0.range, in: text)!])
        }
    } catch let error {
        print("invalid regex: \(error.localizedDescription)")
        return []
    }
}

var isTest: Bool = false
var isPart1 = false
let userArguments = Array(CommandLine.arguments.dropFirst())
for argument in userArguments {
    if argument == "isTest" {
        isTest = true
    }
    if argument == "isPart1" {
        isPart1 = true
    }
}
let day = Calendar.current.dateComponents([.day], from: .now).day ?? 0
let linesOfTheDay: [[Character]] = try getLines(of: "day\(day + 1)\(isTest ? "Test" : "").txt").map{ Array($0) }
let dayFuncIndex = day - 1
let funcOfTheDay = funcs[dayFuncIndex]
let funcToRun = isPart1 ? funcOfTheDay.0 : funcOfTheDay.1

print(funcToRun(linesOfTheDay))

