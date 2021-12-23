import Foundation

struct Cube: Hashable {
    let minX: Int
    let maxX: Int
    let minY: Int
    let maxY: Int
    let minZ: Int
    let maxZ: Int

    var xRange: ClosedRange<Int> { minX...maxX }
    var yRange: ClosedRange<Int> { minY...maxY }
    var zRange: ClosedRange<Int> { minZ...maxZ }

    var volume: Int {
        xRange.count * yRange.count * zRange.count
    }

    init(_ minX: Int, _ maxX: Int, _ minY: Int, _ maxY: Int, _ minZ: Int, _ maxZ: Int) {
        self.minX = minX
        self.maxX = maxX
        self.minY = minY
        self.maxY = maxY
        self.minZ = minZ
        self.maxZ = maxZ
    }

    func constrained(to other: Cube) -> Cube? {
        intersection(with: other)
    }

    func intersection(with other: Cube) -> Cube? {
        guard let x = xRange.intersect(other: other.xRange),
              let y = yRange.intersect(other: other.yRange),
              let z = zRange.intersect(other: other.zRange)
        else {
            return nil
        }

        return Cube(x.lowerBound, x.upperBound,
                    y.lowerBound, y.upperBound,
                    z.lowerBound, z.upperBound)
    }
}

public extension ClosedRange {
    func intersect(other: ClosedRange) -> ClosedRange? {
        guard upperBound >= other.lowerBound else {
            return nil
        }
        guard other.upperBound >= lowerBound else {
            return nil
        }
        let s = other.lowerBound > lowerBound ? other.lowerBound : lowerBound
        let e = other.upperBound < upperBound ? other.upperBound : upperBound
        return s...e
    }
}
