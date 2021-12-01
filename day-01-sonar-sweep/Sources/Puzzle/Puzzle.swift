import AdventKit
import Foundation

public class Puzzle {
    let input: [Int]
    public init(input: String) {
        self.input = input.intArray
    }

    public func part1() -> Int {
        var x = 0
        for i in 1 ..< input.count {
            if input[i] > input[i - 1] {
                x += 1
            }
        }
        return x
    }

    public func part2() -> Int {
        var x = 0
        for i in 3 ..< input.count {
            let w1 = input[i - 3] + input[i - 2] + input[i - 1]
            let w2 = input[i - 2] + input[i - 1] + input[i]

            if w2 > w1 {
                x += 1
            }
        }
        return x
    }
}
