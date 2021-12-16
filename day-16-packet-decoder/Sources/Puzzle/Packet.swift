//
//  Packet.swift
//
//
//  Created by Frank Guchelaar on 16/12/2021.
//

import Foundation

extension String {
    mutating func readAndDrop(_ n: Int) -> String {
        let s = prefix(n)
        self = String(dropFirst(n))
        return String(s)
    }

    mutating func readIntAndDrop(_ n: Int) -> Int {
        Int(readAndDrop(n), radix: 2)!
    }
}

class Packet {
    let version: Int
    let type: Int

    init(_ version: Int, _ type: Int) {
        self.version = version
        self.type = type
    }

    var literalValue: Int?
    var subpackets: [Packet]?

    static func parse(from string: inout String) -> Packet {
        let version = string.readIntAndDrop(3)
        let type = string.readIntAndDrop(3)
        let packet = Packet(version, type)

        switch packet.type {
        case 4:
            packet.literalValue = packet.parseLiteralValues(&string)
        default:
            packet.subpackets = []
            // parse subpackets
            let lengthTypeID = string.readIntAndDrop(1)

            if lengthTypeID == 0 {
                let totalLengthInBits = string.readIntAndDrop(15)

                var childString = String(string.prefix(totalLengthInBits))
                string = String(string.dropFirst(totalLengthInBits))
                while !childString.isEmpty {
                    packet.subpackets?.append(Packet.parse(from: &childString))
                }
            } else {
                let numberOfSubPackets = string.readIntAndDrop(11)

                for _ in 0 ..< numberOfSubPackets {
                    packet.subpackets?.append(Packet.parse(from: &string))
                }
            }
        }
        return packet
    }

    func parseLiteralValues(_ string: inout String) -> Int {
        var result: [String] = []
        var bits = ""
        repeat {
            bits = string.readAndDrop(5)
            result.append(String(bits.dropFirst(1)))
        } while bits.first! != "0"

        return Int(result.joined(), radix: 2)!
    }

    func sumOfVersion() -> Int {
        return version + (subpackets?.reduce(0) { $0 + $1.sumOfVersion() } ?? 0)
    }

    func calculateValue() -> Int {
        switch type {
        case 0:
            return subpackets!.reduce(0) { $0 + $1.calculateValue() }
        case 1:
            return subpackets!.reduce(1) { $0 * $1.calculateValue() }
        case 2:
            return subpackets!.reduce(Int.max) { min($0, $1.calculateValue()) }
        case 3:
            return subpackets!.reduce(Int.min) { max($0, $1.calculateValue()) }
        case 4:
            return literalValue!
        case 5:
            return subpackets![0].calculateValue() > subpackets![1].calculateValue() ? 1 : 0
        case 6:
            return subpackets![0].calculateValue() < subpackets![1].calculateValue() ? 1 : 0
        case 7:
            return subpackets![0].calculateValue() == subpackets![1].calculateValue() ? 1 : 0
        default:
            fatalError()
        }
    }
}
