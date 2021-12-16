import AdventKit
import Foundation

public class Puzzle {
    let packet: Packet

    public init(input: String) {
        var bitString = input
            .compactMap { Int("\($0)", radix: 16) }
            .map { ("000" + String($0, radix: 2)).suffix(4) }
            .joined()
        packet = Packet.parse(from: &bitString)
    }

    public func part1() -> Int {
        packet.sumOfVersion()
    }

    public func part2() -> Int {
        packet.calculateValue()
    }
}
