#!/usr/bin/swift sh
import Foundation

let positions = try! String(contentsOfFile: "input.txt")
    .components(separatedBy: ",")
    .compactMap({ Int($0) })

func median(_ collection: [Int]) -> Int {
    let sorted = collection.sorted()
    if collection.count.isMultiple(of: 2) {
        return (sorted[(collection.count / 2)] + sorted[(collection.count / 2) - 1]) / 2
    } else {
        return sorted[(collection.count-1) / 2]
    }
}

let targetPosition = median(positions)

let fuel = positions
    .map({ abs($0 - targetPosition)})
    .reduce(0, +)

print(fuel)
