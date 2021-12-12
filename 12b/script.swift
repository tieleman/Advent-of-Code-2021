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
        connections.filter({ $0.from == self || $0.to == self })
            .flatMap({ [$0.to, $0.from] })
            .filter({ $0 != self })
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
        routes.append(localVisited)
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

let connections = try! String(contentsOfFile: "/Users/tieleman/Documents/Code/AoC/2021/12b/input.txt")
    .components(separatedBy: .newlines)
    .map { line -> Connection in
        let components = line.components(separatedBy: "-")
        return Connection(from: components[0], to: components[1])
    }

var routes = [Route]()
var visitedCount = [Cave: Int]()

generateAllRoutes()

print(routes.count)
