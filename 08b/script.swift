#!/usr/bin/swift sh
import Foundation

// 0: abc efg    *
// 1:   c  f     *
// 2: a cde g    *
// 3: a cd fg    *
// 4:  bcd f     *
// 5: ab d fg    *
// 6: ab defg    *
// 7: a c  f     *
// 8: abcdefg    *
// 9: abcd fg    *

func assign(digitSet: Set<Character>, to: Int, from input: inout [Set<Character>], into digitsMap: inout [Int: Set<Character>]) {
    digitsMap[to] = digitSet
    input.remove(at: input.firstIndex(of: digitsMap[to]!)!)
}

func decodeEntry(_ entry: String) -> Int {
    let components = entry.components(separatedBy: " | ")
    var input = components[0].components(separatedBy: .whitespaces).map({ Set($0) })
    let output = components[1].components(separatedBy: .whitespaces).map({ Set($0) })
    
    var digitsMap = [Int: Set<Character>]()
    
    assign(digitSet: input.first(where: { $0.count == 2 })!, to: 1, from: &input, into: &digitsMap)
    assign(digitSet: input.first(where: { $0.count == 3 })!, to: 7, from: &input, into: &digitsMap)
    assign(digitSet: input.first(where: { $0.count == 4 })!, to: 4, from: &input, into: &digitsMap)
    assign(digitSet: input.first(where: { $0.count == 7 })!, to: 8, from: &input, into: &digitsMap)
    assign(digitSet: input.first(where: { $0.count == 5 && digitsMap[1]!.isSubset(of: $0) })!, to: 3, from: &input, into: &digitsMap)
    assign(digitSet: input.first(where: { $0.count == 6 && digitsMap[4]!.isSubset(of: $0) })!, to: 9, from: &input, into: &digitsMap)
    assign(digitSet: input.first(where: { $0.count == 6 && digitsMap[1]!.isSubset(of: $0) })!, to: 0, from: &input, into: &digitsMap)
    assign(digitSet: input.first(where: { $0.count == 6 })!, to: 6, from: &input, into: &digitsMap)
    assign(digitSet: input.first(where: { $0.isSubset(of: digitsMap[6]!) })!, to: 5, from: &input, into: &digitsMap)
    assign(digitSet: input.first!, to: 2, from: &input, into: &digitsMap)

    let number = output.map { outputSet in
        let found = digitsMap.first { key, value in
            value == outputSet
        }
        return String(found!.key)
    }.joined(separator: "")
    
    return Int(number)!
}

let entries = try! String(contentsOfFile: "input.txt")
    .components(separatedBy: .newlines)

let sum = entries.map({ decodeEntry($0)}).reduce(0, +)

print(sum)
