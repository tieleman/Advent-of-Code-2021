#!/usr/bin/swift sh
import Foundation

func findOxygenRating(_ report: [String]) -> Int {
    var mutableCopy = report.map({ Array($0) })
    var position = 0
    
    while mutableCopy.count > 1 && position < mutableCopy.first!.count {
        let binaryCode = mutableCopy.map({ $0[position] })
        let zeroCount = binaryCode.filter({ $0 == "0" }).count
        let oneCount = binaryCode.filter({ $0 == "1" }).count
        
        if oneCount >= zeroCount {
            mutableCopy = mutableCopy.filter({ $0[position] == "1" })
        } else {
            mutableCopy = mutableCopy.filter({ $0[position] == "0" })
        }
        
        position += 1
    }
    
    return Int(mutableCopy.first!.map({ String($0) }).joined(), radix: 2)!
}

func findScrubberRating(_ report: [String]) -> Int {
    var mutableCopy = report.map({ Array($0) })
    var position = 0
    
    while mutableCopy.count > 1 && position < mutableCopy.first!.count {
        let binaryCode = mutableCopy.map({ $0[position] })
        let zeroCount = binaryCode.filter({ $0 == "0" }).count
        let oneCount = binaryCode.filter({ $0 == "1" }).count
        
        if oneCount >= zeroCount {
            mutableCopy = mutableCopy.filter({ $0[position] == "0" })
        } else {
            mutableCopy = mutableCopy.filter({ $0[position] == "1" })
        }
        
        position += 1
    }
    
    return Int(mutableCopy.first!.map({ String($0) }).joined(), radix: 2)!
}

let diagnosticReport = try! String(contentsOfFile: "input.txt")
    .components(separatedBy: .newlines)
    .filter({ !$0.isEmpty })

print(findOxygenRating(diagnosticReport) * findScrubberRating(diagnosticReport))
