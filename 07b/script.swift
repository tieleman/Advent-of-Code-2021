#!/usr/bin/swift sh
import Foundation

let positions = try! String(contentsOfFile: "input.txt")
    .components(separatedBy: ",")
    .compactMap({ Int($0) })

let targetPosition = positions.reduce(0, +) / positions.count

let fuel = positions
    .map({ (1..<(abs($0 - targetPosition)+1)).reduce(0,+) })
    .reduce(0, +)

print(fuel)
