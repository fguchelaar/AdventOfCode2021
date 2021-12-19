import AdventKit
import Algorithms
import Foundation

extension String {
    func matches(pattern: String) -> [String] {
        let regex = try! NSRegularExpression(pattern: pattern)
        let range = NSRange(startIndex..., in: self)
        let matches = regex.matches(in: self, range: range)
        return matches.map { String(self[Range($0.range, in: self)!]) }
    }

    func ranges(pattern: String) -> [Range<String.Index>] {
        let regex = try! NSRegularExpression(pattern: pattern)
        let range = NSRange(startIndex..., in: self)
        let matches = regex.matches(in: self, range: range)
        return matches.map { Range($0.range, in: self)! }
    }
}

public class Puzzle {
    let input: [String]
    public init(input: String) {
        self.input = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
    }

    public func part1() -> Int {
        var sum = input[0]
        for i in 1 ..< input.count {
            sum = reduce(sum: "[\(sum),\(input[i])]")
        }
        return magnitude(of: sum)
    }

    public func part2() -> Int {
        return input
            .combinations(ofCount: 2)
            .reduce(Int.min) { current, numbers in
                let sumA = reduce(sum: "[\(numbers[0]),\(numbers[1])]")
                let sumB = reduce(sum: "[\(numbers[1]),\(numbers[0])]")
                return max(current, magnitude(of: sumA), magnitude(of: sumB))
            }
    }

    func reduce(sum: String) -> String {
        var sum = sum
        var keepGoing = false
        repeat {
            keepGoing = false

            if let explode = findExplodeIndex(in: sum) {
                keepGoing = true
                let pair = String(sum[explode])
                let lr = getInts(from: pair)

                // TODO: only look right
                // is there a right digit to add to?
                let rightNumbers = sum.ranges(pattern: #"\d+"#)
                if let right = rightNumbers.first(where: { sum.distance(from: $0.lowerBound, to: explode.upperBound) < 0 }) {
                    let r = Int(sum[right])! + lr.right
                    sum.replaceSubrange(right, with: "\(r)")
                }

                sum.replaceSubrange(explode, with: "0")

                let leftNumbers = String(sum[sum.startIndex ..< explode.lowerBound])
                    .ranges(pattern: #"\d+"#)
                
                if let left = leftNumbers.last { // }(where: { sum.distance(from: $0.lowerBound, to: explode.lowerBound) > 0 }) {
                    let l = Int(sum[left])! + lr.left
                    sum.replaceSubrange(left, with: "\(l)")
                }
            } else if let split = findSplitRange(in: sum) {
                keepGoing = true
                let int = Int(sum[split])!
                let left = int / 2
                let right = (int + 1) / 2
                let replacement = "[\(left),\(right)]"
                sum.replaceSubrange(split, with: replacement)
            }

        } while keepGoing
        return sum
    }

    func findExplodeIndex(in number: String) -> Range<String.Index>? {
        var depth = 0

        var index = number.startIndex

        while index != number.endIndex {
            if number[index] == "[" {
                depth += 1
            } else if number[index] == "]" {
                depth -= 1
            } else if depth > 4 {
                // check if we've landed on a pair.

                let nextOpen = number[index...].range(of: "[")
                let nextClose = number[index...].range(of: "]")

                if nextOpen == nil || number.distance(from: nextOpen!.lowerBound, to: nextClose!.lowerBound) < 0 {
                    let begin = number.index(before: index)
                    let end = nextClose!.upperBound
                    return begin ..< end
                }
            }

            index = number.index(after: index)
        }
        return nil
    }

    func findSplitRange(in number: String) -> Range<String.Index>? {
        let regularNumber = number.matches(pattern: #"\d{2,}"#)
        if regularNumber.count > 0 {
            return number.range(of: regularNumber[0])
        }
        return nil
    }

    func magnitude(of number: String) -> Int {
        var number = number
        var pairs = number.matches(pattern: #"\[\d+,\d+]"#)
        while pairs.count > 0 {
            for pair in pairs {
                let lr = getInts(from: pair)
                let mag = lr.left * 3 + lr.right * 2
                number = number
                    .replacingOccurrences(of: pair, with: "\(mag)")
            }
            pairs = number.matches(pattern: #"\[\d+,\d+]"#)
        }
        return Int(number)!
    }

    func getInts(from pair: String) -> (left: Int, right: Int) {
        let l = Int(pair.split(separator: ",")[0].dropFirst())!
        let r = Int(pair.split(separator: ",")[1].dropLast())!
        return (l, r)
    }
}
