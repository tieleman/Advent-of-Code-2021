#!/usr/bin/swift sh
import Foundation

struct Point: Hashable {
    let x: Int
    let y: Int
}

func growBasin(from origin: Point, currentSet: Set<Point>?=nil) -> Set<Point> {
    let x = origin.x
    let y = origin.y
    var activeSet = currentSet ?? Set<Point>()
    
    guard entries[y][x] != "9" && !activeSet.contains(origin) else { return activeSet }

    activeSet.insert(origin)
    
    var candidates = [Point]()
    
    // top
    if y > 0                    { candidates.append(Point(x: x, y: y-1)) }
    // bottom
    if y < entries.count - 1    { candidates.append(Point(x: x, y: y+1)) }
    // left
    if x > 0                    { candidates.append(Point(x: x-1, y: y)) }
    // right
    if x < entries[y].count - 1 { candidates.append(Point(x: x+1, y: y)) }

    candidates.forEach { point in
        activeSet = activeSet.union(growBasin(from: point, currentSet: activeSet))
    }
    
    return activeSet
}

let entries = try! String(contentsOfFile: "input.txt")
    .components(separatedBy: .newlines)
    .map({ Array($0) })

var basins = [Set<Point>]()

for y in (0..<entries.count) {
    for x in (0..<entries[y].count) {
        let point = Point(x: x, y: y)
        let value = entries[y][x]

        if value != "9" && basins.allSatisfy({ !$0.contains(point) }) {
            basins.append(growBasin(from: point))
        }
    }
}

let count = basins.map({ $0.count }).sorted(by: >)[0..<3].reduce(1, *)

print(count)
