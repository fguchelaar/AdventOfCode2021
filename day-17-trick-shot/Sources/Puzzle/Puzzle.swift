import AdventKit
import Foundation

extension CGPoint {
    static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}

extension CGPoint: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}

extension String {
    func matches(pattern: String) -> [String] {
        let regex = try! NSRegularExpression(pattern: pattern)
        let range = NSRange(startIndex..., in: self)
        let matches = regex.matches(in: self, range: range)
        return matches.map { String(self[Range($0.range, in: self)!]) }
    }
}

public class Puzzle {
    var target: CGRect!

    public init(input: String) {
        let values = input.matches(pattern: #"(-?\d+)"#).compactMap(Int.init)
        target = CGRect(
            x: values[0],
            y: values[2],
            width: abs(values[0] - values[1]) + 1,
            height: abs(values[2] - values[3]) + 1)
    }

    public func part1() -> Int {
        var heights = Set<Int>()
        for y in 0...Int(abs(target.minY)) {
            for x in 1...Int(target.minX) {
                let v = CGPoint(x: x, y: y)
                if let height = findHeight(velocity: v) {
                    heights.insert(height)
                }
            }
        }

        return heights.max()!
    }

    public func part2() -> Int {
        var hits = Set<CGPoint>()
        for y in Int(target.minY)...Int(abs(target.minY)) {
            for x in 1...Int(target.maxX) {
                let v = CGPoint(x: x, y: y)
                if isHit(velocity: v) {
                    hits.insert(v)
                }
            }
        }

        return hits.count
    }

    func findHeight(velocity: CGPoint) -> Int? {
        var s = CGPoint(x: 0, y: 0)
        var v = velocity
        var maxHeight = Int.min
        for _ in 1... {
            s = s + v
            maxHeight = max(maxHeight, Int(s.y))
            if target.contains(s) {
                return maxHeight
            }

            v.x = max(v.x - 1, 0)
            v.y = v.y - 1

            if v.x == 0, s.x < target.minX || s.x > target.maxX {
                return nil
            }
            if s.y < target.minY {
                return nil
            }
            if s.y + v.y < target.minY {
                return nil
            }
        }
        return nil
    }

    func isHit(velocity: CGPoint) -> Bool {
        findHeight(velocity: velocity) == nil ? false : true
    }
}
