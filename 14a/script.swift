#!/usr/bin/swift sh
import Foundation
import Algorithms // apple/swift-algorithms ~> 1.0.0

func updatePolymer(_ input: String, mapping: [String: String]) -> String {
    var local = ""
    let items = input.adjacentPairs()
    items.enumerated().forEach { enumerated in
        let pair = enumerated.element
        let index = enumerated.offset
        
        guard let found = mapping[String(pair.0) + String(pair.1)] else {
            fatalError("Mapping not found")
        }
        
        local += String(pair.0) + found
        
        if index == items.count - 1 {
            local += String(pair.1)
        }
    }
    
    return local
}

let components = try! String(contentsOfFile: "input.txt")
    .components(separatedBy: "\n\n")

let input = components[0]
let mapping : [String: String] = components[1]
    .components(separatedBy: .newlines)
    .reduce(into: [:]) { partial, next in
        let subcomponents = next.components(separatedBy: " -> ")
        return partial[subcomponents[0]] = subcomponents[1]
    }

let output = (0..<10).reduce(input) { partialResult, _ in
    updatePolymer(partialResult, mapping: mapping)
}

let countedSet = NSCountedSet(array: Array(output))
let values = countedSet.map { key in
    countedSet.count(for: key)
}

print(values.max()! - values.min()!)
