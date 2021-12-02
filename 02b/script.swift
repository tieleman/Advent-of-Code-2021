#!/usr/bin/swift sh
import Foundation

// Load lines from file
let data = try! String(contentsOfFile: "input.txt")

// Massage the data
let lines = data
    .components(separatedBy: .newlines)
    .filter({ !$0.isEmpty })

// Perform the route
var xPos = 0
var yPos = 0
var aim = 0

lines.forEach { instruction in
    let components = instruction.components(separatedBy: .whitespaces)
    let submarineCommand = components[0]
    let distance = Int(components[1])!
    
    switch submarineCommand {
    case "forward":
        xPos += distance
        yPos += aim * distance
    case "down":
        aim += distance
    case "up":
        aim -= distance
    default: fatalError("Unknown command")
    }
}

print(xPos * yPos)
