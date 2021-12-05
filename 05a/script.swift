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
        if startPos.x != endPos.x {
            let upper = endPos.x > startPos.x ? endPos.x : startPos.x
            let lower = endPos.x > startPos.x ? startPos.x : endPos.x
            return (lower...upper).map({ Point(x: $0, y: startPos.y)})
        } else {
            let upper = endPos.y > startPos.y ? endPos.y : startPos.y
            let lower = endPos.y > startPos.y ? startPos.y : endPos.y
            return (lower...upper).map({ Point(x: startPos.x, y: $0)})
        }
    }
    
    var differsOnBothDimensions: Bool {
        return startPos.x != endPos.x && startPos.y != endPos.y
    }
}

struct Point: Hashable {
    let x: Int
    let y: Int
}

var counts : [Point: Int] = [:]

try! String(contentsOfFile: "input.txt")
    .components(separatedBy: .newlines)
    .map({ VentLine($0) })
    .filter({ !$0.differsOnBothDimensions })
    .map({ $0.pointsInLine })
    .flatMap({ $0 })
    .forEach({ counts[$0, default: 0] += 1 })

let total = counts
    .filter({ $0.value > 1 })
    .count

print(total)
