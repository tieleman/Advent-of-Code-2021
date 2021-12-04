#!/usr/bin/swift sh
import Foundation

typealias Card = [[Int]]

extension Collection where Self.Iterator.Element: RandomAccessCollection {
    func transposed() -> [[Self.Iterator.Element.Iterator.Element]] {
        guard let firstRow = self.first else { return [] }
        return firstRow.indices.map { index in
            self.map{ $0[index] }
        }
    }
}
func isWinner(_ card: Card) -> Bool {
    return (card + card.transposed()).filter { setOfNumbers in
        setOfNumbers.allSatisfy({ drawnNumbers.contains($0) })
    }.count > 0
}

let bingoData = try! String(contentsOfFile: "input.txt")
    .components(separatedBy: "\n\n")

var drawOrder = Array(bingoData[0].split(separator: ",").compactMap({ Int($0) }).reversed())

let cards : [Card] = bingoData[1..<bingoData.count].map { card in
    let lines = card.components(separatedBy: .newlines)
    let card : Card = lines.map { row in
        row.components(separatedBy: .whitespaces).compactMap({ Int($0) })
    }
    return card
}

var drawnNumbers = [Int]()
var winner : Card? = nil

while winner == nil, let next = drawOrder.popLast() {
    // perform bingo
    drawnNumbers.append(next)
    winner = cards.first(where: { isWinner($0) })
}

if let winner = winner {
    var numbers = winner.flatMap({ $0 }).filter({ !drawnNumbers.contains($0) })
    print(numbers.reduce(0, +) * drawnNumbers.last!)
}

