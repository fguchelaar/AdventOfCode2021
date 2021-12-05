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
        let dx = from.x == to.x ? 0 : from.x < to.x ? 1 : -1
        let dy = from.y == to.y ? 0 : from.y < to.y ? 1 : -1
        var points = [Point]()
        var current = from
        points.append(current)
        while current != to {
            current = Point(x: current.x + dx, y: current.y + dy)
            points.append(current)
        }
        return points
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
        var diagram = [Point: Int]()

        for line in lines.filter({ $0.isVertical || $0.isHorizontal }) {
            for point in line.pointsOnLine {
                diagram[point, default: 0] += 1
            }
        }

        return diagram
            .filter { $0.value > 1 }
            .count
    }

    public func part2() -> Int {
        var diagram = [Point: Int]()

        for line in lines {
            for point in line.pointsOnLine {
                diagram[point, default: 0] += 1
            }
        }

        return diagram
            .filter { $0.value > 1 }
            .count
    }
}
