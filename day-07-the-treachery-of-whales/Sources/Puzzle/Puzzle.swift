import AdventKit
import Foundation

public class Puzzle {
    let positions: [Int]
    var cache = [Int: Int]()

    public init(input: String) {
        self.positions = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: ",")
            .compactMap(Int.init)
    }

    public func part1() -> Int {
        var leastFuel = Int.max
        for target in positions {
            var neededFuel = 0
            for crab in positions {
                neededFuel += abs(target - crab)
                if neededFuel > leastFuel {
                    break
                }
            }
            leastFuel = min(leastFuel, neededFuel)
        }
        return leastFuel
    }

    public func part2() -> Int {
        var leastFuel = Int.max
        let sorted = positions.sorted()
        for target in sorted.first! ... sorted.last! {
            var neededFuel = 0
            for crab in positions {
                let distance = abs(target - crab)
                neededFuel += fuel(for: distance)
                if neededFuel > leastFuel {
                    break
                }
            }
            leastFuel = min(leastFuel, neededFuel)
        }
        return leastFuel
    }

    func fuel(for distance: Int) -> Int {
        distance * (distance + 1) / 2
    }
}
