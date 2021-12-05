import AdventKit
import Foundation

// MARK: - Line

struct Line {
    let from: Point
    let to: Point

    var isHorizontal: Bool {
        from.y == to.y
    }

    var isVertical: Bool {
        from.x == to.x
    }

    var pointsOnLine: [Point] {
        let dx = (to.x - from.x).signum()
        let dy = (to.y - from.y).signum()

        return (0 ... max(abs(to.x - from.x), abs(to.y - from.y))).map { i in
            Point(x: from.x + dx * i, y: from.y + dy * i)
        }
    }
}

// MARK: - Puzzle

public class Puzzle {
    let lines: [Line]
    public init(input: String) {
        lines =
            input.trimmingCharacters(in: .whitespacesAndNewlines)
                .components(separatedBy: .newlines)
                .compactMap {
                    let parts = $0.components(separatedBy: " -> ")
                    guard let from = Point(string: parts[0]),
                          let to = Point(string: parts[1])
                    else {
                        return nil
                    }
                    return Line(from: from, to: to)
                }
    }

    public func part1() -> Int {
        return lines
            .filter { $0.isVertical || $0.isHorizontal }
            .flatMap { $0.pointsOnLine }
            .reduce(into: [Point: Int]()) { d, point in
                d[point, default: 0] += 1
            }
            .filter { $0.value > 1 }
            .count
    }

    public func part2() -> Int {
        return lines
            .flatMap { $0.pointsOnLine }
            .reduce(into: [Point: Int]()) { d, point in
                d[point, default: 0] += 1
            }
            .filter { $0.value > 1 }
            .count
    }
}
