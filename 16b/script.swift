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
    
    var value: Int {
        switch self {
        case .literal(version: _, type: _, number: let number):
            return number
        case .operator(version: _, type: let type, packets: let packets):
            switch type {
            case 0:
                return packets.map({ $0.value }).reduce(0, +)
            case 1:
                return packets.map({ $0.value }).reduce(1, *)
            case 2:
                return packets.map({ $0.value }).min()!
            case 3:
                return packets.map({ $0.value }).max()!
            case 5:
                return packets[0].value > packets[1].value ? 1 : 0
            case 6:
                return packets[0].value < packets[1].value ? 1 : 0
            case 7:
                return packets[0].value == packets[1].value ? 1 : 0
            default: fatalError("Unknown packet type")
            }
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

print(result.value)
