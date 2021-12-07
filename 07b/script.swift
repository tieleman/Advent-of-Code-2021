#!/usr/bin/swift sh
import Foundation

let positions = try! String(contentsOfFile: "input.txt")
    .components(separatedBy: ",")
    .compactMap({ Int($0) })

let result = (positions.min()!...positions.max()!).map { targetPosition in
    positions
        .map { position in
            let distance = abs(position - targetPosition)
            let fuel = (distance * (distance + 1)) / 2
            return fuel
        }
        .reduce(0, +)
}

print(result.min()!)
