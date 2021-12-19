//
//  Position.swift
//
//
//  Created by Frank Guchelaar on 19/12/2021.
//

import Foundation

struct Position {
    static var zero: Position {
        Position(0, 0, 0)
    }

    let x: Int
    let y: Int
    let z: Int

    init(_ string: String) {
        let c = string.components(separatedBy: ",").compactMap(Int.init)
        self.x = c[0]
        self.y = c[1]
        self.z = c[2]
    }

    init(_ x: Int, _ y: Int, _ z: Int) {
        self.x = x
        self.y = y
        self.z = z
    }

    func translate(by other: Position) -> Position {
        Position(x + other.x, y + other.y, z + other.z)
    }

    func difference(to other: Position) -> Position {
        Position(other.x - x, other.y - y, other.z - z)
    }

    func manhatton(to other: Position) -> Int {
        abs(other.x - x) + abs(other.y - y) + abs(other.z - z)
    }

    func add(to other: Position) -> Position {
        Position(x + other.x, y + other.y, z + other.z)
    }

    var inverted: Position {
        Position(x * -1, y * -1, z * -1)
    }

    var allRotations: [Position] {
        [
            Position(+x, +y, +z),
            Position(+x, -z, +y),
            Position(+x, -y, -z),
            Position(+x, +z, -y),
            Position(-x, -y, +z),
            Position(-x, +z, +y),
            Position(-x, +y, -z),
            Position(-x, -z, -y),
            Position(+y, +z, +x),
            Position(+y, -x, +z),
            Position(+y, -z, -x),
            Position(+y, +x, -z),
            Position(-y, -z, +x),
            Position(-y, +x, +z),
            Position(-y, +z, -x),
            Position(-y, -x, -z),
            Position(+z, +x, +y),
            Position(+z, -y, +x),
            Position(+z, -x, -y),
            Position(+z, +y, -x),
            Position(-z, -x, +y),
            Position(-z, +y, +x),
            Position(-z, +x, -y),
            Position(-z, -y, -x)
        ]
    }
}

extension Position: Hashable {}

extension Position: CustomStringConvertible {
    var description: String {
        "x: \(x), y: \(y), z: \(z)"
    }
}
