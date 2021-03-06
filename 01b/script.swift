#!/usr/bin/swift sh
import Foundation
import Algorithms // apple/swift-algorithms ~> 1.0.0

// Load lines from file
let data = try! String(contentsOfFile: "input.txt")

// Massage the data
let lines = data
    .components(separatedBy: .newlines)
    .filter({ !$0.isEmpty })
    .compactMap({ Int($0) })
    .windows(ofCount: 3)
    .map({ $0.reduce(0, +) })

// Perform the count
let count = lines.adjacentPairs().reduce(0) { partialResult, tuple in
    if tuple.1 > tuple.0 {
        return partialResult + 1
    }
    return partialResult
}

print(count)
