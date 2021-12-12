#!/usr/bin/swift sh
import Foundation

struct Connection {
    let from: Cave
    let to: Cave
}

struct Cave: Equatable {
    let name: String
    
    var canBeRevisitted: Bool {
        name.uppercased() == name
    }
    
    static var start: Cave = Cave(name: "start")
    static var end: Cave   = Cave(name: "end")
    
    func connectedCaves(_ connections: [Connection]) -> [Cave] {
        connections.filter({ $0.from == self || $0.to == self })
            .flatMap({ [$0.to, $0.from] })
            .filter({ $0 != self })
    }
}

typealias Route = [Cave]

func generateAllRoutes(from connections: [Connection]) {
    var visited = [Cave]()
    
    visited.append(Cave.start)

    generateRoute(from: connections, visited: visited)
}

func generateRoute(from connections: [Connection], visited: [Cave]) {
    var localVisited = visited
    
    if localVisited.last! == Cave.end {
        routes.append(localVisited)
        return
    }
    
    visited.last!.connectedCaves(connections).forEach { cave in
        if (!visited.contains(cave) || cave.canBeRevisitted) {
            localVisited.append(cave)
            generateRoute(from: connections, visited: localVisited)
            localVisited.popLast()
        }
    }
}

let connections = try! String(contentsOfFile: "input.txt")
    .components(separatedBy: .newlines)
    .map { line -> Connection in
        let components = line.components(separatedBy: "-")
        return Connection(from: Cave(name: components[0]), to: Cave(name: components[1]))
    }

var routes = [Route]()

generateAllRoutes(from: connections)

print(routes.count)
