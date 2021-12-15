#!/usr/bin/swift sh
import Foundation

struct Point: Equatable, Hashable {
    let x: Int
    let y: Int
    
    static let start = Point(x: 0, y: 0)
}

func growGrid(_ input: [[Int]]) -> [[Int]] {
    var newGrid = [[Int]](repeating: [Int](repeating: 0, count: input[0].count * 5), count: input.count * 5)
    for y in (0..<5) {
        for x in (0..<5) {
            for y1 in (0..<input.count) {
                for x1 in (0..<input[0].count) {
                    let currY = y1 + input.count * y
                    let currX = x1 + input[y1].count * x
                    let newValue = input[y1][x1] + y + x
                    let wrappedValue = newValue > 9 ? newValue - 9 : newValue
                    newGrid[currY][currX] = wrappedValue
                }
            }
        }
    }
    return newGrid
}

let smallGrid = try! String(contentsOfFile: "input.txt")
    .components(separatedBy: .newlines)
    .map { line -> [Int] in
        let arr = Array(line)
        return arr.map({ Int(String($0))! })
    }

let grid = growGrid(smallGrid)
var edgeList = [Point: [Point]]()

for y in (0..<grid.count) {
    for x in (0..<grid[y].count) {
        let point = Point(x: x, y: y)
        // top
        if y > 0                 { edgeList[point, default: []].append(Point(x: x, y: y-1)) }
        // right
        if x < grid[y].count - 1 { edgeList[point, default: []].append(Point(x: x+1, y: y)) }
        // bottom
        if y < grid.count - 1    { edgeList[point, default: []].append(Point(x: x, y: y+1)) }
        // left
        if x > 0                 { edgeList[point, default: []].append(Point(x: x-1, y: y)) }
    }
}

var unvisitedCost = [Point: Int]()
var visitedCost = [Point: Int]()

var found = false
var currentPoint = Point.start

unvisitedCost[currentPoint] = 0

while !found {
    let currentCost = unvisitedCost[currentPoint]!
    let neighbors = edgeList[currentPoint, default: []]
    
    neighbors.forEach { point in
        if visitedCost[point] == nil {
            let found = unvisitedCost[point, default: .max]
            let additionalCost = grid[point.y][point.x]
            if found > currentCost + additionalCost {
                unvisitedCost[point] = currentCost + additionalCost
            }
        }
    }
    
    visitedCost[currentPoint] = currentCost
    unvisitedCost.removeValue(forKey: currentPoint)
    
    if currentPoint == Point(x: grid[0].count - 1, y: grid.count - 1) {
        print(currentCost)
        found = true
    } else {
        // select new one
        currentPoint = unvisitedCost
            .min(by: { lhs, rhs in lhs.value < rhs.value })!
            .key
    }
}
