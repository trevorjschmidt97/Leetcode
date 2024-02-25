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
let fileName = arguments.count > 1 && arguments[1] == "x" ? "day7InputExample.txt" : "day7Input.txt"
let filePath = FileManager.default.currentDirectoryPath.appending("/\(fileName)")
var lines = readTextFile(filePath: filePath)!

enum Rank: Int {
    case fiveOfAKind
    case fourOfAKind
    case fullHouse
    case threeOfAKind
    case twoPair
    case onePair
    case highCard
}

struct Hand: Comparable {
    var cards: [Character]
    var bid: Int

    static let cardToIndex: [Character: Int] = [
        "A": 0,
        "K": 1,
        "Q": 2,
        // "J": 4,
        "T": 3,
        "9": 4,
        "8": 5, 
        "7": 6,
        "6": 7,
        "5": 8,
        "4": 9,
        "3": 10,
        "2": 11,
        "J": 12,
    ]

    var rank: Rank {
        var cardCounts = Array(repeating: 0, count: Hand.cardToIndex.count)
        for card in cards {
            let index = Hand.cardToIndex[card, default: 0]
            cardCounts[index] += 1
        }
        let jokerCount = cardCounts.last!
        let sortedCardCounts = Array(cardCounts.dropLast().sorted().reversed())

        if sortedCardCounts[0] + jokerCount == 5 { return .fiveOfAKind }
        if sortedCardCounts[0] + jokerCount == 4 { return .fourOfAKind }
        if sortedCardCounts[0] + jokerCount == 3 && sortedCardCounts[1] + jokerCount - (3 - sortedCardCounts[0]) == 2 { return .fullHouse }
        if sortedCardCounts[0] + jokerCount == 3 { return .threeOfAKind }
        if sortedCardCounts[0] + jokerCount == 2 && sortedCardCounts[1] - jokerCount - (2 - sortedCardCounts[0]) == 2 { return .twoPair }
        if sortedCardCounts[0] + jokerCount == 2 { return .onePair }
        return .highCard
    }

    static func < (lhs: Self, rhs: Self) -> Bool {
        if rhs.rank.rawValue != lhs.rank.rawValue {
            return rhs.rank.rawValue < lhs.rank.rawValue
        }
        for i in 0..<lhs.cards.count {
            let lCardIndex = Hand.cardToIndex[lhs.cards[i], default: 0]
            let rCardIndex = Hand.cardToIndex[rhs.cards[i], default: 0]
            if lCardIndex == rCardIndex { continue }
            return rCardIndex < lCardIndex
        }
        return true
    }
}

var hands = lines.map { Hand(cards: $0.split(separator: " ")[0].map{ Character("\($0)") }, bid: Int($0.split(separator: " ")[1])!) }

print(hands.sorted().enumerated().map { ($0 + 1) * $1.bid }.reduce(0, +))
// for (i, hand) in hands.sorted().enumerated() {

//     var cardCounts = Array(repeating: 0, count: Hand.cardToIndex.count)
//     for card in hand.cards {
//         let index = Hand.cardToIndex[card, default: 0]
//         cardCounts[index] += 1
//     }
//     let jokerCount = cardCounts.last!
//     let sortedCardCounts = cardCounts.dropLast().sorted()
//     print(i, hand.cards, sortedCardCounts, hand.rank.rawValue)
// }
