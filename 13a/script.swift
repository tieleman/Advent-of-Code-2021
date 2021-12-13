#!/usr/bin/swift sh
import Foundation

struct Point: Equatable, Hashable {
    let x: Int
    let y: Int
}

func foldOverVertical(_ dots: Set<Point>, x: Int) -> Set<Point> {
    var localDots = dots
    let toBeFlipped = dots.filter({ $0.x > x })
    
    localDots = localDots.subtracting(toBeFlipped)
    
    toBeFlipped.forEach { dot in
        localDots.insert(Point(x: x - abs(dot.x - x), y: dot.y))
    }
    
    return localDots
}

let components = try! String(contentsOfFile: "input.txt")
    .components(separatedBy: "\n\n")

let dots = Set(
    components[0]
        .components(separatedBy: .newlines)
        .map { line -> Point in
            let coords = line.components(separatedBy: ",")
            return Point(x: Int(coords[0])!, y: Int(coords[1])!)
        }
    )

let newDots = foldOverVertical(dots, x: 655)

print(newDots.count)
