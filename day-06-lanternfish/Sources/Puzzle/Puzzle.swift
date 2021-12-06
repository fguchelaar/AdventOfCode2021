import AdventKit
import Foundation

public class Puzzle {
    let input: [Int]
    public init(input: String) {
        self.input = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: ",")
            .compactMap(Int.init)
    }

    func solve(for days: Int) -> Int {
        var fish = input.reduce(into: [Int: Int]()) { d, i in
            d[i, default: 0] += 1
        }

        for _ in 0..<days {
            let newFish = fish[0, default: 0]
            for i in 1..<9 {
                fish[i - 1] = fish[i, default: 0]
            }
            fish[6, default: 0] += newFish
            fish[8] = newFish
        }

        return fish.values.reduce(0,+)
    }

    public func part1() -> Int {
        solve(for: 80)
    }

    public func part2() -> Int {
        solve(for: 256)
    }
}
