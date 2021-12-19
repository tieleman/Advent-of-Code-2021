#!/usr/bin/swift sh
import Foundation

var input = try! String(contentsOfFile: "input.txt")
    .components(separatedBy: .whitespaces)
    .last!
    .components(separatedBy: "=")
    .last!
    .components(separatedBy: "..")
    .map({ Int($0)! })

print(input)

for initialV in (0..<1000) {
    var y = 0
    var v = initialV
    var positions = [Int]()
    
    while y >= input[0] {
        positions.append(y)
        y += v
        v -= 1
    }
    
    if positions.last! <= input[1] && positions.last! >= input[0] {
        print(initialV, positions.max()!)
    }
}
