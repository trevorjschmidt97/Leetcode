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
let fileName = arguments.count > 1 && arguments[1] == "x" ? "day5InputExample.txt" : "day5Input.txt"
let filePath = FileManager.default.currentDirectoryPath.appending("/\(fileName)")
var lines = readTextFile(filePath: filePath)!

let seedsInput = lines[0].split(separator: ":")[1].split(separator: " ").map { Int($0)! }

let seedToSoilIndex = lines.firstIndex{ $0 == "seed-to-soil map:" }!
let soilToFertilizerIndex = lines.firstIndex{ $0 == "soil-to-fertilizer map:" }!
let fertilizerToWaterIndex = lines.firstIndex{ $0 == "fertilizer-to-water map:" }!
let waterToLightIndex = lines.firstIndex{ $0 == "water-to-light map:" }!
let lightToTemperatureIndex = lines.firstIndex{ $0 == "light-to-temperature map:" }!
let temperatureToHumidityIndex = lines.firstIndex{ $0 == "temperature-to-humidity map:" }!
let humidityToLocationIndex = lines.firstIndex{ $0 == "humidity-to-location map:" }!

let seedToSoilMap = lines[seedToSoilIndex + 1..<soilToFertilizerIndex].map{ $0.split(separator: " ").map { Int($0)! } }
let soilToFertilizerMap = lines[soilToFertilizerIndex + 1..<fertilizerToWaterIndex].map{ $0.split(separator: " ").map { Int($0)! } }
let fertilizerToWaterMap = lines[fertilizerToWaterIndex + 1..<waterToLightIndex].map{ $0.split(separator: " ").map { Int($0)! } }
let waterToLightMap = lines[waterToLightIndex + 1..<lightToTemperatureIndex].map{ $0.split(separator: " ").map { Int($0)! } }
let lightToTemperatureMap = lines[lightToTemperatureIndex + 1..<temperatureToHumidityIndex].map{ $0.split(separator: " ").map { Int($0)! } }
let temperatureToHumidityMap = lines[temperatureToHumidityIndex + 1..<humidityToLocationIndex].map{ $0.split(separator: " ").map { Int($0)! } }
let humidityToLocationMap = lines[humidityToLocationIndex + 1..<lines.endIndex].map{ $0.split(separator: " ").map { Int($0)! } }

let allMaps = [
    seedToSoilMap,
    soilToFertilizerMap,
    fertilizerToWaterMap,
    waterToLightMap,
    lightToTemperatureMap,
    temperatureToHumidityMap,
    humidityToLocationMap,
].reversed()

print(seedsInput)

var i = 46
outer:
while true {
    var currentNum = i

    for map in allMaps {
        // print(currentNum, terminator: ", ")
        inner:
        for thing in map {
            let source = thing[1]
            let destination = thing[0]
            let range = thing[2]
            let prevNum = currentNum + source - destination

            if source <= prevNum && prevNum < source + range {
                currentNum = prevNum
                break inner
            }
        }
    }


    var j = 0
    while j < seedsInput.count {
        if seedsInput[j] <= currentNum && currentNum <= seedsInput[j] + seedsInput[j + 1] {
            print(i, currentNum)
            break outer
        }
        j += 2
    }

    i += 1

    // if i > 50 {
        // break
    // }
}

// var lowestLocation = Int.max

// for seed in seeds {
//     var currentNum = seed
//     // start with seed 79

//     for map in allMaps {
//         let map = map.sorted{ $0[1] > $1[1] }
//         print(currentNum, terminator: ", ")
//         // Check it on seed to soil
//         inner:
//         for seedToSoil in map {
//             let source = seedToSoil[1]
//             let destination = seedToSoil[0]
//             let range = seedToSoil[2]

//             if source <= currentNum && currentNum < source + range {
//                 currentNum = currentNum - source + destination
//                 break inner
//             }
//         }
//     }
//     print(currentNum)
//     lowestLocation = min(lowestLocation, currentNum)
// }

// print("lowest", lowestLocation)