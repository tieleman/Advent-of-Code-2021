#!/usr/bin/swift sh
import Foundation

let positions = try! String(contentsOfFile: "input.txt")
    .components(separatedBy: ",")
    .compactMap({ Int($0) })

let targetPosition : Int = {
    let avg = Double(positions.reduce(0, +)) / Double(positions.count)
    if avg - trunc(avg) > 0.5 {
        return Int(ceil(avg))
    } else {
        return Int(floor(avg))
    }
}()

let fuel = positions
    .map({ (1..<(abs($0 - targetPosition)+1)).reduce(0,+) })
    .reduce(0, +)

print(fuel)
