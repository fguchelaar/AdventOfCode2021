import AdventKit
import Foundation

public class Puzzle {
    let numberOfBits: Int
    let report: [Int]

    public init(input: String) {
        let lines = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
        numberOfBits = lines[0].count
        report = lines.compactMap { Int($0, radix: 2) }
    }

    public func part1() -> Int {
        let count = report.count

        var gamma = 0
        var epsilon = 0

        for q in 0 ..< numberOfBits {
            let r = Int(pow(2.0, Double(q)))
            let numberOfOnes = report.reduce(0) { a, c in
                a + (c & r == r ? 1 : 0)
            }
            if numberOfOnes > count / 2 {
                gamma |= r
            } else {
                epsilon |= r
            }
        }

        return gamma * epsilon
    }

    public func part2() -> Int {
        findRating(in: report) * findRating(in: report, reversed: true)
    }

    private func findRating(in report: [Int], reversed: Bool = false) -> Int {
        var _report = report
        // make sure to start at the front!!!
        for q in (0 ..< numberOfBits).reversed() {
            let r = Int(pow(2.0, Double(q)))
            let numberOfOnes = _report.reduce(0) { a, c in
                a + (c & r == r ? 1 : 0)
            }

            if numberOfOnes >= _report.count - numberOfOnes {
                _report = _report.filter { $0 & r == (reversed ? 0 : r) }
            } else {
                _report = _report.filter { $0 & r == (reversed ? r : 0) }
            }

            if _report.count == 1 {
                return _report[0]
            }
        }
        fatalError()
    }
}
