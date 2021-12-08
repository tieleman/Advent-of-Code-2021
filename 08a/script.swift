#!/usr/bin/swift sh
import Foundation

let count = try! String(contentsOfFile: "input.txt")
    .components(separatedBy: .newlines)
    .map({ $0.components(separatedBy: " | ")[1] })
    .map({ $0.components(separatedBy: .whitespaces )})
    .flatMap({ $0 })
    .filter({ [2,3,4,7].contains($0.count) })
    .count

print(count)
