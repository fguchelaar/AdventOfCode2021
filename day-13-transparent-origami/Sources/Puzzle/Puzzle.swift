import AdventKit
import Foundation

public class Puzzle {
    var dots: Set<Point>!
    var instructions: [Point]!

    var input: String
    public init(input: String) {
        self.input = input
        parseInput()
    }

    func parseInput() {
        let parts = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: "\n\n")

        dots = parts[0]
            .components(separatedBy: .newlines)
            .reduce(into: Set<Point>()) { s, l in
                let c = l.components(separatedBy: ",").compactMap(Int.init)
                let point = Point(x: c[0], y: c[1])
                s.insert(point)
            }

        instructions = parts[1]
            .components(separatedBy: .newlines)
            .map { line in
                let v = Int(line.split(separator: "=")[1])!
                if line.contains("x") {
                    return Point(x: v, y: 0)
                } else {
                    return Point(x: 0, y: v)
                }
            }
    }

    func fold(paper: Set<Point>, along point: Point) -> Set<Point> {
        var _paper = paper
        if point.x == 0 {
            _paper
                .filter { $0.y > point.y }
                .forEach { target in
                    let delta = (target.y - point.y) * 2
                    _paper.remove(target)
                    _paper.insert(Point(x: target.x, y: target.y - delta))
                }
        } else {
            _paper
                .filter { $0.x > point.x }
                .forEach { target in
                    let delta = (target.x - point.x) * 2
                    _paper.remove(target)
                    _paper.insert(Point(x: target.x - delta, y: target.y))
                }
        }
        return _paper
    }

    func toString(paper: Set<Point>) -> String {
        let maxXY: (x: Int, y: Int) = paper.reduce((0, 0)) { m, point in
            (max(m.0, point.x), max(m.1, point.y))
        }
        var result = [String]()
        for y in 0...maxXY.y {
            var line = ""
            for x in 0...maxXY.x {
                line += paper.contains(Point(x: x, y: y)) ? "#" : "."
            }
            result.append(line)
        }
        return result.joined(separator: "\n")
    }

    public func part1() -> Int {
        fold(paper: dots, along: instructions[0]).count
    }

    public func part2() -> String {
        let paper = instructions.reduce(dots) { _paper, instruction in
            fold(paper: _paper, along: instruction)
        }
        return toString(paper: paper)
    }
}
