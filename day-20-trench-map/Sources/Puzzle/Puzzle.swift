import AdventKit
import AppKit
import Foundation

extension Point {
    var n9: [Point] {
        [
            Point(x: x-1, y: y-1),
            Point(x: x, y: y-1),
            Point(x: x+1, y: y-1),
            Point(x: x-1, y: y),
            Point(x: x, y: y),
            Point(x: x+1, y: y),
            Point(x: x-1, y: y+1),
            Point(x: x, y: y+1),
            Point(x: x+1, y: y+1),
        ]
    }
}

public class Puzzle {
    let imageEnhancementAlgorithm: [Character]
    let image: [Point: Character]

    var topLeft = Point.zero
    var bottomRight = Point.zero

    public init(input: String) {
        let parts = input.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: "\n\n")

        imageEnhancementAlgorithm = parts[0].map { $0 == "#" ? "1" : "0" }
        var image = [Point: Character]()
        for row in parts[1].components(separatedBy: .newlines).enumerated() {
            for column in String(row.element).enumerated() {
                let x = column.offset
                let y = row.offset
                image[Point(x: x, y: y)] = column.element == "#" ? "1" : "0"
                bottomRight = Point(x: max(bottomRight.x, x), y: max(bottomRight.y, y))
            }
        }

        self.image = image
    }

    func enhance(iterations: Int) -> Int {
        var img = image
        let expand = iterations * 2 - 1
        for _ in 0 ..< iterations {
            var tempImg = [Point: Character]()

            for y in (topLeft.y-expand)...(bottomRight.y+expand) {
                for x in (topLeft.x-expand)...(bottomRight.x+expand) {
                    let point = Point(x: x, y: y)
                    let value = Int(point.n9.map { String(img[$0, default: "0"]) }.joined(), radix: 2)!

                    tempImg[point] = imageEnhancementAlgorithm[value]
                }
            }

            img = tempImg
        }

        let tl = Point(x: topLeft.x-iterations, y: topLeft.y-iterations)
        let br = Point(x: bottomRight.x+iterations, y: bottomRight.y+iterations)
        return img
            .filter { $0.value == "1"
                && $0.key.x >= tl.x && $0.key.x <= br.x
                && $0.key.y >= tl.y && $0.key.y <= br.y
            }
            .count
    }

    public func part1() -> Int {
        return enhance(iterations: 2)
    }

    public func part2() -> Int {
        return enhance(iterations: 50)
    }
}
