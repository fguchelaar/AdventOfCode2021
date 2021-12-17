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
            height: abs(values[2] - values[3]) + 1
        )
    }

    public func part1() -> Int {
        var maxHeight = Int.min
        let minX = getMinimalXVelocity()
        for y in 0...Int(abs(target.minY)) {
            for x in minX...Int(target.minX) {
                let v = CGPoint(x: x, y: y)
                if let height = findHeight(velocity: v) {
                    maxHeight = max(height, maxHeight)
                }
            }
        }
        return maxHeight
    }

    public func part2() -> Int {
        var hits = Set<CGPoint>()
        let minX = getMinimalXVelocity()
        for y in Int(target.minY)...Int(abs(target.minY)) {
            for x in minX...Int(target.maxX) {
                let v = CGPoint(x: x, y: y)
                if isHit(velocity: v) {
                    hits.insert(v)
                }
            }
        }
        return hits.count
    }

    // based on the target's minX, finds the miminum x-velocity to even reach the target
    func getMinimalXVelocity() -> Int {
        Int(sqrt(target.minX * 2))
    }

    func findHeight(velocity: CGPoint) -> Int? {
        var p = CGPoint.zero
        var v = velocity
        var maxHeight = Int.min
        while true {
            p = p + v
            maxHeight = max(maxHeight, Int(p.y))
            if target.contains(p) {
                return maxHeight
            }

            v.x = max(v.x - 1, 0)
            v.y = v.y - 1

            // overshot, or no speed left to reach it
            if p.x > target.maxX || v.x == 0, p.x < target.minX {
                return nil
            }

            // will drop below the target
            if p.y + v.y < target.minY {
                return nil
            }
        }
    }

    func isHit(velocity: CGPoint) -> Bool {
        findHeight(velocity: velocity) == nil ? false : true
    }
}
