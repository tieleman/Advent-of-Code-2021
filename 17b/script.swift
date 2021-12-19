#!/usr/bin/swift sh
import Foundation

let input = try! String(contentsOfFile: "input.txt")

var targetY = input
    .components(separatedBy: .whitespaces)
    .last!
    .components(separatedBy: "=")
    .last!
    .components(separatedBy: "..")
    .map({ Int($0)! })

var targetX = input
    .components(separatedBy: .whitespaces)[2]
    .components(separatedBy: ",")[0]
    .components(separatedBy: "=")[1]
    .components(separatedBy: "..")
    .map({ Int($0)! })

var counter = 0

for initialY in (-500..<500) {
    for initialX in (0..<500) {
        var y = 0
        var x = 0
        var vy = initialY
        var vx = initialX

        var positions = [(Int, Int)]()

        while y >= targetY[0] && x <= targetX[1] {
            positions.append((x, y))

            x += vx
            y += vy

            vy -= 1
            vx = max(vx-1, 0)
        }

        if positions.last!.1 <= targetY[1] && positions.last!.1 >= targetY[0] &&
            positions.last!.0 >= targetX[0] && positions.last!.0 <= targetX[1] {
            counter += 1
        }
    }
}

print(counter)
