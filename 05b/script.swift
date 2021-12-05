#!/usr/bin/swift sh
import Foundation

struct VentLine {
    let startPos: Point
    let endPos: Point
    
    init(_ rawLine: String) {
        let components = rawLine.components(separatedBy: " -> ")
        
        let start = components[0].components(separatedBy: ",")
        let end = components[1].components(separatedBy: ",")
        
        startPos = Point(x: Int(start[0])!, y: Int(start[1])!)
        endPos = Point(x: Int(end[0])!, y: Int(end[1])!)
    }
    
    var pointsInLine: [Point] {
        let dx = (endPos.x - startPos.x).signum()
        let dy = (endPos.y - startPos.y).signum()

        return (0...maxDistance).map { i in
            Point(x: startPos.x + i * dx, y: startPos.y + i * dy)
        }
    }
    
    var maxDistance: Int {
        max(
            abs(endPos.x - startPos.x),
            abs(endPos.y - startPos.y)
        )
    }
}

struct Point: Hashable {
    let x: Int
    let y: Int
}

var counts : [Point: Int] = [:]

try! String(contentsOfFile: "input.txt")
    .components(separatedBy: .newlines)
    .map({ VentLine($0).pointsInLine })
    .flatMap({ $0 })
    .forEach({ counts[$0, default: 0] += 1 })

let total = counts
    .filter({ $0.value > 1 })
    .count

print(total)
