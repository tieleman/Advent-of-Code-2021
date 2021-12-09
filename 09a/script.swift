#!/usr/bin/swift sh
import Foundation

func isRiskPoint(x: Int, y: Int, given entries: [[Int]]) -> Bool {
    let value = entries[y][x]
    
    let top = y > 0 ? entries[y-1][x] : Int.max
    let bottom = y < entries.count - 1 ? entries[y+1][x] : Int.max
    let left = x > 0 ? entries[y][x-1] : Int.max
    let right = x < entries[y].count - 1 ? entries[y][x+1] : Int.max
    
    return value < top && value < bottom && value < left && value < right
}

let entries = try! String(contentsOfFile: "input.txt")
    .components(separatedBy: .newlines)
    .map { contents -> [Int] in
        let strings = Array(contents)
        return strings.map({ Int(String($0))! })
    }

var totalRisk = 0

for y in (0..<entries.count) {
    for x in (0..<entries[y].count) {
        if isRiskPoint(x: x, y: y, given: entries) {
            totalRisk += (1 + entries[y][x])
        }
    }
}

print(totalRisk)
