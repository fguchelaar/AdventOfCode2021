import AdventKit
import Foundation

public class Puzzle {
    let input: [Int]
    public init(input: String) {
        self.input = input.intArray
    }

    public func part1() -> Int {
        zip(input.dropFirst(), input)
            .filter { $0.0 > $0.1 }
            .count
    }

    public func part2() -> Int {
        zip(input.dropFirst(3), input)
            .filter { $0.0 > $0.1 }
            .count
    }
}
