#!/usr/bin/swift sh
import Foundation
import Algorithms // apple/swift-algorithms ~> 1.0.0

func updatePolymer(_ input: [String: Int]) -> [String: Int] {
    input.reduce(into: [:]) { partial, entry in
        guard let found = mapping[entry.key] else { fatalError("Mapping not found!") }
        
        let pair1 = entry.key.prefix(1).appending(found)
        let pair2 = found.appending(entry.key.suffix(1))
        
        partial[pair1, default: 0] += entry.value
        partial[pair2, default: 0] += entry.value
        
        characterCounts[found, default: 0] += entry.value
    }
}

let components = try! String(contentsOfFile: "input.txt")
    .components(separatedBy: "\n\n")

var pairCount : [String: Int] = components[0]
    .windows(ofCount: 2)
    .reduce(into: [:]) { partial, chunk in
        partial[String(chunk), default: 0] += 1
    }

let mapping : [String: String] = components[1]
    .components(separatedBy: .newlines)
    .reduce(into: [:]) { partial, line in
        let subcomponents = line.components(separatedBy: " -> ")
        return partial[subcomponents[0]] = subcomponents[1]
    }

var characterCounts : [String: Int] = Array(components[0])
    .reduce(into: [:]) { partial, next in
        partial[String(next), default: 0] += 1
    }

let output = (0..<40).reduce(pairCount) { partialResult, _ in
    updatePolymer(partialResult)
}

print(characterCounts.values.max()! - characterCounts.values.min()!)
