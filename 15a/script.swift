#!/usr/bin/swift sh
import Foundation

let grid = try! String(contentsOfFile: "input.txt")
    .components(separatedBy: .newlines)
    .map { line -> [Int] in
        let arr = Array(line)
        return arr.map({ Int(String($0))! })
    }

var cost : [[Int]] = [[Int]](repeating: [Int](repeating: 0, count: grid[0].count), count: grid.count)

for y in 0..<grid.count {
    for x in 0..<grid[y].count {
        if x == 0, y == 0 { continue }
        if y == 0 {
            cost[y][x] = cost[y][x-1] + grid[y][x]
            continue
        }
        if x == 0 {
            cost[y][x] = cost[y-1][x] + grid[y][x]
            continue
        }
        
        cost[y][x] = min(cost[y][x-1] + grid[y][x], cost[y-1][x] + grid[y][x])
    }
}

print(cost[grid.count - 1][grid[0].count - 1])
