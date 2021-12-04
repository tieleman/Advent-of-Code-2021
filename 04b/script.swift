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

extension Card {
    func isWinner(given drawnNumbers: [Int]) -> Bool {
        return (self + self.transposed()).filter { setOfNumbers in
            setOfNumbers.allSatisfy({ drawnNumbers.contains($0) })
        }.count > 0
    }
    
    func score(given drawnNumbers: [Int]) -> Int {
        let sum = self
                    .flatMap({ $0 })
                    .filter({ !drawnNumbers.contains($0) })
                    .reduce(0, +)
        
        return sum * drawnNumbers.last!
    }
}

let bingoData = try! String(contentsOfFile: "input.txt")
    .components(separatedBy: "\n\n")

var drawOrder = Array(bingoData[0].split(separator: ",").compactMap({ Int($0) }).reversed())

var cards : [Card] = bingoData[1..<bingoData.count].map { card in
    let lines = card.components(separatedBy: .newlines)
    let card : Card = lines.map { row in
        row.components(separatedBy: .whitespaces).compactMap({ Int($0) })
    }
    return card
}

var drawnNumbers = [Int]()
var cardsThatWon = [Card]()
var found = false

while cardsThatWon.count < cards.count, !found, let next = drawOrder.popLast() {
    // perform bingo
    drawnNumbers.append(next)

    for card in cards.filter({ !cardsThatWon.contains($0) && $0.isWinner(given: drawnNumbers) }) {
        if !cardsThatWon.contains(card) {
            cardsThatWon.append(card)
        } else {
            found = true
            break
        }
    }
}

if let winner = cardsThatWon.last {
    print(winner.score(given: drawnNumbers))
}

