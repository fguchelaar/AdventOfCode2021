import AdventKit
import Foundation

struct Point3d {
    let x: Int
    let y: Int
    let z: Int
    init(_ x: Int, _ y: Int, _ z: Int) {
        self.x = x
        self.y = y
        self.z = z
    }
}

extension Point3d: Hashable {}

extension String {
    func matches(pattern: String) -> [String] {
        let regex = try! NSRegularExpression(pattern: pattern)
        let range = NSRange(startIndex..., in: self)
        let matches = regex.matches(in: self, range: range)
        return matches.map { String(self[Range($0.range, in: self)!]) }
    }

    func ranges(pattern: String) -> [Range<String.Index>] {
        let regex = try! NSRegularExpression(pattern: pattern)
        let range = NSRange(startIndex..., in: self)
        let matches = regex.matches(in: self, range: range)
        return matches.map { Range($0.range, in: self)! }
    }
}

public class Puzzle {
    let instructions: [String]
    public init(input: String) {
        self.instructions = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
    }

    public func part1() -> Int {
        var cubes = Set<Point3d>()

        for step in instructions {
            let turnOn = step.starts(with: "on")
            let ints = step
                .matches(pattern: #"-?\d+"#)
                .compactMap(Int.init)

            if let range = ranges(ints: ints, capped: 50) {
                for x in range[0] {
                    for y in range[1] {
                        for z in range[2] {
                            let p3 = Point3d(x, y, z)
                            if turnOn {
                                cubes.insert(p3)
                            } else {
                                cubes.remove(p3)
                            }
                        }
                    }
                }
            }
        }
        return cubes.count
    }

    func ranges(ints: [Int], capped by: Int = Int.max) -> [ClosedRange<Int>]? {
        for i in 0 ..< 3 {
            if ints[i] < -by || ints[i] > by, ints[i+1] < -by || ints[i+1] > by {
                return nil
            }
        }

        let xr = max(ints[0], -by)...min(ints[1], by)
        let yr = max(ints[2], -by)...min(ints[3], by)
        let zr = max(ints[4], -by)...min(ints[5], by)

        return [xr, yr, zr]
    }

    public func part2() -> Int {
        var cubes = Set<Point3d>()

        for step in instructions {
            let turnOn = step.starts(with: "on")
            let ints = step
                .matches(pattern: #"-?\d+"#)
                .compactMap(Int.init)

            if let range = ranges(ints: ints) {
                for x in range[0] {
                    for y in range[1] {
                        for z in range[2] {
                            let p3 = Point3d(x, y, z)
                            if turnOn {
                                cubes.insert(p3)
                            } else {
                                cubes.remove(p3)
                            }
                        }
                    }
                }
            }
        }
        return cubes.count
    }
}
