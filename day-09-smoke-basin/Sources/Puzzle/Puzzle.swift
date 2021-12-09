import AdventKit
import Foundation

public class Puzzle {
    let map: [[Int]]
    public init(input: String) {
        map = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .map { $0.map { Int(String($0))! } }
    }

    public func part1() -> Int {
        findLowPoints().reduce(0) { s, p in
            s + map[p.y][p.x] + 1
        }
    }

    func findLowPoints() -> [Point] {
        var lowPoints: [Point] = []
        for y in 0 ..< map.count {
            for x in 0 ..< map[y].count {
                let c = map[y][x]
                var lowest = true

                if y != 0 {
                    lowest = lowest && (map[y - 1][x] > c)
                }
                if x < map[y].count - 1 {
                    lowest = lowest && (map[y][x + 1] > c)
                }
                if y != map.count - 1 {
                    lowest = lowest && (map[y + 1][x] > c)
                }
                if x != 0 {
                    lowest = lowest && (map[y][x - 1] > c)
                }

                if lowest { lowPoints.append(Point(x: x, y: y)) }
            }
        }
        return lowPoints
    }

    public func part2() -> Int {
        findLowPoints()
            .map { floodFill(into: Set<Point>(), from: $0).count }
            .sorted()
            .suffix(3)
            .reduce(1, *)
    }

    func floodFill(into points: Set<Point>, from: Point) -> Set<Point> {
        guard map[from.y][from.x] != 9 else {
            return points
        }

        var points = points
        points.insert(from)

        [Point(x: from.x, y: from.y - 1),
         Point(x: from.x + 1, y: from.y),
         Point(x: from.x, y: from.y + 1),
         Point(x: from.x - 1, y: from.y)]
            .filter { !points.contains($0)
                && $0.x >= 0
                && $0.y >= 0
                && $0.x < map[0].count
                && $0.y < map.count
            }
            .forEach {
                points = points.union(floodFill(into: points, from: $0))
            }

        return points
    }
}
