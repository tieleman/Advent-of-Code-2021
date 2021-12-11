#!/usr/bin/swift sh
import Foundation

typealias Grid = [[Int]]

extension Grid {
    func containsFlashable() -> Bool {
        flatMap({ $0 }).contains(where: { $0 > 9 })
    }
    
    func allZero() -> Bool {
        flatMap({ $0 }).allSatisfy({ $0 == 0 })
    }
}

func calculateNextStep(_ grid: Grid) -> Grid {
    var updatedGrid = grid.map { line in
        line.map({ $0 + 1 })
    }
    
    while updatedGrid.containsFlashable() {
        for y in (0..<updatedGrid.count) {
            for x in (0..<updatedGrid[y].count) {
                if updatedGrid[y][x] > 9 {
                    updatedGrid = updateFlash(x: x, y: y, grid: updatedGrid)
                }
            }
        }
    }
    
    return updatedGrid
}

func updateFlash(x: Int, y: Int, grid: Grid) -> Grid {
    var grid = grid
    grid[y][x] = 0
    
    // topleft
    if x > 0, y > 0, grid[y-1][x-1] != 0 { grid[y-1][x-1] += 1 }
    // top
    if y > 0, grid[y-1][x] != 0 { grid[y-1][x] += 1 }
    // topright
    if x < grid[y].count - 1, y > 0, grid[y-1][x+1] != 0 { grid[y-1][x+1] += 1 }
    // right
    if x < grid[y].count - 1, grid[y][x+1] != 0 { grid[y][x+1] += 1 }
    // bottomright
    if x < grid[y].count - 1, y < grid.count - 1, grid[y+1][x+1] != 0 { grid[y+1][x+1] += 1 }
    // bottom
    if y < grid.count - 1, grid[y+1][x] != 0 { grid[y+1][x] += 1 }
    // bottomleft
    if x > 0, y < grid.count - 1, grid[y+1][x-1] != 0 { grid[y+1][x-1] += 1 }
    // left
    if x > 0, grid[y][x-1] != 0 { grid[y][x-1] += 1 }

    return grid
}

let octopi = try! String(contentsOfFile: "input.txt")
    .components(separatedBy: .newlines)
    .map { line -> [Int] in
        let array = Array(line)
        return array.map({ Int(String($0))! })
    }

var currentGrid = octopi
var found = false
var i = 1

while !found {
    currentGrid = calculateNextStep(currentGrid)

    if currentGrid.allZero() {
        found = true
        print(i)
    }
              
    i += 1
}
