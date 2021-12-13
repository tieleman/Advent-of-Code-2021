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

func foldOverHorizontal(_ dots: Set<Point>, y: Int) -> Set<Point> {
    var localDots = dots
    let toBeFlipped = dots.filter({ $0.y > y })
    
    localDots = localDots.subtracting(toBeFlipped)
    
    toBeFlipped.forEach { dot in
        localDots.insert(Point(x: dot.x, y: y - abs(dot.y - y)))
    }
    
    return localDots
}

func printDots(_ dots: Set<Point>) {
    let maxX = dots.map({ $0.x }).max()! + 1
    let maxY = dots.map({ $0.y }).max()! + 1
    
    var screen = [[String]](repeating: [String](repeating: " ", count: maxX), count: maxY)
    
    dots.forEach { dot in
        screen[dot.y][dot.x] = "#"
    }
    
    screen.forEach { line in
        print(line.joined(separator: ""))
    }
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

var currentDots = dots
components[1]
    .components(separatedBy: .newlines)
    .map({ String($0.dropFirst(11))})
    .forEach { rule in
        let ruleComponents = rule.components(separatedBy: "=")
        let axis = ruleComponents[0]
        let position = Int(ruleComponents[1])!
        
        if axis == "x" {
            currentDots = foldOverVertical(currentDots, x: position)
        } else {
            currentDots = foldOverHorizontal(currentDots, y: position)
        }
    }

printDots(currentDots)
