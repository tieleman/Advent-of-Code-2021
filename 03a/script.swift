#!/usr/bin/swift sh
import Foundation

let diagnosticReport = try! String(contentsOfFile: "input.txt")
    .components(separatedBy: .newlines)
    .filter({ !$0.isEmpty })

var epsilonRate = [String]()
var gammaRate = [String]()

for position in (0..<diagnosticReport.first!.count) {
    let binaryCode = diagnosticReport.map({ Array($0)[position] })
    
    let zeroCount = binaryCode.filter({ $0 == "0" }).count
    let oneCount = binaryCode.filter({ $0 == "1" }).count
    
    if zeroCount > oneCount {
        gammaRate.append("0")
        epsilonRate.append("1")
    } else {
        gammaRate.append("1")
        epsilonRate.append("0")
    }
}

let convertedEpsilonRate = Int(epsilonRate.joined(), radix: 2)!
let convertedGammaRate = Int(gammaRate.joined(), radix: 2)!

print(convertedGammaRate * convertedEpsilonRate)
