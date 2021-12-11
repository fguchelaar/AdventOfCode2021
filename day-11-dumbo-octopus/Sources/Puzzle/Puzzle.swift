import AdventKit
import AppKit
import Foundation

extension Int {
    init?(_ ch: Character) {
        guard let i = Int(String(ch)) else {
            return nil
        }
        self = i
    }
}

extension Point {
    func n8() -> [Point] {
        (-1 ... 1).flatMap { dy in
            (-1 ... 1).map { dx in
                Point(x: x + dx, y: y + dy)
            }
        }
    }
}

extension Dictionary where Key == Point, Value == Int {
    mutating func step() -> Int {
        var toFlash = self.keys.reduce(into: Set<Point>()) { points, point in
            self[point]! += 1
            if self[point]! > 9 {
                points.insert(point)
            }
        }

        var didFlash = Set<Point>()
        while !toFlash.isEmpty {
            toFlash.forEach { point in
                didFlash.insert(toFlash.remove(point)!)
                point.n8().forEach { n in
                    if self.keys.contains(n) {
                        self[n]! += 1
                        if self[n]! > 9, !didFlash.contains(n) {
                            toFlash.insert(n)
                        }
                    }
                }
            }
        }
        didFlash.forEach { point in
            self[point] = 0
        }

        return didFlash.count
    }
}

public class Puzzle {
    let grid: [Point: Int]
    public init(input: String) {
        self.grid = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .enumerated()
            .reduce(into: [Point: Int]()) { map, line in
                line.element.compactMap(Int.init).enumerated().forEach { energy in
                    map[Point(x: energy.offset, y: line.offset)] = energy.element
                }
            }
    }

    public func part1() -> Int {
        var grid = self.grid
        return (0 ..< 100).reduce(0) { c, _ in
            c + grid.step()
        }
    }

    public func part2() -> Int {
        var grid = self.grid
        for step in 1 ... Int.max {
            if grid.step() == grid.count {
                return step
            }
        }
        return -1
    }
}
