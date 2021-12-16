#!/usr/bin/swift sh
import Foundation

extension String {
    func lpad(_ length: Int, character: Character) -> String {
        var local = self
        while local.count < length {
            local.insert(character, at: self.startIndex)
        }
        return local
    }
}

extension Collection where Element == Character {
    func toInt() -> Int {
        Int(self.map({ String($0) }).joined(), radix: 2)!
    }
    
    mutating func read(_ count: Int) -> [Element] {
        let result = Array(self.prefix(count))
        self = Array(self.dropFirst(count)) as! Self
        return result
    }
}

enum Packet {
    case literal(version: Int, type: Int, number: Int)
    indirect case `operator`(version: Int, type: Int, packets: [Packet])
    
    var versionSum: Int {
        switch self {
        case .literal(version: let version, type: _, number: _):
            return version
        case .operator(version: let version, type: _, packets: let packets):
            return version + packets.map({ $0.versionSum }).reduce(0, +)
        }
    }
}

func readNextPacket(from stream: inout [Character]) -> Packet {
    let version = stream.read(3).toInt()
    let type    = stream.read(3).toInt()
    
    switch type {
    case 4:
        var local = [Character]()
        var finished = false
        
        while !finished {
            if stream.read(1).first! == "0" {
                finished = true
            }
            local += stream.read(4)
        }
        return .literal(version: version, type: type, number: local.toInt())
    default:
        var packets = [Packet]()
        let lengthType = stream.read(1).first!

        switch lengthType {
        case "0":
            let packetLength = stream.read(15).toInt()

            var newStream = stream.read(packetLength)
            while newStream.count > 0 {
                packets.append(readNextPacket(from: &newStream))
            }
        default:
            let packetLength = stream.read(11).toInt()

            while packets.count < packetLength {
                packets.append(readNextPacket(from: &stream))
            }
        }

        return .operator(version: version, type: type, packets: packets)
    }
}

var stream = Array(try! String(contentsOfFile: "input.txt"))
    .flatMap({ Array(String(Int(String($0), radix: 16)!, radix: 2).lpad(4, character: "0")) })

let result = readNextPacket(from: &stream)

print(result.versionSum)
