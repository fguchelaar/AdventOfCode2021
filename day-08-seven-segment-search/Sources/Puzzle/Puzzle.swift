import AdventKit
import Foundation

public class Puzzle {
    let input: [String]
    public init(input: String) {
        self.input = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
    }

    public func part1() -> Int {
        input.reduce(0) { sum, line in
            sum + line.split(separator: "|")[1]
                .split(separator: " ", omittingEmptySubsequences: true)
                .filter { $0.count == 2 || $0.count == 4 || $0.count == 3 || $0.count == 7 }
                .count
        }
    }

    public func part2() -> Int {
        var sum = 0
        for line in input {
            let parts = line.split(separator: "|")
            let patterns = parts[0].split(separator: " ", omittingEmptySubsequences: true).map(String.init)
            let map = deduce(patterns: patterns)
            let digits = Int(parts[1]
                .split(separator: " ", omittingEmptySubsequences: true)
                .map { Set($0) }
                .map { String(map[$0]!) }
                .joined())!
            sum += digits
        }
        return sum
    }

    func deduce(patterns: [String]) -> [Set<Character>: Int] {
        let _1 = Set(patterns.first { $0.count == 2 }!)
        let _4 = Set(patterns.first { $0.count == 4 }!)
        let _7 = Set(patterns.first { $0.count == 3 }!)
        let _8 = Set(patterns.first { $0.count == 7 }!)
        let _3 = Set(patterns.first { $0.count == 5 && Set($0).subtracting(_7).count == 2 }!)
        let _9 = Set(patterns.first { $0.count == 6 && Set($0).subtracting(_3).count == 1 }!)
        let _2 = Set(patterns.first { $0.count == 5 && Set($0).subtracting(_9).count == 1 }!)
        let _5 = Set(patterns.first { $0.count == 5 && Set($0).subtracting(_2).count == 2 }!)
        let _6 = Set(patterns.first { $0.count == 6 && Set($0).subtracting(_1).count == 5 }!)
        let _0 = Set(patterns.first { $0.count == 6 && Set($0).subtracting(_5).count == 2 }!)
     
        return [
            _0: 0,
            _1: 1,
            _2: 2,
            _3: 3,
            _4: 4,
            _5: 5,
            _6: 6,
            _7: 7,
            _8: 8,
            _9: 9,
        ]
    }
}
