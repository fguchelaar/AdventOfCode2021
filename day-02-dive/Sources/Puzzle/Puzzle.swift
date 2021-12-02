import AdventKit
import Foundation

public class Puzzle {
    let input: [(command: String, x: Int)]
    public init(input: String) {
        self.input = input.array(separatedBy: .newlines) {
            let parts = $0.split(separator: " ")
            return (String(parts[0]), Int(parts[1])!)
        }
    }

    public func part1() -> Int {
        var h = 0, d = 0
        for i in input {
            switch i.command {
            case "forward":
                h += i.x
            case "down":
                d += i.x
            default:
                d -= i.x
            }
        }
        return h * d
    }

    public func part2() -> Int {
        var h = 0, d = 0, aim = 0
        for i in input {
            switch i.command {
            case "forward":
                h += i.x
                d += aim * i.x
            case "down":
                aim += i.x
            default:
                aim -= i.x
            }
        }
        return h * d
    }
}
