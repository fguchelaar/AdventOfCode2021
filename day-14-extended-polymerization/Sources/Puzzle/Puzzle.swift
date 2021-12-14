import AdventKit
import Foundation

public class Puzzle {
    let template: String
    let rules: [String: Character]

    public func part1() -> Int {
        step(times: 10)
    }

    public func part2() -> Int {
        step(times: 40)
    }

    public init(input: String) {
        let parts = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: "\n\n")

        template = parts[0]
        rules = parts[1]
            .components(separatedBy: .newlines)
            .reduce(into: [:]) { map, line in
                let pair = line.components(separatedBy: " -> ")
                map[pair[0]] = Character(pair[1])
            }
    }

    func step(times: Int) -> Int {
        let initialPairs =
            zip(template.dropLast(), template.dropFirst())
                .map { "\($0)\($1)" }

        var elementCount = template.reduce(into: [:]) { $0[$1, default: 0] += 1 }
        var pairCount = initialPairs.reduce(into: [:]) { $0[$1, default: 0] += 1 }

        for _ in 0 ..< times {
            pairCount = pairCount.reduce(into: [:]) { map, pair in
                if let element = rules[pair.key] {
                    map["\(pair.key[0])\(element)", default: 0] += pair.value
                    map["\(element)\(pair.key[1])", default: 0] += pair.value
                    elementCount[element, default: 0] += pair.value
                }
            }
        }

        let min = elementCount.min { $0.value < $1.value }!.value
        let max = elementCount.max { $0.value < $1.value }!.value

        return (max - min)
    }
}
