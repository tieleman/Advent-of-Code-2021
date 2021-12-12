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
        self.uppercased() == self
    }
    
    var connectedCaves: [Cave] {
        connections.filter({ $0.from == self || $0.to == self })
            .flatMap({ [$0.to, $0.from] })
            .filter({ $0 != self })
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
        if (!visited.contains(cave) || cave.canBeRevisitted) {
            localVisited.append(cave)
            generateRoute(visited: localVisited)
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

var routes = [Route]()

generateAllRoutes()

print(routes.count)
