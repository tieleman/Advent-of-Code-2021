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
    
    func calculateNextStep() -> Grid {
        var updatedGrid = map { line in
            line.map({ $0 + 1 })
        }
        
        while updatedGrid.containsFlashable() {
            for y in (0..<updatedGrid.count) {
                for x in (0..<updatedGrid[y].count) {
                    if updatedGrid[y][x] > 9 {
                        updatedGrid = updatedGrid.updateFlash(x: x, y: y)
                    }
                }
            }
        }
        
        return updatedGrid
    }
    
    func updateFlash(x: Int, y: Int) -> Grid {
        var grid = self
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
}

let octopi = try! String(contentsOfFile: "input.txt")
    .components(separatedBy: .newlines)
    .map { line -> [Int] in
        let array = Array(line)
        return array.map({ Int(String($0))! })
    }

var currentGrid = octopi
var i = 0

while !currentGrid.allZero() {
    currentGrid = currentGrid.calculateNextStep()
    i += 1
}

print(i)
