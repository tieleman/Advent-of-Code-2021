#!/usr/bin/swift sh
import Foundation

typealias Cave = String
typealias Route = [Cave]

struct Connection {
    let from: Cave
    let to: Cave
}

extension Cave {
    var canBeRevisitted: Bool {
        if self == Cave.start || self == Cave.end { return false }
        
        if !isSmallCave {
            return true
        } else {
            return visitedCount.values.allSatisfy({ $0 < 2 })
        }
    }
    
    var connectedCaves: [Cave] {
        connections[self, default: []]
    }

    var isSmallCave: Bool {
        self.uppercased() != self
    }

    static var start: Cave = "start"
    static var end: Cave   = "end"
}

func generateAllRoutes() {
    var visited = Route()
    
    visited.append(Cave.start)

    generateRoute(visited: visited)
}

func generateRoute(visited: Route) {
    var localVisited = visited
    
    if localVisited.last! == Cave.end {
        routeCounter += 1
        return
    }
    
    visited.last!.connectedCaves.forEach { cave in
        if (cave.canBeRevisitted || !visited.contains(cave)) {
            if cave.isSmallCave { visitedCount[cave, default: 0] += 1 }
            localVisited.append(cave)
            generateRoute(visited: localVisited)
            if cave.isSmallCave { visitedCount[cave, default: 0] -= 1 }
            localVisited.popLast()
        }
    }
}

let connections = try! String(contentsOfFile: "input.txt")
    .components(separatedBy: .newlines)
    .map { line -> Connection in
        let components = line.components(separatedBy: "-")
        return Connection(from: components[0], to: components[1])
    }
    .reduce([Cave:[Cave]](), { partialResult, next in
        var local = partialResult
        local[next.from, default: []].append(next.to)
        local[next.to, default: []].append(next.from)
        return local
    })

var routeCounter = 0
var visitedCount = [Cave: Int]()

generateAllRoutes()

print(routeCounter)
