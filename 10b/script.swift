#!/usr/bin/swift sh
import Foundation

func median(_ collection: [Int]) -> Int {
    let sorted = collection.sorted()
    if collection.count.isMultiple(of: 2) {
        return (sorted[(collection.count / 2)] + sorted[(collection.count / 2) - 1]) / 2
    } else {
        return sorted[(collection.count-1) / 2]
    }
}

func findClosingSequence(_ entry: String) -> [Character]? {
    var characters : [Character] = Array(entry).reversed()
    var currentList = [Character]()
    
    while let next = characters.popLast() {
        switch next {
        case "(", "{", "[", "<": currentList.append(next)
        case ")": if currentList.last! == "(" { currentList.removeLast() } else { return nil }
        case "]": if currentList.last! == "[" { currentList.removeLast() } else { return nil }
        case "}": if currentList.last! == "{" { currentList.removeLast() } else { return nil }
        case ">": if currentList.last! == "<" { currentList.removeLast() } else { return nil }
        default: return nil
        }
    }
    
    if currentList.isEmpty {
        return nil
    } else {
        let closingSequence : [Character] = currentList.reversed().compactMap { char in
            switch char {
            case "(": return ")"
            case "[": return "]"
            case "{": return "}"
            case "<": return ">"
            default: return nil
            }
        }
        return closingSequence
    }
    return nil
}

let penalties : [Character: Int] = [
    ")": 1,
    "]": 2,
    "}": 3,
    ">": 4
]

let scores = try! String(contentsOfFile: "input.txt")
    .components(separatedBy: .newlines)
    .compactMap({ findClosingSequence($0) })
    .map({ closingSequence in
        Array(closingSequence).reduce(0) { partialResult, next in
            (partialResult * 5) + penalties[next]!
        }
    })

print(median(scores))
