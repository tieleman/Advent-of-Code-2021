#!/usr/bin/swift sh
import Foundation

func findBadCharacter(_ entry: String) -> Character? {
    var characters : [Character] = Array(entry).reversed()
    var currentList = [Character]()
    
    while let next = characters.popLast() {
        switch next {
        case "(", "{", "[", "<": currentList.append(next)
        case ")": if currentList.last! == "(" { currentList.removeLast() } else { return next }
        case "]": if currentList.last! == "[" { currentList.removeLast() } else { return next }
        case "}": if currentList.last! == "{" { currentList.removeLast() } else { return next }
        case ">": if currentList.last! == "<" { currentList.removeLast() } else { return next }
        default: return nil
        }
    }
    
    return nil
}

let penalties : [Character: Int] = [
    ")": 3,
    "]": 57,
    "}": 1197,
    ">": 25137
]

let score = try! String(contentsOfFile: "input.txt")
    .components(separatedBy: .newlines)
    .compactMap({ findBadCharacter($0) })
    .reduce(0, { partialScore, next in
        partialScore + penalties[next]!
    })

print(score)
