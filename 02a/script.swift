#!/usr/bin/swift sh
import Foundation

enum SubmarineCommand {
    case forward(Int)
    case down(Int)
    case up(Int)
    
    init?(_ rawCommand: String) {
        let components = rawCommand.components(separatedBy: .whitespaces)
        let submarineCommand = components[0]
        
        guard let distance = Int(components[1]) else { return nil }

        switch submarineCommand {
        case "forward": self = .forward(distance)
        case "down": self = .down(distance)
        case "up": self = .up(distance)
        default: return nil
        }
    }
    
    func execute(_ current: SubmarinePosition) -> SubmarinePosition {
        switch self {
        case .forward(let distance):
            return .init(depth: current.depth, xPos: current.xPos + distance)
        case .down(let distance):
            return .init(depth: current.depth + distance, xPos: current.xPos)
        case .up(let distance):
            return .init(depth: current.depth - distance, xPos: current.xPos)
        }
    }
}

struct SubmarinePosition {
    let depth: Int
    let xPos: Int
    
    static let startingPoint = SubmarinePosition(depth: 0, xPos: 0)
}

let finalPosition = try! String(contentsOfFile: "input.txt")
    .components(separatedBy: .newlines)
    .filter({ !$0.isEmpty })
    .compactMap({ SubmarineCommand($0) })
    .reduce(SubmarinePosition.startingPoint) { partial, next in next.execute(partial) }

print(finalPosition.depth * finalPosition.xPos)
