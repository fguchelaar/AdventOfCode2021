import AdventKit
import CoreVideo
import Foundation

public class Puzzle {
    let score: [Character: Int] = [
        ")": 3,
        "]": 57,
        "}": 1197,
        ">": 25137
    ]
    let score2: [Character: Int] = [
        "(": 1,
        "[": 2,
        "{": 3,
        "<": 4
    ]

    let lines: [String]
    public init(input: String) {
        self.lines = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
    }

    public func part1() -> Int {
        lines
            .compactMap(findCorruptCharacter(in:))
            .map { score[$0]! }
            .reduce(0,+)
    }

    public func findCorruptCharacter(in line: String) -> Character? {
        var stack = Stack<Character>()
        for c in line {
            if "([{<".contains(c) {
                stack.push(c)
            } else {
                guard let o = stack.pop(), c.isPair(with: o) else {
                    return c
                }
            }
        }
        return nil
    }

    public func part2() -> Int {
        let scores = lines
            .filter { findCorruptCharacter(in: $0) == nil }
            .map { findCompletionScore(in: $0) }
            .sorted()

        return scores[scores.count / 2]
    }

    public func findCompletionScore(in line: String) -> Int {
        var stack = Stack<Character>()
        for c in line {
            if "([{<".contains(c) {
                stack.push(c)
            } else {
                _ = stack.pop()
            }
        }
        return stack.reduce(0) { sum, ch in
            sum * 5 + score2[ch]!
        }
    }
}

extension Character {
    func isPair(with other: Character) -> Bool {
        if self == "(" { return other == ")" }
        if self == ")" { return other == "(" }
        if self == "[" { return other == "]" }
        if self == "]" { return other == "[" }
        if self == "{" { return other == "}" }
        if self == "}" { return other == "{" }
        if self == "<" { return other == ">" }
        if self == ">" { return other == "<" }
        return false
    }
}
