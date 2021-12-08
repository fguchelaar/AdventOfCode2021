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
                .map { String($0.sorted()) }
                .map { String(map[$0]!) }
                .joined())!
            sum += digits
        }
        return sum
    }

    func deduce(patterns: [String]) -> [String: Int] {
        var map = patterns.joined().reduce(into: [Character: Int]()) { m, _c in
            m[_c] = m[_c, default: 0] + 1
        }

        // 1. find the first three, based on occurences
        let b = map.first(where: { $0.value == 6 })!.key
        map.removeValue(forKey: b)

        let e = map.first(where: { $0.value == 4 })!.key
        map.removeValue(forKey: e)

        let f = map.first(where: { $0.value == 9 })!.key
        map.removeValue(forKey: f)

        // 2. position 'a' is the remaining Character from '7', after removing the two segments from the '1' digit, which is the only one with two segments
        let _2 = patterns.first(where: { $0.count == 2 })!
        let a: Character = patterns.first(where: { $0.count == 3 })!.first(where: { !_2.contains($0) })!
        map.removeValue(forKey: a)

        // 3. now there is only one position left with an occurence of eight; that's 'c'
        let c = map.first(where: { $0.value == 8 })!.key
        map.removeValue(forKey: c)

        // 4. there are 2 segments left to find: 'd' and 'g'. Both segments occur seven times in all digits. But only
        // one of them is in the digit '4'; 'd'. Subtract the already found ones from '4' (bdcf), that's 'd'
        let d: Character = patterns
            .first(where: { $0.count == 4 })!
            .first(where: { ![b, c, f].contains($0) })!

        // 5. Now only one candidate is remaining and that's 'g'
        let g: Character = "abcdefg".first(where: { ![a, b, c, d, e, f].contains($0) })!

        // make a map with all segments sorted, for easy matching
        return [
            String([a, b, c, e, f, g].sorted()): 0,
            String([c, f].sorted()): 1,
            String([a, c, d, e, g].sorted()): 2,
            String([a, c, d, f, g].sorted()): 3,
            String([b, c, d, f].sorted()): 4,
            String([a, b, d, f, g].sorted()): 5,
            String([a, b, d, e, f, g].sorted()): 6,
            String([a, c, f].sorted()): 7,
            String([a, b, c, d, e, f, g].sorted()): 8,
            String([a, b, c, d, f, g].sorted()): 9,
        ]
    }
}
